library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY
entity shiftreg is
	-- GENERICS 
	generic ( 
		bitSize : natural := 4
	);
	-- PORTS IN/OUT
	port(
		-- inputs
		DIN : in std_logic;
		EN : in std_logic;
		RST: in std_logic;
		CLK : in std_logic;
		-- outputs		
		DOUT: out std_logic	);
		
end shiftreg;

-- ARCHITECTURE	


architecture shiftreg_arq of shiftreg is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS
	-- internal signals
	signal data : std_logic_vector(bitSize downto 0) := (others => '0'); -- DIN->data(0)->ffd0->data(1)->ffd1->data(2)->ffd2-> ... data(N)->ffdN->data(N+1)->DOUT
	
	-- components 
	-- ffd_inst : entity work.ffd(ffd_arq_sync) -- if it was called as component then YES delcare component here as "component ffd is ... end component; and then port map in begin ...
		-- port(
			----inputs
			-- D_i : in std_logic;
			-- E_i : in std_logic;
			-- RST_i: in std_logic;
			-- CLK_i : in std_logic;
			----outputs		
			-- Q_o: out std_logic	
		-- );
	

-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin

	-- instantiate bitSize flipflops
	flipflop_chain : for i in 0 to bitSize-1 generate
		ffd_inst : entity work.ffd(ffd_arq_sync) -- when instantiated directly as entity, it doesn't need to be declared like a component does
			port map(
				D_i => data(i),
				E_i => EN,
				RST_i => RST,
				CLK_i => CLK,
				Q_o => data(i+1) -- connect to following ffd > input for next ffd
			);	
	end generate flipflop_chain;
	
	-- connect main input signal and main output signal
	data(0) <= DIN;
	DOUT <= data(bitSize);

						
end shiftreg_arq;

