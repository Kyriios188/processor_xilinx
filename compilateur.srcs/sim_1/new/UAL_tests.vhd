----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 13:51:31
-- Design Name: 
-- Module Name: UAL_tests - Behavioral
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
use IEEE.std_logic_signed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;

entity UAL_tests is
end UAL_tests;

architecture Behavioral of UAL_tests is

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

signal A_test : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal B_test : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_test : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal Ctrl_Alu_test : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal O_test : STD_LOGIC := '0';
signal C_test : STD_LOGIC := '0';
signal Z_test : STD_LOGIC := '0';
signal N_test : STD_LOGIC := '0';
signal CK_test : STD_LOGIC := '0';

constant CK_test_period : time := 10ns;

begin
Label_uut: UAL PORT MAP (
    A => A_test,
    B => B_test,
    S => S_test,
    Ctrl_Alu => Ctrl_Alu_test,
    O => O_test,
    C => C_test,
    Z => Z_test,
    N => N_test
);

Clock_process : process
begin
    CK_test <= not(CK_test);
    wait for CK_test_period/2;
end process;


A_test <= "01110101";
B_test <= "00000110";
Ctrl_Alu_test <= "100" after 10ns;

end Behavioral;
