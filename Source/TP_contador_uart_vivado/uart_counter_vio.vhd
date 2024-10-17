
library IEEE;
use IEEE.std_logic_1164.all;

entity uart_counter_vio is
	port(
		clk_i: in std_logic;		-- Clock input (from pin)
		rxd_i: in std_logic
	);
end;
	

architecture uart_counter_vio_arq of uart_counter_vio is

	constant count_bitsize : integer := 8;
	constant clock_freq : integer := 125E6;
	constant bps : integer := 115200;

	component uart_counter is
		generic(
			BAUD_RATE: integer;  
			CLOCK_RATE: integer;
			COUNTER_BITSIZE : integer
		);
		port(
			clk_pin:	in std_logic;      					-- Clock input (from pin)
			rst_pin: 	in std_logic;      					-- Active HIGH reset (from pin)
			rxd_pin: 	in std_logic;      					-- RS232 RXD pin - directly from pin
			count_value : out std_logic_vector(count_bitsize-1 downto 0)
		);
	end component;	
	
	COMPONENT vio_0
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;
	
	signal probe_rst : std_logic_vector(0 downto 0);
	signal probe_count : std_logic_vector(count_bitsize-1 downto 0);

begin

	counter_inst : uart_counter
		generic map(
			BAUD_RATE		=> bps,
			CLOCK_RATE		=> clock_freq,
			COUNTER_BITSIZE => count_bitsize
		)
		port map(
			clk_pin		=> clk_i,  					-- Clock input (from pin)
			rst_pin		=> probe_rst(0),   					-- Active HIGH reset (from pin)
			rxd_pin		=> rxd_i,    					-- RS232 RXD pin - directly from pin
			count_value => probe_count
		);
		
		
	uart_counter_vio : vio_0
          PORT MAP (
            clk => clk_i,
            probe_in0 => probe_count,
            probe_out0 => probe_rst
          );
	
end;
