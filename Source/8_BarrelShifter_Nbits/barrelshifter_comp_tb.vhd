library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity barrelshifter_comp_tb is
	-- testbench no in/puts/outputs
end barrelshifter_comp_tb;

-- TESTBENCH ARCHITECTURE	
architecture barrelshifter_comp_arq_tb of barrelshifter_comp_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES
	constant bitSize : natural := 8;
	constant shiftSize : natural := 3;
	
	-- tb components
	component barrelshifter_comp is
		generic( 
			bitSize : natural;
			shiftSize : natural ); -- despSize**2 = bitSize
		-- PORTS IN/OUT
		port(
			-- inputs
			DIN : in std_logic_vector(bitSize-1 downto 0);		
			SHIFT: in std_logic_vector(shiftSize-1 downto 0);
			-- outputs		
			DOUT: out std_logic_vector(bitSize-1 downto 0)
		);
	end component barrelshifter_comp;
	
	-- tb signals
	signal DIN_tb  : std_logic_vector(bitSize-1 downto 0);
	signal DOUT_tb : std_logic_vector(bitSize-1 downto 0) := (others => '0');
	signal SHIFT_tb: std_logic_vector(shiftSize-1 downto 0);
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	DIN_tb <= "11000000" after 5 ns, "00000000" after 20 ns, "00000011" after 25 ns;
	SHIFT_tb <= "001" after 5 ns, "100" after 10 ns, "011" after 15 ns, "001" after 25 ns, "100" after 30 ns, "011" after 35 ns;
	
	-- component instance, connect signals (port map a=>a_tb, )
	barrelshifter_inst : barrelshifter_comp
	generic map( bitsize => 8, shiftSize => 3)
	port map(
		DIN => DIN_tb,
		SHIFT => SHIFT_tb,
		DOUT => DOUT_tb 
	);

	
end barrelshifter_comp_arq_tb;
