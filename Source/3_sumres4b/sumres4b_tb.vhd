library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity sumres4b_tb is
	-- testbench no in/puts/outputs
end sumres4b_tb;

-- TESTBENCH ARCHITECTURE	
architecture sumres4b_arq_tb of sumres4b_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES
	
	-- tb signals, variables
	constant bitSize_tb : natural := 4;
	
	signal a_tb  : std_logic_vector(bitSize_tb-1 downto 0) := (others =>'0');
	signal b_tb  : std_logic_vector(bitSize_tb-1 downto 0) := (others =>'0');
	--signal ci_tb : std_logic := '0'; -- initialize w/no carry in
	signal sr_tb  : std_logic := '1'; -- initialize  sr_i=0 sum, sr_i=1 subtraction
	signal s_tb  : std_logic_vector(bitSize_tb-1 downto 0);
	signal co_tb : std_logic;

	-- tb components
	component sumres4b is
		port(
			-- inputs
			aNsr_i : in std_logic_vector(bitSize_tb-1 downto 0);
			bNsr_i : in std_logic_vector(bitSize_tb-1 downto 0);
			--ciNsr_i: in std_logic;
			sr_i   : in std_logic; -- sum/sub select
			-- outputs
			sNsr_o : out std_logic_vector(bitSize_tb-1 downto 0);
			coNsr_o: out std_logic
		);
	end component sumres4b;
	

	
-- tb architecture behavior 
begin
	sr_tb  <= not sr_tb after 160 ns;
	-- variables, signals behavior (mysignal <= '1' after x ns)
	a_tb(0) <= not a_tb(0) after 10 ns;
	a_tb(1) <= not a_tb(1) after 20 ns;
	a_tb(2) <= not a_tb(2) after 40 ns;
	a_tb(3) <= not a_tb(3) after 80 ns;
	
	b_tb(0) <= not b_tb(0) after 20 ns;
	b_tb(1) <= not b_tb(1) after 40 ns;
	b_tb(2) <= not b_tb(2) after 80 ns;
	b_tb(3) <= not b_tb(3) after 160 ns;
	
	--a_tb  <= "0011";
	--b_tb  <= "0001";
	--sr_tb  <= '0' after 160 ns ;	
	--ci_tb <= '0';
	
	
	-- component instance, connect signals (port map a=>a_tb, )
	sumres4b_inst1 : sumres4b
	generic map(
		bitSize => bitSize_tb
	)
	port map(
		aNsr_i  => a_tb,
		bNsr_i  => b_tb,
		--ciNsr_i => ci_tb,
		sr_i 	=> sr_tb,
		sNsr_o  => s_tb,
		coNsr_o => co_tb		
	);
	
end sumres4b_arq_tb;
