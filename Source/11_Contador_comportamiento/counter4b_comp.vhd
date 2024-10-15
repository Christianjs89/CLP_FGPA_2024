library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- arithmetic operations with unsigned/signed

entity counter4b_comp is
    port(
        -- inputs
        EN  : in std_logic;
        RST : in std_logic;
        CLK : in std_logic;
        -- outputs
        Q   : out std_logic_vector(3 downto 0)
    );
end entity counter4b_comp;

architecture counter4b_comp_arq of counter4b_comp is

	signal count : unsigned(3 downto 0) := (others => '0');

begin

	Q <= std_logic_vector(count);
	
	counter_process : process(CLK, RST)	
	begin
		if RST = '1' then
			count <= (others => '0');
		elsif rising_edge(CLK) then
			if EN = '1' then
				count <= count + 1;
			end if;
		end if;	
	end process counter_process;


end architecture counter4b_comp_arq;
