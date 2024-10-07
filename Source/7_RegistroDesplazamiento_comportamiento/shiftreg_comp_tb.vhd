library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity shiftreg_comp_tb is
	-- testbench no in/puts/outputs
end shiftreg_comp_tb;

-- TESTBENCH ARCHITECTURE	
architecture shiftreg_comp_arq_tb of shiftreg_comp_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES
	constant bitSize : natural := 4;
	
	-- tb components
	component shiftreg_comp is
		generic ( bitSize : natural );
		-- PORTS IN/OUT
		port(
			-- inputs
			DIN : in std_logic;
			EN : in std_logic;
			RST: in std_logic;
			CLK : in std_logic;
			-- outputs		
			DOUT: out std_logic	);
	end component shiftreg_comp;
	
	-- tb signals
	signal DIN_tb  : std_logic;
	signal EN_tb : std_logic := '1';
	signal RST_tb : std_logic := '1';
	signal CLK_tb  : std_logic := '0';
	signal DOUT_tb : std_logic := '0';
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	--DIN_tb <= "1000";
	CLK_tb <= not CLK_tb after 5 ns;	
	DIN_tb <= '1' after 5 ns, '0' after 15 ns;
	RST_tb <= '0' after 1 ns;
	
	-- component instance, connect signals (port map a=>a_tb, )
	shiftreg_inst : shiftreg_comp
	generic map( bitsize => 4)
	port map(
		DIN => DIN_tb,
		EN  => EN_tb,
		RST => RST_tb,
		CLK => CLK_tb,
		DOUT => DOUT_tb 
	);

	
end shiftreg_comp_arq_tb;
