----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:23:17
-- Design Name: 
-- Module Name: BancRegistres_tests - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity BancsRegistres_tests is
end BancsRegistres_tests;



architecture Behavioral of BancsRegistres_tests is

COMPONENT BancRegistres
    Port ( addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;


--Input
signal addr_A_test : std_logic_vector(3 downto 0) := (others => '0');
signal addr_B_test : std_logic_vector(3 downto 0) := (others => '0');
signal addr_W_test : std_logic_vector(3 downto 0) := (others => '0');
signal QA_test : std_logic_vector(7 downto 0) := (others => '0');
signal QB_test : std_logic_vector(7 downto 0) := (others => '0');
signal DATA_test : std_logic_vector(7 downto 0) := (others => '0');
signal W_test : std_logic := '1';
signal RST_test : std_logic := '1';
signal CLK_test : std_logic := '0';

constant CLK_test_period : time := 10ns;

begin
Label_uut: BancRegistres PORT MAP (
    addr_A => addr_A_test,
    addr_B => addr_B_test,
    addr_W => addr_W_test,
    QA => QA_test,
    QB => QB_test,
    DATA => DATA_test,
    W => W_test,
    RST => RST_test,
    CLk => CLK_test
);

Clock_process : process
begin
    CLK_test <= not(CLK_test);
    wait for CLK_test_period/2;
end process;


addr_W_test <= "0001" after 0ns;
DATA_test <= "00000001" after 0ns;

addr_A_test <= "0011" after 0ns;
addr_B_test <= "0110" after 0ns;

W_test <= '0' after 10ns;

end Behavioral;
