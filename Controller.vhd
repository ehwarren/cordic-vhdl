----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:51:33 05/26/2014 
-- Design Name: 
-- Module Name:    Controller - Behavioral 
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

entity Controller is

		Port ( clock : in std_logic;
				 mode	 : in std_logic_vector (1 downto 0); -- '00' is linear, '01' is circular, '10' hyperbolic, '11' is nothing
				 op	 : in std_logic; -- '0' rotation or '1' vectoring
				 start : in std_logic;
				 reset : in std_logic;
				 done	 : out std_logic
			  );

end Controller;

architecture Behavioral of Controller is

begin
	 process(clock)
	 
	 begin
		if clock = '1' and clock'event then
			
			
			
		end if;
		
	end process;

end Behavioral;

