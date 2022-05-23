----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 09:37:34
-- Design Name: 
-- Module Name: BancRegistres - Behavioral
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

entity BancRegistres is
    Port ( addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end BancRegistres;

architecture Behavioral of BancRegistres is

signal registres : std_logic_vector(127 downto 0) := (others=>'0');
signal aux_a : std_logic_vector(7 downto 0) := (others=>'0');
signal aux_b : std_logic_vector(7 downto 0) := (others=>'0');

begin
    process
    begin
        wait until rising_edge(CLK);

        if (RST='0') then registres <= (others=>'0');

        --W=1 : écriture ET lecture
        elsif (W='1') then 
        
            registres(to_integer(unsigned(addr_W))*8+7 downto to_integer(unsigned(addr_W))*8) <= DATA;
        
        end if;
        
    end process;
    
        QA <= DATA when (addr_A = addr_W and W='1') 
                   else registres(to_integer(unsigned(addr_A))*8+7 downto to_integer(unsigned(addr_A))*8);
                   
        QB <= DATA when (addr_B = addr_W and W='1') 
                   else registres(to_integer(unsigned(addr_B))*8+7 downto to_integer(unsigned(addr_B))*8);
    
    
end Behavioral;
