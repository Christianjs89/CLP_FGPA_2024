library IEEE;
use IEEE.std_logic_1164.all;

-- DESCRIPTION
-- MULTIPLEXOR 2x1

-- ENTITY
entity mux21 is
	-- GENERICS 
	
	-- PORTS IN/OUT
	port(
		-- inputs
		a_i : in std_logic;
		b_i : in std_logic;
		select_i: in std_logic;
		-- outputs
		out_o : out std_logic
	);
end mux21;

-- ARCHITECTURE	
architecture mux21_arq of mux21 is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	out_o <= (not select_i and a_i) or (select_i and b_i);
end architecture mux21_arq;
