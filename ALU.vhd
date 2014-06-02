----------------------------------------------------------------------------------
-- Company: MorWire
-- Engineer: 
-- 
-- Create Date:    13:15:16 05/26/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

--Comment added by austin warren

entity ALU is

port(	inX:	in std_logic_vector(31 downto 0);
		inY:	in std_logic_vector(31 downto 0);
		inZ: in std_logic_vector(31 downto 0);
		i: in integer; -- iteration number
		theta : in std_logic_vector(31 downto 0);
		reset: in std_logic; -- may not be needed
		en : in std_logic;
		addSub:	in std_logic; -- add or subtract addSub. addSub '0' x and z are addition, y is subtraction. addSub '1' is vice versa
		clock: in std_logic;
		result_X:	out std_logic_vector(31 downto 0);
		result_Y:	out std_logic_vector(31 downto 0); 
		result_Z:	out std_logic_vector(31 downto 0)  		
);

end ALU;

architecture behv of ALU is
begin			
		   
	 
    pX : process(clock)
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
		if en = '1' then
			if (clock = '1' and clock'event) then 
				case addSub is
					 when "0" =>
						result_X <= inX + (inY srl i); -- Addition of Input 1 and Input 2
					 when "1" =>						
						result_X <= inX - (inY srl i); -- 2's compliment subtraction of Input 1 and Input 2
					 when others =>	 
						result_X <= "XX"; -- nop
					  end case;
			end if;
		end if;
    end process pX;
	 
	 pY : process(clock)
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
		if en = '1' then
			if (clock = '1' and clock'event) then 
				case addSub is
					 when "1" =>
						result_Y <= inY + (inX srl i); -- Addition of Input 1 and Input 2
					 when "0" =>						
						result_Y <= inY - (inX srl i); -- 2's compliment subtraction of Input 1 and Input 2
					 when others =>	 
						result_Y <= "XX"; -- nop
					  end case;
			end if;
		end if;
    end process pY;

    pZ : process(clock)
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
		if en = '1' then
			if (clock = '1' and clock'event) then 

				case addSub is
					 when "0" =>
						result_Z <= inZ + theta ; -- Addition of Input 1 and Input 2
					 when "1" =>						
						result_Z <= inZ - theta; -- 2's compliment subtraction of Input 1 and Input 2
					 when others =>	 
						result_Z <= "XX"; -- nop
					  end case;
			end if;
		end if;
    end process pZ;


end behv;

