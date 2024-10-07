library IEEE;
use IEEE.std_logic_1164.all;

-- ENTITY
entity ffd is
	-- GENERICS 
	
	-- PORTS IN/OUT
	port(
		-- inputs
		D_i : in std_logic;
		E_i : in std_logic;
		RST_i: in std_logic;
		CLK_i : in std_logic;
		-- outputs		
		Q_o: out std_logic	);
end ffd;

-- ARCHITECTURE	

-- Synchronous RESET
architecture ffd_arq_sync of ffd is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	flipflop1 : process(CLK_i)
	begin
		if rising_edge(CLK_i) then
			if RST_i = '1' then -- synchronous reset
				Q_o <= '0';
			elsif E_i = '1' then 
				Q_o <= D_i;
			else
				Q_o <= '0';
			end if;
		end if;		
	end process flipflop1;
						
end ffd_arq_sync;

-- Asynchronous RESET
architecture ffd_arq_async of ffd is
-- GENERICS: INTERNAL AUX SIGNALS, VARIABLES, COMPONENTS

-- BEHAVIOR: BEHAVIORAL (sequential process), DATAFLOW (gates), STRUCTURAL (component instantiation)
begin
	flipflop2 : process(CLK_i, RST_i)
	begin		
			if RST_i = '1' then -- synchronous reset
				Q_o <= '0';
			elsif rising_edge(CLK_i) then	
				if E_i = '1' then 
					Q_o <= D_i;
				else
					Q_o <= '0';
				end if;
			end if;
		
	end process flipflop2;

						
end ffd_arq_async;
