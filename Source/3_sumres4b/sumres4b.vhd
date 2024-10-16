library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY
entity sumres4b is
	-- GENERICS 
	generic(
		bitSize : natural := 4
	);
	
	-- PORTS IN/OUT
	port(
		-- inputs
		aNsr_i : in std_logic_vector(bitSize-1 downto 0);
		bNsr_i : in std_logic_vector(bitSize-1 downto 0);
		--ciNsr_i: in std_logic;
		sr_i   : in std_logic; -- sum/sub select
		-- outputs
		sNsr_o : out std_logic_vector(bitSize-1 downto 0);
		coNsr_o: out std_logic
	);
end entity sumres4b;

-- ARCHITECTURE	
architecture sumres4b_arq of sumres4b is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

	-- internal signal
	--signal sr_aux : std_logic_vector(bitSize-1 downto 0); -- create a bitmask with sr_i
	signal b_out  : std_logic_vector(bitSize-1 downto 0); 
	
	-- components
	component sum4b is
		port(
			-- inputs
			aN_i : in std_logic_vector(bitSize-1 downto 0);
			bN_i : in std_logic_vector(bitSize-1 downto 0);
			ciN_i: in std_logic;
			-- outputs
			sN_o : out std_logic_vector(bitSize-1 downto 0);
			coN_o: out std_logic
		);
	end component sum4b;
	
	
-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	
	get_b : for j in 0 to bitSize-1 generate
		b_out(j) <= sr_i xor bNsr_i(j);
	end generate get_b;
		
	bit4_sumres : sum4b 
		port map(
			aN_i  => aNsr_i,
			bN_i  => b_out,
			ciN_i => sr_i, 
			sN_o  => sNsr_o,
			coN_o => coNsr_o 
		);	
	
	
end architecture sumres4b_arq;
