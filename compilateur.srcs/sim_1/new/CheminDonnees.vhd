----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:19:22
-- Design Name: 
-- Module Name: CheminDonnees - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CheminDonnees is
end CheminDonnees;


architecture Behavioral of CheminDonnees is


COMPONENT BancRegistres
    Port ( -- Banc Registres
           CLK : in STD_LOGIC;
           addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;


COMPONENT UAL
    Port ( B : in STD_LOGIC_VECTOR (7 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           O : out STD_LOGIC;
           C : out STD_LOGIC;
           Z : out STD_LOGIC;
           N : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;




COMPONENT BancMemoire
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           input : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(7 downto 0));
end COMPONENT;


COMPONENT BancInstructions
    Port ( output : out STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

-- SIGNAL GLOBAL
signal CLK_test : std_logic := '0';

-- SIGNAUX BANC DE REGISTRES
signal QA_BR : std_logic_vector(7 downto 0) := (others => '0');
signal QB_BR : std_logic_vector(7 downto 0) := (others => '0');
signal RST_BR : std_logic := '1';



-- SIGNAUX UAL
signal S_test_UAL : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal O_test_UAL : STD_LOGIC := '0';
signal C_test_UAL : STD_LOGIC := '0';
signal Z_test_UAL : STD_LOGIC := '0';
signal N_test_UAL : STD_LOGIC := '0';
signal CK_test_UAL : STD_LOGIC := '0';

-- SIGNAUX Banc Mémoire
signal RST_BM_test : std_logic := '1';
signal output_BM_test : std_logic_vector(7 downto 0) := (others => '0');



-- SIGNAUX Banc Instructions
signal output_BI_test : std_logic_vector(31 downto 0) := (others => '0');
signal addr_BI_test : std_logic_vector(7 downto 0) := "00000000";


-- SIGNAUX PIPELINE LIDI
signal A_PPL_out_LIDI : std_logic_vector(3 downto 0) := (others => '0');
signal B_PPL_out_LIDI : std_logic_vector(7 downto 0) := (others => '0');
signal C_PPL_out_LIDI : std_logic_vector(7 downto 0) := (others => '0');
signal OP_PPL_out_LIDI : std_logic_vector(3 downto 0) := (others => '0');

-- SIGNAUX PIPELINE DIEX 
signal A_DIEX_out : std_logic_vector(3 downto 0) := (others => '0');
signal B_DIEX_out : std_logic_vector(7 downto 0) := (others => '0');
signal C_DIEX_out : std_logic_vector(7 downto 0) := (others => '0');
signal OP_DIEX_out : std_logic_vector(3 downto 0) := (others => '0');

-- SIGNAUX PIPELINE EXMEM 
signal A_EXMEM_out : std_logic_vector(3 downto 0) := (others => '0');
signal B_EXMEM_out : std_logic_vector(7 downto 0) := (others => '0');
signal OP_EXMEM_out : std_logic_vector(3 downto 0) := (others => '0');


-- SIGNAUX PIPELINE MEMRE
signal A_MEMRE_out : std_logic_vector(3 downto 0) := (others => '0');
signal B_MEMRE_out : std_logic_vector(7 downto 0) := (others => '0');
signal OP_MEMRE_out : std_logic_vector(3 downto 0) := (others => '0');

-- SIGNAL SORTIE LC MEMRE
signal calc_W : std_logic := '0';
signal calc_ctrl_alu : std_logic_vector(2 downto 0) := (others => '0');
signal calc_BM : std_logic := '1'; --par défaut, lecture du banc de mémoire.

-- MUX ONE
signal mux_BR : std_logic_vector(7 downto 0) := (others => '0');
signal mux_ALU : std_logic_vector(7 downto 0) := (others => '0');
signal mux_BM_load : std_logic_vector(7 downto 0) := (others => '0');
signal mux_BM_store : std_logic_vector(7 downto 0) := (others => '0');


constant CLK_period : time := 10ns;

begin

Label_bm: BancMemoire PORT MAP (
    addr => mux_BM_store,
    input => B_EXMEM_out,
    RW => calc_BM,
    RST => RST_BM_test,
    output => output_BM_test,
    CLK => CLK_test
);

Label_br: BancRegistres PORT MAP (
    addr_A => B_PPL_out_LIDI(3 downto 0),
    addr_B => C_PPL_out_LIDI(3 downto 0),
    addr_W => A_MEMRE_out(3 downto 0),
    QA => QA_BR,
    QB => QB_BR,
    DATA => B_MEMRE_out,
    W => calc_W,
    RST => RST_BR,
    CLk => CLK_test
);

Label_ual: UAL PORT MAP (
    A => B_DIEX_out,
    B => C_DIEX_out,
    S => S_test_UAL,
    Ctrl_Alu => calc_ctrl_alu,
    O => O_test_UAL,
    C => C_test_UAL,
    Z => Z_test_UAL,
    N => N_test_UAL
);

Label_bi: BancInstructions PORT MAP (
    output => output_BI_test,
    addr => addr_BI_test,
    CLK => CLK_test
);




-- LC APRES MEMRE--
-- NE PRENDS PAS EN COMPTE LES OP INCONNUES
-- NO OP = 0 0 0 0 ==> si opcode = 0 alors on ne fais que lire
calc_W <=  '0' when (OP_MEMRE_out="1000" or OP_MEMRE_out="0000") else '1';


-- LC ALU
-- convertit des op code en [add, mul, sou, div, ou, non, et]
calc_ctrl_alu <=  OP_DIEX_out(2 downto 0) when (OP_DIEX_out="0001" or OP_DIEX_out="0010" or
                                    OP_DIEX_out="0011" or OP_DIEX_out="0100") else
                  "101" when (OP_DIEX_out="1001") else -- and
                  "110" when (OP_DIEX_out="1010") else -- or
                  "111" when (OP_DIEX_out="1011"); -- not
                  

-- écriture si STORE sinon lecture (inclut LOAD)
calc_BM <=  '0' when (OP_EXMEM_out="1000") else '1';




-- MUX Banc Registre
mux_BR <= B_PPL_out_LIDI when (OP_PPL_out_LIDI="0110" or OP_PPL_out_LIDI="0111") else
               QA_BR;
               
               
-- MUX BM_load
-- on veut Donnée[B] et non R[B] quand ya LOAD
mux_BM_load <= output_BM_test when OP_EXMEM_out="0111" else
           B_EXMEM_out;

-- MUX BM_store
-- pour STORE l'adresse d'écriture est donnée par A et pas par B
-- A_EXMEM_OUT est sur 4 bits, on ajoute du padding
mux_BM_store <=  STD_LOGIC_VECTOR(RESIZE(UNSIGNED(A_EXMEM_out), 8)) when OP_EXMEM_out="1000" else
           B_EXMEM_out;

-- MUX UAL
mux_ALU <= S_test_UAL when (OP_DIEX_out="0001" or OP_DIEX_out="0010" or
                            OP_DIEX_out="0011" or OP_DIEX_out="0100" or
                            OP_DIEX_out="1001" or OP_DIEX_out="1010" or
                            OP_DIEX_out="1011") else
           B_DIEX_out;










lidi_pipeline : process
    begin
    
    wait until rising_edge(CLK_test);
        -- Entrée de LIDI = sortie de Banc Instruction
        A_PPL_out_LIDI <= output_BI_test(3 downto 0);
        OP_PPL_out_LIDI <= output_BI_test(11 downto 8);
        B_PPL_out_LIDI <= output_BI_test(23 downto 16);
        C_PPL_out_LIDI <= output_BI_test(31 downto 24);
        

    end process;
 
diex_pipeline : process
     begin
     
     wait until rising_edge(CLK_test);
         -- Entrée de LIDI = sortie de Banc Instruction
         A_DIEX_out <= A_PPL_out_LIDI;
         B_DIEX_out <= mux_BR;
         C_DIEX_out <= QB_BR;
         OP_DIEX_out <= OP_PPL_out_LIDI;
 
    end process;
 
 exmem_pipeline : process
      begin
      
      wait until rising_edge(CLK_test);
          -- Entrée de LIDI = sortie de Banc Instruction
          A_EXMEM_out <= A_DIEX_out;
          B_EXMEM_out <= mux_ALU;
          OP_EXMEM_out <= OP_DIEX_out;
  
    end process;
 
  memre_pipeline : process
      begin
      
      wait until rising_edge(CLK_test);
          -- Entrée de LIDI = sortie de Banc Instruction
          A_MEMRE_out <= A_EXMEM_out;
          B_MEMRE_out <= mux_BM_load;
          OP_MEMRE_out <= OP_EXMEM_out;
  
    end process;


Clock_process : process
    begin
        CLK_test <= not(CLK_test);
        wait for CLK_period/2;
    end process;


addr_BI_test <= "00000001" after 20ns;


-- 
--B_PPL_out_LIDI <= "00000011" after 60ns;

end Behavioral;
