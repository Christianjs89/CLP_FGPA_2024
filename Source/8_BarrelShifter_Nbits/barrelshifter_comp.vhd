library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Barrel shifter por comportamiento


-- ENTITY
entity barrelshifter_comp is
	-- GENERICS 
	generic( 
		bitSize : natural := 8;
		shiftSize : natural := 3 ); -- 2**shiftSize = bitSize
	-- PORTS IN/OUT
	port(
		-- inputs
		DIN : in std_logic_vector(bitSize-1 downto 0);		
		SHIFT: in std_logic_vector(shiftSize-1 downto 0);
		-- outputs		
		DOUT: out std_logic_vector(bitSize-1 downto 0)
	);
		
end entity barrelshifter_comp;


-- ARCHITECTURE	
architecture barrelshifter_comp_arq of barrelshifter_comp is
-- FUNCTIONS

-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS
	
-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	
	p: process(DIN, SHIFT)
		variable shiftCount : integer;
		variable data : std_logic_vector(bitSize-1 downto 0) := (others => '0');

	begin
		
		shiftCount := to_integer(unsigned(SHIFT));	
		report "###### shiftCount = " & integer'image(shiftCount);
		
		data := DIN;
		g: for i in 0 to (bitSize-1) loop
			report "*************** i= " & integer'image(i) & "*************** ";
			if ((i+shiftCount) > (bitSize-1) ) then
				DOUT(i) <= data(i+shiftCount-bitSize);
				report "data(" & integer'image(i) & ") <= data(" & integer'image(i+shiftCount-bitSize) & ")";
			else 
				DOUT(i) <= data(i+shiftCount);	
				report "data(" & integer'image(i) & ") <= data(" & integer'image(i+shiftCount) & ")";					
			end if;
			
			if data(i) = '1' then 
				report "data(" & integer'image(i) & ") = 1";
			else
				report "data(" & integer'image(i) & ") = 0";
			end if;
			
		end loop g;

	end process p;
				
end barrelshifter_comp_arq;
