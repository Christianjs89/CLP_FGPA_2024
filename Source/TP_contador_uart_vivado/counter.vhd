-- COUNTER COMPONENT
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity counterRX is
	generic(
		CLOCK_RATE : integer := 125E6;
		BIT_SIZE   : integer := 8 -- upper limit UL = 2^n - 1
	);
	port(
		CLOCK      : in std_logic; -- physical clock signal
		COMMAND	   : in std_logic_vector(7 downto 0); -- ascii code received
		READY_FLAG : in std_logic;
		COUNT      : out std_logic_vector(BIT_SIZE-1 downto 0) -- count value from 0 to UL
	);

end;

architecture counter_arq of counterRX is

	signal cnt_aux : unsigned(BIT_SIZE-1 downto 0) := (others => '0');
	signal slow_clock : std_logic := '0';
	
begin

	COUNT <= std_logic_vector(cnt_aux);
	
	counter_process : process(slow_clock)	
	begin		
		if rising_edge(slow_clock) then			
			cnt_aux <= cnt_aux + 1;			
		end if;	
		COUNT <= std_logic_vector(cnt_aux);
	end process;
	
	
	clock_divider : process(CLOCK)
		variable ticks : integer range 0 to (CLOCK_RATE-1) := 0;
	begin
		if rising_edge(CLOCK) then
			if ticks = CLOCK_RATE-1 then
				slow_clock <= '1';
				ticks := 0;
			else
				slow_clock <= '0';
				ticks := ticks + 1;				
			end if;
		end if;
		
	end process;

end;