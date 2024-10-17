
library IEEE;
use IEEE.std_logic_1164.all;

entity char_command is
	port(
		clk_rx:			in std_logic;					-- Clock input
		rst_clk_rx:		in std_logic;					-- Active HIGH reset - synchronous to clk_rx
		btn_clk_rx:		in std_logic;					-- Button to swap low and high pins
		rx_data:		in std_logic_vector(7 downto 0);-- 8 bit data output
		rx_data_rdy:	in std_logic;					-- valid when rx_data_rdy is asserted
		char_data:		out std_logic_vector(7 downto 0)-- The char output
	);
end;


architecture char_command_arq of char_command is
	signal old_rx_data_rdy: std_logic;

begin

	process(clk_rx)
	begin
		if rising_edge(clk_rx) then
			if rst_clk_rx = '1' then
				old_rx_data_rdy <= '0';
				char_data       <= "00000000";				
			else
				-- Capture the value of rx_data_rdy for edge detection
				old_rx_data_rdy <= rx_data_rdy;
				-- If rising edge of rx_data_rdy, capture rx_data
				if (rx_data_rdy = '1' and old_rx_data_rdy = '0') then
					char_data <= rx_data;	
				end if;							
			end if;	-- if !rst
		end if;
		
	end process;
end;

