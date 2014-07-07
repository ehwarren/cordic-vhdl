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
signal ax,ay,az,rx,ry,rz,theta : STD_LOGIC_VECTOR(31 downto 0);
signal i : STD_LOGIC_VECTOR(4 downto 0);
signal addSub : STD_LOGIC;
signal mOut : STD_LOGIC_VECTOR(1 downto 0);
begin
--instantiate the Controller
	CONT1 : entity Controller port map(clock,mode,op,start,reset,rx,ry,rz,mOut,i,done,addSub,x,y,z);
--instantiate the ALU
	ALU1 : entity ALU port map(rx,ry,rz,i,theta,reset,addSub,ax,ay,az);
--instantiate the ROM
	ROM1 : entity ROM port map(mOut,i,theta);
--instantiate the RegisterBank
	REGBANK1 : entity RegisterBank port map(clock,reset,ax,ay,az,rx,ry,rz);

end Behavioral;

