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

entity ALU is

port(	inX : IN  std_logic_vector(31 downto 0); -- in X
		inY : IN  std_logic_vector(31 downto 0); -- in Y
		inZ : IN  std_logic_vector(31 downto 0); -- in Z
		i: IN std_logic_vector(4 downto 0); -- iteration number
		theta : in std_logic_vector(31 downto 0); -- in theta value from look up table
		m: in std_logic_vector(1 downto 0); -- current mode 
		addSub:	in std_logic; -- add or subtract addSub. addSub '0' x and z are addition, y is subtraction. addSub '1' is vice versa
      result_X : OUT  std_logic_vector(31 downto 0); -- out x
      result_Y : OUT  std_logic_vector(31 downto 0); -- out y
      result_Z : OUT  std_logic_vector(31 downto 0) -- out z
);

end ALU;

architecture behv of ALU is
begin			
		   
	 
    pXYZ : process(i,inX,inY,inZ,theta, addSub) is
	 variable signed_X,signed_Y: signed(31 downto 0);
	 variable iteration :integer;
	 variable signed_Z: signed(31 downto 0);
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU
	
	--  signed variables are created in order to use the mathematical operations from NUMERIC library.
		signed_X := signed(inX);
		signed_Y := signed(inY);
		signed_Z := signed(inZ);
		iteration := to_integer(unsigned(i));

--Circular mode m = 1
--Linear mode m = 0
--Hyperbolic mode m = -1
--
--Vectoring operation y => 0
--Rotation operation z => 0
--
--delta = 2^(-i) => from lookup table
--theta => lookup table
--
--generalized cordic
--xi+1 = xi - (m) * (Mew)i * (y)i * (delta)i
--yi+1 = yi + (Mew)i * (x)i * (delta)i
--zi+1 = zi - (Mew)i * (theta)i 
--
--binary point is after the second MSB (sign bit, bit, binary point, frac bit, frac bit, frac bit....)
--'00' is linear, '01' is circular, '10' hyperbolic, '11' is nothing

		-- result_X ALU calculation
		if m = "00" then -- linear mode, x value does not change m = 0 for generalized cordic
			result_X <= inX;
		elsif m = "01" then -- circular mode, m = 1 for generalized cordic
			case addSub is
			when '0' =>
				result_X <= std_logic_vector(signed_X + shift_right(signed_Y,iteration)); -- Addition of Input 1 and Input 2
			when '1' =>						
				result_X <= std_logic_vector(signed_X - shift_right(signed_Y,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
			when others =>	 
				result_X <= x"00000000"; -- nop
			end case;
		elsif m = "10" then -- hyperbolic mode, m = -1 for generalized cordic
			case addSub is
			when '1' =>
				result_X <= std_logic_vector(signed_X + shift_right(signed_Y,iteration)); -- Addition of Input 1 and Input 2
			when '0' =>						
				result_X <= std_logic_vector(signed_X - shift_right(signed_Y,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
			when others =>	 
				result_X <= x"00000000"; -- nop, value should not occur and is an error state. Occurs if m = "11"
			end case;
		else
			result_X <= inX; -- nop, error state.
		end if;

		-- result_Y ALU calculation
		case addSub is
			 when '1' =>
				result_Y <= std_logic_vector(signed_Y + shift_right(signed_X,iteration)); -- Addition of Input 1 and Input 2
			 when '0' =>						
				result_Y <= std_logic_vector(signed_Y - shift_right(signed_X,iteration)); -- 2's compliment subtraction of Input 1 and Input 2
			 when others =>	 
				result_Y <= x"00000000"; -- nop, error state.
			  end case;

		-- result_Z ALU calculation
		case addSub is
			 when '0' =>
				result_Z <= std_logic_vector(signed_Z + signed(theta)) ; -- Addition of Input 1 and Input 2
			 when '1' =>						
				result_Z <= std_logic_vector(signed_Z - signed(theta)); -- 2's compliment subtraction of Input 1 and Input 2
			 when others =>	 
				result_Z <= x"00000000"; -- nop, error state.
			  end case;
    end process pXYZ;


end behv;

