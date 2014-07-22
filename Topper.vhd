----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:53 07/21/2014 
-- Design Name: 
-- Module Name:    Topper - Behavioral 
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
use work.ALL;
USE work.cordic_package.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Topper is
	port( 
			  mode : in  STD_LOGIC_VECTOR(1 downto 0);
           op : in  STD_LOGIC;
           start : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clock : in  STD_LOGIC;
			  bit_out : out  STD_LOGIC
	);

end Topper;




architecture Behavioral of Topper is
signal x, y, z : std_logic_vector(31 downto 0);
signal done: std_logic;
signal sel : STD_LOGIC_VECTOR(2 downto 0);
begin
	sel <= "010";
	
	CORDIC1 : entity CORDIC port map(mode, op, start, reset, clock, x, y, z, done);

	UART1 : entity parallel_2_serial port map(x, y, z, done, sel, clock, reset, bit_out);

end Behavioral;

