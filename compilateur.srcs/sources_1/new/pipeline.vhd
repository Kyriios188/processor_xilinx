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

entity pipeline is
    Port ( A_in : in STD_LOGIC_VECTOR (3 downto 0);
           B_in : in STD_LOGIC_VECTOR (7 downto 0);
           C_in : in STD_LOGIC_VECTOR (7 downto 0);
           OP_in : in STD_LOGIC_VECTOR (2 downto 0);
           CLK : in STD_LOGIC;
           A_out : out STD_LOGIC_VECTOR (3 downto 0);
           B_out : out STD_LOGIC_VECTOR (7 downto 0);
           C_out : out STD_LOGIC_VECTOR (7 downto 0);
           OP_out : out STD_LOGIC_VECTOR (2 downto 0));
end pipeline;



architecture Behavioral of pipeline is

begin

    process
    begin
    
        wait until rising_edge(CLK);
        
        A_out <= A_in;
        B_out <= B_in;
        C_out <= C_in;
        OP_out <= OP_in;

    end process;


end Behavioral;