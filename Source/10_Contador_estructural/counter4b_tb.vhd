library IEEE;
use IEEE.std_logic_1164.all;

entity counter4b_tb is
end entity counter4b_tb;

architecture counter4b_arq_tb of counter4b_tb is

	component counter4b is
    port(
        -- inputs
        EN  : in std_logic;
        RST : in std_logic;
        CLK : in std_logic;
        -- outputs
        Q   : out std_logic_vector(3 downto 0)
    );	
	end component;

	-- testbench signals
	signal en_tb, rst_tb, clk_tb : std_logic := '0';
	signal q_tb : std_logic_vector(3 downto 0) ;

begin
	
	en_tb <= '1' after 10 ns;
	clk_tb <= not clk_tb after 5 ns;
	rst_tb <= '1' after 1 ns, '0' after 10 ns, '1' after 200 ns;
	
	counter_instance : counter4b
	port map(
		EN => en_tb,
		RST => rst_tb,
		CLK => clk_tb,
		Q => q_tb
	);


end architecture counter4b_arq_Tb;
