--test
library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;

entity test is
end;

architecture test_arq of test is
	signal a : std_logic_vector(7 downto 0) := (others => '0');
	signal b, clk : std_logic := '0';
begin
	clk <= not clk after 1 ns;
	--a <= std_logic_vector(5) after 10 ns, std_logic_vector(10) after 20 ns, std_logic_vector(50) after 40 ns;
	a <= x"10" after 5 ns, x"61" after 10 ns, x"70" after 20 ns;

	t : process (clk)	
	begin
		if rising_edge(clk) then
			if a = x"61" then
				b <= '1';
			else
				b <= '0';
			end if;
		end if;
	end process;
	
end;