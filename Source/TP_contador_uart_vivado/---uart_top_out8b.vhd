
library IEEE;
use IEEE.std_logic_1164.all;

entity uart_top is
	port(
		--Write side inputs
		clk_pin: in std_logic;		-- Clock input (from pin)
		rst_pin: in std_logic;		-- Active HIGH reset (from pin)
		--btn_pin: in std_logic;		-- Button to swap high and low bits
		rxd_pin: in std_logic; 		-- Uart input
		output_pins: out std_logic_vector(7 downto 0) -- 8 bit output ascii code
	);
end;
	

architecture uart_top_arq of uart_top is

	component uart_led is
		generic(
			BAUD_RATE: integer := 115200;   
			CLOCK_RATE: integer := 50E6
		);
		port(
			-- Write side inputs
			clk_pin:	in std_logic;      					-- Clock input (from pin)
			rst_pin: 	in std_logic;      					-- Active HIGH reset (from pin)
			--btn_pin: 	in std_logic;      					-- Button to swap high and low bits
			rxd_pin: 	in std_logic;      					-- RS232 RXD pin - directly from pin
			output_pins: 	out std_logic_vector(7 downto 0)    -- 8 LED outputs
		);
	end component;

begin

	U0: uart_led
		generic map(
			BAUD_RATE => 115200,
			CLOCK_RATE => 125E6
		)
		port map(
			clk_pin => clk_pin,  	-- Clock input (from pin)
			rst_pin => rst_pin,  	-- Active HIGH reset (from pin)
			--btn_pin => btn_pin,  	-- Button to swap high and low bits
			rxd_pin => rxd_pin,  	-- RS232 RXD pin - directly from pin
			output_pins => output_pins 	-- 8 LED outputs
		);
end;
