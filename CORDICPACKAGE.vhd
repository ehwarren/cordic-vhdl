-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cordic_package is


	
  Type send_data_state_type is (idle, final,
				ch_xw  , ch_xeqw, ch_xcrw , ch_xlfw,
				ch_x   , ch_xeq,  ch_xcr ,  ch_xlf,
				ch_yw  , ch_yeqw, ch_ycrw,  ch_ylfw,
				ch_y   , ch_yeq,  ch_ycr,   ch_ylf,
				ch_zw  , ch_zeqw, ch_zcrw , ch_zlfw,
				ch_z   , ch_zeq,  ch_zcr ,  ch_zlf,
				sendx0w, sendx1w, sendx2w , sendx3w,
				sendx0 , sendx1 , sendx2  , sendx3 ,
				sendy0w, sendy1w, sendy2w , sendy3w,
				sendy0 , sendy1 , sendy2  , sendy3 ,
				sendz0w, sendz1w, sendz2w , sendz3w,
				sendz0 , sendz1 , sendz2  , sendz3);
				
  Type ascii_state_type is (
				idle,
				byte_asciiw, byte_ascii,
				nibble0w    , nibble1w,
				nibble0     , nibble1
				);
				
  type uart_state_type is (idle, start_bit, bit0, bit1, bit2, bit3, bit4, bit5, 
			bit6, bit7, stop_bit1, stop_bit2, stop_bit3);

end cordic_package;

