library IEEE;
use IEEE.std_logic_1164.all;

-- Shift register por comportamiento


-- ENTITY
entity shiftreg_comp is
	-- GENERICS 
	generic( bitSize : natural := 4);
	-- PORTS IN/OUT
	port(
		-- inputs
		DIN : in std_logic;
		EN : in std_logic;
		RST: in std_logic;
		CLK : in std_logic;
		-- outputs		
		DOUT: out std_logic
	);
		
end entity shiftreg_comp;


-- ARCHITECTURE	
architecture shiftreg_comp_arq of shiftreg_comp is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS
	signal data : std_logic_vector(bitSize-1 downto 0);
	
	
-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	
	--DOUT <= data(0);
	--data(3) <= DIN;
	
	shiftreg_process : process(CLK) -- count up to bitSize-1 and send input to output	
	begin
		
		if rising_edge(CLK) then		
			if RST = '1' then
				DOUT <= '0';
			elsif EN ='1' then	
				data(0) <= data(1);
				data(1) <= data(2);
				data(2) <= data(3);
				data(3) <= DIN;		
				DOUT <= data(0);
			end if;					
		end if;		
		
	end process shiftreg_process;
	
						
end shiftreg_comp_arq;
