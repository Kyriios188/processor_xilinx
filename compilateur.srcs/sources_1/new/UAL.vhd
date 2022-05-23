----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 13:14:13
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( B : in STD_LOGIC_VECTOR (7 downto 0);
           A : in STD_LOGIC_VECTOR (7 downto 0);
           O : out STD_LOGIC; --overflow
           N : out STD_LOGIC; --negative
           Z : out STD_LOGIC; --zero
           C : out STD_LOGIC; --carry
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR(7 downto 0));
end UAL;

architecture Behavioral of UAL is

signal S_add : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_add_9 : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
signal S_sous : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_mul8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_mul16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal S_aux : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

signal S_or : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_and : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_not : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal S_div : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    O <= '1' when (S_mul16 (15 downto 8) /= "00") else '0';
    
    S_or <= A OR B;
    S_and <= A AND B;
    S_not <= NOT A;
    
    S_div <= std_logic_vector(signed(A) / signed(B)) when B /= "00000000";
    
    S_add_9 <= ("0" & A) + ("0" & B);
    S_add <= S_add_9(7 downto 0);
    
    S_sous <= std_logic_vector(abs(signed(A) - signed(B)));
    N <= '1' when A < B else '0';
    
    
    C <= S_add_9(8);
    
    S_mul16 <= A * B;
    S_mul8 <= S_mul16(7 downto 0);
    
    
    S_aux <= S_add when Ctrl_Alu = "001" else
         S_mul8 when Ctrl_Alu = "010" else
         S_sous when Ctrl_Alu = "011" else
         S_div when Ctrl_Alu = "100" else
         S_and when Ctrl_Alu = "101" else
         S_or when Ctrl_Alu = "110" else
         S_not when Ctrl_Alu = "111";
         
    --TODO AND, OR, NOT, DIV
    
    S <= S_aux;
    
    Z <= '1' when S_aux = "00000000" else '0';
    
end Behavioral;
