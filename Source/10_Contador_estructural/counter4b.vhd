library IEEE;
use IEEE.std_logic_1164.all;

entity counter4b is
    port(
        -- inputs
        EN  : in std_logic;
        RST : in std_logic;
        CLK : in std_logic;
        -- outputs
        Q   : out std_logic_vector(3 downto 0)
    );
end entity counter4b;

architecture counter4b_arq of counter4b is

    component ffd is
        port(
            -- inputs
            D_i : in std_logic;
            E_i : in std_logic;
            RST_i: in std_logic;
            CLK_i : in std_logic;
            -- outputs		
            Q_o: out std_logic	);
    end component ffd;

    signal D_aux : std_logic_vector(3 downto 0) := (others => '0'); -- ffd inputs, xor outputs
    signal Q_aux : std_logic_vector(3 downto 0) := (others => '0'); -- internal Q output signals
    signal EN_aux : std_logic_vector(3 downto 0) := (others => '0'); -- internal and enable signals


begin
	-- connect input to internal signals
	EN_aux(0) <= EN;
	-- connect outputs to internal signals
	Q <= Q_aux;	

	D_aux(0) <= Q_aux(0) xor EN_aux(0);
	-- instance 0, Q0
    ffd_0 : ffd
        port map(  D_i => D_aux(0), E_i => '1' , RST_i => RST, CLK_i => CLK , Q_o => Q_aux(0)  );
	
	EN_aux(1) <= EN_aux(0) and Q_aux(0); 
	D_aux(1) <= Q_aux(1) xor EN_aux(1);
	-- instance 1, Q1	
	ffd_1 : ffd
		port map(  D_i => D_aux(1), E_i => '1' , RST_i => RST, CLK_i => CLK , Q_o => Q_aux(1)  );

	EN_aux(2) <= EN_aux(1) and Q_aux(1); 
	D_aux(2) <= Q_aux(2) xor EN_aux(2);
	-- instance 2, Q2
	ffd_2 : ffd
		port map(  D_i => D_aux(2), E_i => '1' , RST_i => RST, CLK_i => CLK , Q_o => Q_aux(2)  );
		
	EN_aux(3) <= EN_aux(2) and Q_aux(2); 
	D_aux(3) <= Q_aux(3) xor EN_aux(3);
	-- instance 3, Q3
	ffd_3 : ffd
		port map(  D_i => D_aux(3), E_i => '1' , RST_i => RST, CLK_i => CLK , Q_o => Q_aux(3)  );		


end architecture counter4b_arq;
