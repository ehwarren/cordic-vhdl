----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:46:48 06/23/2014 
-- Design Name: 
-- Module Name:    CORDIC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CORDIC is
    Port ( mode : in  STD_LOGIC_VECTOR(1 downto 0);
           op : in  STD_LOGIC;
           start : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clock : in  STD_LOGIC;
           x : out  STD_LOGIC_VECTOR(31 downto 0);
           y : out  STD_LOGIC_VECTOR(31 downto 0);
           z : out  STD_LOGIC_VECTOR(31 downto 0);
           done : out  STD_LOGIC);
end CORDIC;

architecture Behavioral of CORDIC is
signal inx,iny,inz,theta : STD_LOGIC_VECTOR(31 downto 0);
signal i : STD_LOGIC_VECTOR(4 downto 0);
signal enM,enALU,addSub,wr : STD_LOGIC;
signal mOut : STD_LOGIC_VECTOR(1 downto 0);
begin
--instantiate the Controller
	CONT1 : entity Controller port map(clock,mode,op,start,reset,inx,iny,inz,mOut,enM,wr,i,done);
--instantiate the ALU
	ALU1 : entity ALU port map(inx,iny,inz,i,theta,reset,enALU,addSub,clock,x,y,z);
--instantiate the ROM
	ROM1 : entity ROM port map(clock,mOut,enM,i,theta);
--instantiate the RegisterBank
	REGBANK1 : entity RegisterBank port map(clock,wr,enM,inx,iny,inz,x,y,z);

end Behavioral;

