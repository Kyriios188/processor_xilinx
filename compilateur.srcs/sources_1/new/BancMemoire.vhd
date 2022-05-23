----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 11:46:25
-- Design Name: 
-- Module Name: BancMemoire - Behavioral
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

entity BancMemoire is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           input : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(7 downto 0));
end BancMemoire;

architecture Behavioral of BancMemoire is

signal memory : std_logic_vector(63 downto 0) := (others=>'0');

begin
    process
    begin
        wait until rising_edge(CLK);
        
        if (RST='0') then memory <= (others=>'0');
        
        elsif (RW='1') then
        output <= memory(to_integer(unsigned(addr))*8+7 downto to_integer(unsigned(addr))*8);
        
        else
        memory(to_integer(unsigned(addr))*8+7 downto to_integer(unsigned(addr))*8) <= input;
        
        end if;
        
    end process;

end Behavioral;
