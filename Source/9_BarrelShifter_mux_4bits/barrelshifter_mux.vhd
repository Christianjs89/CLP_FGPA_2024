library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Barrel shifter por comportamiento


-- ENTITY
entity barrelshifter_mux is
	-- GENERICS 
	generic( 
		bitSize : natural := 4;
		shiftSize : natural := 2 ); -- 2**shiftSize = bitSize
	-- PORTS IN/OUT
	port(
		-- inputs
		DIN : in std_logic_vector(bitSize-1 downto 0);		
		SHIFT: in std_logic_vector(shiftSize-1 downto 0);
		-- outputs		
		DOUT: out std_logic_vector(bitSize-1 downto 0)
	);
		
end entity barrelshifter_mux;


-- ARCHITECTURE	
architecture barrelshifter_mux_arq of barrelshifter_mux is
-- FUNCTIONS
	constant circular : boolean := true ; -- for circular shifter use true
	
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS
	component mux21 is
		-- PORTS IN/OUT
		port(
			-- inputs
			a_i : in std_logic;
			b_i : in std_logic;
			select_i: in std_logic;
			-- outputs
			out_o : out std_logic );
	end component mux21;

	-- interconnected SIGNALS
	signal m00_out, m01_out, m02_out, m03_out : std_logic := '0';
	signal d01, d12, d23 : std_logic := '0';

	
	
-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	
	M00 : mux21
	port map(
		a_i => DIN(0),
		b_i => d01,
		select_i => SHIFT(0),
		out_o => m00_out
	);
		
	d01 <= DIN(1);	
	M01 : mux21
		port map(
			a_i => d01,
			b_i => d12,
			select_i => SHIFT(0),
			out_o => m01_out
		);	
	
	
	d12 <= DIN(2);
	M02 : mux21
		port map(
			a_i => d12,
			b_i => d23,
			select_i => SHIFT(0),
			out_o => m02_out
		);	
	
	d23 <= DIN(3);
	
	a1 : if (circular = true) generate
		M03 : mux21
			port map(
				a_i => d23,
				b_i => DIN(0),
				select_i => SHIFT(0),
				out_o => m03_out
			);
	end generate a1;
	
	a2 : if (circular = false) generate
		M03 : mux21
			port map(
				a_i => d23,
				b_i => '0',
				select_i => SHIFT(0),
				out_o => m03_out
			);		
	end generate a2;
		
	-- Layer 2 SHIFT(1) --
	M10 : mux21
		port map(
			a_i => m00_out,
			b_i => m02_out,
			select_i => SHIFT(1),
			out_o => DOUT(0)
		);

	M11 : mux21
		port map(
			a_i => m01_out,
			b_i => m03_out,
			select_i => SHIFT(1),
			out_o => DOUT(1)
		);	

	b1 : if (circular = true) generate
		M12 : mux21
			port map(
				a_i => m02_out,
				b_i => m00_out,
				select_i => SHIFT(1),
				out_o => DOUT(2)
			);	
	end generate b1;

	b2 : if (circular = false) generate
		M12 : mux21
			port map(
				a_i => m02_out,
				b_i => '0',
				select_i => SHIFT(1),
				out_o => DOUT(2)
			);	
	end generate b2;
	



	c1: if (circular = true) generate
		M13 : mux21
			port map(
				a_i => m03_out,
				b_i => m01_out,
				select_i => SHIFT(1),
				out_o => DOUT(3)
			);		
	end generate c1;
	
	c2: if (circular = false) generate
		M13 : mux21
			port map(
				a_i => m03_out,
				b_i => '0',
				select_i => SHIFT(1),
				out_o => DOUT(3)
			);		
	end generate c2;
				
end barrelshifter_mux_arq;


