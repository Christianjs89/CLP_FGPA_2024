library IEEE;
use IEEE.std_logic_1164.all;

-- TESTBENCH ENTITY 
entity barrelshifter_mux_tb is
	-- testbench no in/puts/outputs
end barrelshifter_mux_tb;

-- TESTBENCH ARCHITECTURE	
architecture barrelshifter_mux_arq_tb of barrelshifter_mux_tb is
	-- GENERICS:  TEST SIGNALS, VARIABLES, COMPONENT INSTANCES
	constant bitSize : natural := 4;
	constant shiftSize : natural := 2;
	
	-- tb components
	component barrelshifter_mux is
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
	end component barrelshifter_mux;
	
	-- tb signals
	signal DIN_tb  : std_logic_vector(bitSize-1 downto 0);
	signal DOUT_tb : std_logic_vector(bitSize-1 downto 0) := (others => '0');
	signal SHIFT_tb: std_logic_vector(shiftSize-1 downto 0);
	
-- tb architecture behavior 
begin
	-- variables, signals behavior (mysignal <= '1' after x ns)
	DIN_tb <= "1100" after 5 ns, "0000" after 20 ns, "0011" after 25 ns;
	SHIFT_tb <= "01" after 5 ns, "10" after 10 ns, "11" after 15 ns, "01" after 25 ns, "10" after 30 ns, "11" after 35 ns;
	
	-- component instance, connect signals (port map a=>a_tb, )
	barrelshifter_inst : barrelshifter_mux
	generic map( bitsize => 4, shiftSize => 2)
	port map(
		DIN => DIN_tb,
		SHIFT => SHIFT_tb,
		DOUT => DOUT_tb 
	);

	
end barrelshifter_mux_arq_tb;
