----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:57:29
-- Design Name: 
-- Module Name: BancInstructions - Behavioral
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

entity BancInstructions is
    Port ( output : out STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR (7 downto 0));
end BancInstructions;

architecture Behavioral of BancInstructions is

signal instructions : std_logic_vector(8191 downto 0) := (others=>'0'); -- 32 * 256 = 8192


begin

-- DANS R[2] ON MET ff
instructions(7 downto 0) <= "00000010";
instructions(15 downto 8) <= "00000110";
instructions(23 downto 16) <= "00000010";
instructions(31 downto 24) <= "00000000";

-- DANS R[3] on met R[2] + R[2]
instructions(39 downto 32) <= "00000010";
instructions(47 downto 40) <= "00000001";
instructions(55 downto 48) <= "00000010";
instructions(63 downto 56) <= "00000010";


    process
    begin
        wait until rising_edge(CLK);
        
        
        
        output <= instructions(to_integer(unsigned(addr))*32+31 downto to_integer(unsigned(addr))*32);
        
    end process;

end Behavioral;
