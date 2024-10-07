library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity sum4b_tb is
	-- testbench no in/puts/outputs
end sum4b_tb;

-- TESTBENCH ARCHITECTURE	
architecture sum4b_arq_tb of sum4b_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES
	
	-- tb signals, variables
	constant bitSize_tb : natural := 4;
	
	signal a_tb  : std_logic_vector(bitSize_tb-1 downto 0) := (others =>'0');
	signal b_tb  : std_logic_vector(bitSize_tb-1 downto 0) := (others =>'0');
	signal ci_tb : std_logic := '0'; -- no carry in
	signal s_tb  : std_logic_vector(bitSize_tb-1 downto 0);
	signal co_tb : std_logic;

	-- tb components
	component sum4b is
		port(
			-- inputs
			aN_i : in std_logic_vector(bitSize_tb-1 downto 0);
			bN_i : in std_logic_vector(bitSize_tb-1 downto 0);
			ciN_i: in std_logic;
			-- outputs
			sN_o : out std_logic_vector(bitSize_tb-1 downto 0);
			coN_o: out std_logic
		);
	end component sum4b;
	

	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	a_tb(0) <= not a_tb(0) after 10 ns;
	a_tb(1) <= not a_tb(1) after 20 ns;
	a_tb(2) <= not a_tb(2) after 40 ns;
	a_tb(3) <= not a_tb(3) after 80 ns;
	
	b_tb(0) <= not b_tb(0) after 10 ns;
	b_tb(1) <= not b_tb(1) after 20 ns;
	b_tb(2) <= not b_tb(2) after 40 ns;
	b_tb(3) <= not b_tb(3) after 80 ns;
	
	ci_tb  	<= not ci_tb after 5 ns;
	
	
	-- component instance, connect signals (port map a=>a_tb, )
	sum4b_inst1 : sum4b
	generic map(
		bitSize => bitSize_tb
	)
	port map(
		aN_i  => a_tb,
		bN_i  => b_tb,
		ciN_i => ci_tb,
		sN_o  => s_tb,
		coN_o => co_tb		
	);
	
end sum4b_arq_tb;
