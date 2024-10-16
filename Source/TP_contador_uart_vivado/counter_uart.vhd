-- UART COUNTER
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uart_counter is
	generic(
		BAUD_RATE: integer := 115200;  
		CLOCK_RATE: integer := 125E6;
		COUNTER_BITSIZE : integer := 8
	);
	port(
		-- Write side inputs
		clk_pin:	in std_logic;      									-- Clock input (from pin)
		rst_pin: 	in std_logic;      									-- Active HIGH reset (from pin)
		rxd_pin: 	in std_logic;      									-- RS232 RXD pin - directly from pin
		count_value : out std_logic_vector(COUNTER_BITSIZE-1 downto 0); -- N-bit current count value
		count_state : out std_logic_vector(7 downto 0)					-- current counter control state: UP, DOWN, PAUSE, RESET
	);
end;

architecture uart_counter_arq of uart_counter is

	-- declare components and signals to use
	component uart_rx is -- black box
		generic(
			BAUD_RATE: integer; 						-- these values are updated once it's instanciated
			CLOCK_RATE: integer
		);
		port(
			-- Write side inputs
			clk_rx: in std_logic;       				-- Clock input
			rst_clk_rx: in std_logic;   				-- Active HIGH reset - synchronous to clk_rx							
			rxd_i: in std_logic;        				-- RS232 RXD pin - Directly from pad
			rxd_clk_rx: out std_logic;					-- RXD pin after synchronization to clk_rx		
			rx_data: out std_logic_vector(7 downto 0);	-- 8 bit data output
														--  - valid when rx_data_rdy is asserted
			rx_data_rdy: out std_logic;  				-- Ready signal for rx_data
			frm_err: out std_logic       				-- The STOP bit was not detected	
		);
	end component;
	
	-- counter controlled by UART characters
	component counterRX is
	generic(
		CLOCK_RATE : integer := 125E6;					-- 
		BIT_SIZE   : integer := 8 						-- upper limit = 2^n - 1
		);
	port(
		CLOCK      : in std_logic;
		COMMAND	   : in std_logic_vector(7 downto 0); 	-- ascii code received
		READY_FLAG : in std_logic;
		COUNT      : out std_logic_vector(COUNTER_BITSIZE-1 downto 0);
		STATE      : out std_logic_vector(7 downto 0)
	);

	end component;
	
		
	signal rx_data: std_logic_vector(7 downto 0); 	-- Data output of uart_rx
	signal rx_data_rdy: std_logic;  				-- Data ready output of uart_rx
    signal rst_clk_rx: std_logic; -- dummy for now
    signal rx_pin_data : std_logic;
    signal state_value : std_logic_vector(7 downto 0); -- current counter state: up, down, etc.
    
begin

    rx_pin_data <= rxd_pin;

	-- UART instance to get the ascii command and the data ready flags
	uart_rx_i0: uart_rx 
		generic map(
			CLOCK_RATE 	=> CLOCK_RATE,
			BAUD_RATE  	=> BAUD_RATE
		)
		port map(
			clk_rx     	=> clk_pin,
			rst_clk_rx 	=> rst_clk_rx,	
			rxd_i      	=> rx_pin_data,
			rxd_clk_rx 	=> open,	
			rx_data_rdy	=> rx_data_rdy,
			rx_data    	=> rx_data,
			frm_err    	=> open
		);	
		
	
	counter_inst : counterRX
	generic map(
		CLOCK_RATE => CLOCK_RATE,
		BIT_SIZE   => COUNTER_BITSIZE
		)
	port map(
		CLOCK      => clk_pin,
		COMMAND	   => rx_data, 
		READY_FLAG => rx_data_rdy, 
		COUNT      => count_value,
		STATE      => state_value
	);
	
	count_state <= state_value; -- signal current state: UP, DOWN, PAUSE, RESET.
	

end;