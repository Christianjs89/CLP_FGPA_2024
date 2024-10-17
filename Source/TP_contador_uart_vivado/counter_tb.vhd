-- TIMER TESTBENCH
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counterRX_tb is
end;

architecture counterRX_arq_tb of counterRX_tb is

	constant clock_freq : integer := 1E3;
	constant countbit   : integer := 8;

	component counterRX is
	generic(
		CLOCK_RATE : integer;
		BIT_SIZE   : integer -- upper limit UL = 2^n - 1
	);
	port(
		CLOCK      : in std_logic; -- physical clock signal
		COMMAND	   : in std_logic_vector(7 downto 0); -- ascii code received
		READY_FLAG : in std_logic;
		COUNT      : out std_logic_vector(countbit-1 downto 0) -- count value from 0 to UL
	);
	end component;
	
	signal clock_tb, ready_tb : std_logic := '0';
	signal command_tb : std_logic_vector(7 downto 0) := (others => '0');
	signal count_tb : std_logic_vector(countbit-1 downto 0) := (others => '0');
	
	--variable clock_period_ns : integer := 1E9/(clock_freq * 2);

begin
	
	clock_tb <= not clock_tb after 500 ns;

	counter_inst : counterRX
	generic map(
		CLOCK_RATE => clock_freq,
		BIT_SIZE   => countbit -- upper limit UL = 2^n - 1
		)
	port map(
		CLOCK      => clock_tb,
		COMMAND	   => command_tb, --: in std_logic_vector(7 downto 0); -- ascii code received
		READY_FLAG => ready_tb, --: in std_logic;
		COUNT      => count_tb --: out std_logic_vector(BIT_SIZE-1 downto 0); -- count value from 0 to UL
	);


end architecture;
