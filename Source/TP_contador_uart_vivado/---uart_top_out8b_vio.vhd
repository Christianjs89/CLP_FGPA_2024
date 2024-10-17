
library IEEE;
use IEEE.std_logic_1164.all;

entity uart_top_vio is
	port(
		clk_i: in std_logic;		-- Clock input (from pin)
		rxd_i: in std_logic
	);
end;
	

architecture uart_top_vio_arq of uart_top_vio is

    component uart_top is
        port(
            --Write side inputs
            clk_pin: in std_logic;		-- Clock input (from pin)
            rst_pin: in std_logic;		-- Active HIGH reset (from pin)
            btn_pin: in std_logic;		-- Button to swap high and low bits
            rxd_pin: in std_logic; 		-- Uart input
            output_pins: out std_logic_vector(7 downto 0) -- 8 output pins representing ASCII character
        );
    end component;
    
    COMPONENT vio_0
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;

	signal probe_rst, probe_btn : std_logic_vector(0 downto 0);
	signal probe_output : std_logic_vector(7 downto 0);

begin

	U0: uart_top
		port map(
			clk_pin => clk_i,  		-- Clock input (from pin)
			rst_pin => probe_rst(0),  	-- Active HIGH reset (from pin)
			btn_pin => probe_btn(0),  	-- Button to swap high and low bits
			rxd_pin => rxd_i,  	-- RS232 RXD pin - directly from pin
			output_pins => probe_output 	-- 8 bits ascii
		);
		
    uart_vio_inst : vio_0
          PORT MAP (
            clk => clk_i,
            probe_in0 => probe_output, -- 8 bit ascii char
            probe_out0 => probe_rst,
            probe_out1 => probe_btn
          );
	
end;
