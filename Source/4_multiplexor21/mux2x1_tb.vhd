library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity mux21_tb is
	-- testbench no in/puts/outputs
end mux21_tb;

-- TESTBENCH ARCHITECTURE	
architecture mux21_arq_tb of mux21_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCE DECLARATION

	-- tb component declaration input/output ports
	component mux21 is
		port(
			-- inputs
			a_i : in std_logic;
			b_i : in std_logic;
			select_i: in std_logic;
			-- outputs
			out_o : out std_logic
		);
	end component mux21;
	
	-- tb signals
	signal a_tb  : std_logic := '0';
	signal b_tb  : std_logic := '0';
	signal select_tb : std_logic := '0';
	signal out_tb  : std_logic;
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns;)
	a_tb  <= not a_tb after 10 ns;
	b_tb  <= not b_tb after 20 ns;
	select_tb <= not select_tb after 40 ns;
	
	-- component instance (instanceID : entity or instance ID : entity workDir.entityName(architecture), connect signals (port map a=>a_tb, )
	mux21_inst1 : entity work.mux21(mux21_arq)
	port map(
		a_i  => a_tb,
		b_i  => b_tb,
		select_i => select_tb,
		out_o  => out_tb	
	);
	
end mux21_arq_tb;
