library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY
entity sum4b is
	-- GENERICS 
	generic(
		bitSize : natural := 4
	);
	
	-- PORTS IN/OUT
	port(
		-- inputs
		aN_i : in std_logic_vector(bitSize-1 downto 0);
		bN_i : in std_logic_vector(bitSize-1 downto 0);
		ciN_i: in std_logic;
		-- outputs
		sN_o : out std_logic_vector(bitSize-1 downto 0);
		coN_o: out std_logic
	);
end entity sum4b;

-- ARCHITECTURE	
architecture sum4b_arq of sum4b is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

	-- internal signal
	signal carry : std_logic_vector(bitSize downto 0) := (others => '0'); -- connect intermediate ci(N) to Co(N-1), and also 4adder main carry in and out (5 total)
	
	-- components
	component sum1b
		port(
		-- inputs
		a_i : in std_logic;
		b_i : in std_logic;
		ci_i: in std_logic;
		-- outputs
		s_o : out std_logic;
		co_o: out std_logic
	);
	end component sum1b;
	
	
-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin

	carry(0) <= ciN_i; -- connected to main 4adder carry in

	bit4_adder : for i in 0 to bitSize-1 generate
	
		-- adder 0 takes ci directly from the outside
		SUM0 : if (i = 0) generate
			bit0_adder : sum1b
				port map(
					a_i  => aN_i(i),
					b_i  => bN_i(i),
					ci_i => carry(i), -- previously connected to ciN_i
					s_o  => sN_o(i),
					co_o => carry(i+1) -- send carry out to next carry in (carry(1))
				);
		end generate SUM0;
		
		-- adder N takes ci(N) from Co(N-1)
		SUMN : if (i /= 0) generate
			bitN_adder : sum1b
			port map(
				a_i  => aN_i(i),
				b_i  => bN_i(i),
				ci_i => carry(i),
				s_o  => sN_o(i),
				co_o => carry(i+1)
			);
		end generate SUMN;
		
		-- CoN takes the carry out from adder N
		coN_o <= carry(bitSize);
	end generate bit4_adder;
	
end architecture sum4b_arq;
