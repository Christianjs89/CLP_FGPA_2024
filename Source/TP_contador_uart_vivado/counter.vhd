-- COUNTER COMPONENT
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity counterRX is
	generic(
		CLOCK_RATE : integer := 125E6;							-- Clock frequency in Hz
		BIT_SIZE   : integer := 8 								-- counter upper limit UL = 2^n - 1
	);
	port(
		CLOCK      : in std_logic; 								-- physical clock signal
		COMMAND	   : in std_logic_vector(7 downto 0); 			-- ascii character code received
		READY_FLAG : in std_logic;								-- character ready to read flag
		COUNT      : out std_logic_vector(BIT_SIZE-1 downto 0); -- count value from 0 to UL
		STATE      : out std_logic_vector(7 downto 0)			-- counter current state UP
	);

end;

architecture counter_arq of counterRX is

	signal cnt_aux : unsigned(BIT_SIZE-1 downto 0) := (others => '0'); 	-- counter auxiliar variable
	signal slow_clock : std_logic := '0'; 								-- reduced speed clock signal for counter
	signal old_ready : std_logic; 										-- data reception ready previous flag to compare with current and detect rising edge
	signal cnt_state : std_logic_vector(7 downto 0); 					-- ascii character to control the counter 'u', 'd', 'p', 'r'
	
begin
	
	COUNT <= std_logic_vector(cnt_aux); -- send count value to port
	STATE <= cnt_state; 				-- send count state to port
	
	-- Main counter control
	counter_process : process(slow_clock)	
	begin		
		-- check on each clock cicle the counter instruction
		if rising_edge(slow_clock) then			
			if cnt_state = x"75" then -- up
				cnt_aux <= cnt_aux + 1;	
			elsif cnt_state = x"64" then -- down
				cnt_aux <= cnt_aux - 1;	
			elsif cnt_state = x"72" then -- reset
				cnt_aux <= (others => '0');
			elsif cnt_state = x"70" then -- pause
				cnt_aux <= cnt_aux;
			end if;					
		end if;			
	end process;
	
	-- clock divider for main counter, reduce to 1 Hz
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
	
	-- process command to control counter: reset 'r' h72, count up 'u' h75, count down 'd' h64, pause 'p' h70
	parse_command : process(CLOCK)			 
	begin
		if rising_edge(CLOCK) then
			old_ready <= READY_FLAG;
			-- If rising edge of READY_FLAG, capture COMMAND
			if (READY_FLAG = '1' and old_ready = '0') then
				if COMMAND = x"64" OR COMMAND = x"70" OR COMMAND = x"72" OR COMMAND = x"75" then -- update state only if command is used
				    --STATE <= COMMAND; -- update counter state output
					cnt_state <= COMMAND; -- update state flag for counter control	
				end if;
			end if;					
		end if;	
	end process;

end;