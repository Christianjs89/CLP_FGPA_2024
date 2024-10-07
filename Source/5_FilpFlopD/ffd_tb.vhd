library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity ffd_tb is
	-- testbench no in/puts/outputs
end ffd_tb;

-- TESTBENCH ARCHITECTURE	
architecture ffd_arq_tb of ffd_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES

	-- tb components
	component ffd is
		port(
			-- inputs
			D_i : in std_logic;
			E_i : in std_logic;
			RST_i: in std_logic;
			CLK_i : in std_logic;
			-- outputs		
			Q_o: out std_logic 	);
	end component;
	
	-- tb signals
	signal D_tb  : std_logic := '0';
	signal E_tb : std_logic := '0';
	signal RST_tb : std_logic := '0';
	signal CLK_tb  : std_logic := '0';
	signal Q_tb : std_logic;
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	CLK_tb <= not CLK_tb after 5 ns;
	
	D_tb  <= not D_tb after 12 ns;
	E_tb  <= not E_tb after 58 ns;
	RST_tb <= not RST_tb after 97 ns;
	
	-- component instance, connect signals (port map a=>a_tb, )
	-- ffd_inst1 : ffd 
	ffd_inst : entity work.ffd(ffd_arq_async) -- use ffd_arq_async or ffd_arq_sync to use sync/async reset
	port map(
		D_i  => D_tb,
		E_i  => E_tb,
		RST_i => RST_tb,
		CLK_i  => CLK_tb,
		Q_o => Q_tb	);
	
end ffd_arq_tb;
