library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY
entity sum1b is
	-- GENERICS 
	
	-- PORTS IN/OUT
	port(
		-- inputs
		a_i : in std_logic;
		b_i : in std_logic;
		ci_i: in std_logic;
		-- outputs
		s_o : out std_logic;
		co_o: out std_logic
	);
end sum1b;

-- ARCHITECTURE	
architecture sum1b_arq of sum1b is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	s_o <= a_i xor b_i xor ci_i; -- sum out
	co_o <= (a_i and b_i) or (a_i and ci_i) or (b_i and ci_i); -- carry out
end sum1b_arq;
