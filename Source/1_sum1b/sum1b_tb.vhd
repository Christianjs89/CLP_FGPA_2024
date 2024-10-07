library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity sum1b_tb is
	-- testbench no in/puts/outputs
end sum1b_tb;

-- TESTBENCH ARCHITECTURE	
architecture sum1b_arq_tb of sum1b_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES

	-- tb components
	component sum1b is
		port(
		-- inputs
		a_i  : in std_logic;
		b_i  : in std_logic;
		ci_i : in std_logic;
		-- outputs
		s_o  : out std_logic;
		co_o : out std_logic
		);
	end component;
	
	-- tb signals
	signal a_tb  : std_logic := '0';
	signal b_tb  : std_logic := '0';
	signal ci_tb : std_logic := '0';
	signal s_tb  : std_logic;
	signal co_tb : std_logic;
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	a_tb  <= not a_tb after 20 ns;
	b_tb  <= not b_tb after 40 ns;
	ci_tb <= not ci_tb after 80 ns;
	
	-- component instance, connect signals (port map a=>a_tb, )
	sum_inst1 : sum1b
	port map(
		a_i  => a_tb,
		b_i  => b_tb,
		ci_i => ci_tb,
		s_o  => s_tb,
		co_o => co_tb		
	);
	
end sum1b_arq_tb;
