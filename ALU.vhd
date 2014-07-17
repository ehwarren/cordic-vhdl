----------------------------------------------------------------------------------
-- Company: MorWire-lessAudio
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
use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
--Testing Wilson
--Comment added by austin warren

entity ALU is

port(	inX : IN  std_logic_vector(31 downto 0);
		inY : IN  std_logic_vector(31 downto 0);
		inZ : IN  std_logic_vector(31 downto 0);
		i: IN std_logic_vector(4 downto 0); -- iteration number
		theta : in std_logic_vector(31 downto 0);
		m: in std_logic_vector(1 downto 0);
		addSub:	in std_logic; -- add or subtract addSub. addSub '0' x and z are addition, y is subtraction. addSub '1' is vice versa
      result_X : OUT  std_logic_vector(31 downto 0);
      result_Y : OUT  std_logic_vector(31 downto 0);
      result_Z : OUT  std_logic_vector(31 downto 0)
);

end ALU;

architecture behv of ALU is
begin			
		   
	 
    pX : process(i,inX,inY,inZ,theta, addSub) is
	 variable signed_X,signed_Y: signed(31 downto 0);
	 variable iteration :integer;
	 variable signed_Z: signed(31 downto 0);
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
		signed_X := signed(inX);
		signed_Y := signed(inY);
		iteration := to_integer(unsigned(i)); 
		if m = "00" then
			result_X <= inX;
		elsif m = "01" then
			case addSub is
			when '0' =>
				result_X <= std_logic_vector(signed_X + shift_right(signed_Y,iteration)); -- Addition of Input 1 and Input 2
			when '1' =>						
				result_X <= std_logic_vector(signed_X - shift_right(signed_Y,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
			when others =>	 
				result_X <= x"00000000"; -- nop
			end case;
		elsif m = "10" then
			case addSub is
			when '1' =>
				result_X <= std_logic_vector(signed_X + shift_right(signed_Y,iteration)); -- Addition of Input 1 and Input 2
			when '0' =>						
				result_X <= std_logic_vector(signed_X - shift_right(signed_Y,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
			when others =>	 
				result_X <= x"00000000"; -- nop
			end case;
		else
			result_X <= inX;
		end if;

		
--    end process pX;
	 
--	 pY : process(theta) is
--	 variable signed_X,signed_Y: signed(31 downto 0);
--	 variable iteration :integer;
--    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
--			signed_X := signed(inX);
--			signed_Y := signed(inY);
--			iteration := to_integer(unsigned(i)); 
				case addSub is
					 when '1' =>
						result_Y <= std_logic_vector(signed_Y + shift_right(signed_X,iteration)); -- Addition of Input 1 and Input 2
					 when '0' =>						
						result_Y <= std_logic_vector(signed_Y - shift_right(signed_X,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
					 when others =>	 
						result_Y <= x"00000000"; -- nop
					  end case;
    --end process pX;

   -- pZ : process(theta, addSub) is
	 --variable signed_Z: signed(31 downto 0);
  --  begin
	-- use case statement to achieve 
	-- different operations of ALU
			signed_Z := signed(inZ);
				case addSub is
					 when '0' =>
						result_Z <= std_logic_vector(signed_Z + signed(theta)) ; -- Addition of Input 1 and Input 2
					 when '1' =>						
						result_Z <= std_logic_vector(signed_Z - signed(theta)); -- 2's compliment subtraction of Input 1 and Input 2
					 when others =>	 
						result_Z <= x"00000000"; -- nop
					  end case;
    end process pX;


end behv;

