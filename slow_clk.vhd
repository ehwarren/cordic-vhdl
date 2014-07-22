-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- clk_out is 1 for a number of clk_in pulses equal to Baudrate_Divisor
-- clk_out is 0 for a number of clk_in pulses equal to Baudrate_Divisor

entity slow_clk is 
	port( 
	clk_in : in STD_LOGIC;
	sel : in std_logic_vector (2 downto 0);
	-- output
	clk_out : out STD_LOGIC
	);
end slow_clk;

architecture slow_clk of slow_clk is
	signal Baudrate_Divisor:  integer range 0 to 16383;
	signal Rate : integer range 0 to 16383 := 0;
	
begin
	
	process(clk_in, Baudrate_divisor ) IS 
		variable count : integer range 0 to 16383 := 0;
		variable Toggle: STD_LOGIC := '0';
	begin
		if ( rising_edge( clk_in )) then
			if ( count = Baudrate_Divisor ) then
				Toggle := not(toggle); -- complement Toggle
				count := 0; 
			else
				count := count + 1;
			end if;
		end if;
		clk_out <= Toggle;
		--count_value <= count;
	end process; 
	
	Baudrate_divisor <= Rate;
	--selected_rate <= Rate;
	Divider_selection_process: process ( sel ) is
	begin
		case sel is
			when "000" => Rate <= 650*16;
			when "001" => Rate <= 325*16;
			when "010" => Rate <= 162*16;
			when "011" => Rate <= 80*16;
			when "100" => Rate <= 40*16; 
			when others => Rate <= 650*16;
		end case;
	end process Divider_selection_process;

end architecture slow_clk;


