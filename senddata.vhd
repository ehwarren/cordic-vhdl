-- Created by Dr. Gebali June 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.cordic_package.ALL;

entity send_data is
    Port ( 
			  x : in  STD_LOGIC_VECTOR (31 downto 0);
           y : in  STD_LOGIC_VECTOR (31 downto 0);
           z : in  STD_LOGIC_VECTOR (31 downto 0);
           done : in  STD_LOGIC;
           ascii_ready : in  STD_LOGIC; -- ascii_ready comes from serial interface. 
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  ---- outputs 
			  byte_out : out STD_LOGIC_VECTOR (7 downto 0);
			  byte_out_ready : out  STD_LOGIC;
			  is_ascii: out std_logic;
			  ns_send_data: out send_data_state_type;
			  ps_send_data: out send_data_state_type
           );
end send_data;

architecture Behavioral of send_data is
	
	signal present_state, next_state: send_data_state_type;
	signal x_data, y_data, z_data : std_logic_vector (31 downto 0);

begin

---------------------------------------------------------------------------------	
	ps_send_data_update: PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN -- asynchronous reset
			present_state <= idle; 
		ELSIF rising_edge (clk) THEN
			present_state <= next_state; -- implied FF	
		END IF;
	END PROCESS ps_send_data_update;
	
----------------------------------------------------------------------------------
	capture: process (clk) is begin
		if ((rising_edge(clk)) and (done = '1')) then -- caputre valid input data
					x_data <= x; y_data <= y; z_data <= z; 
		end if;
	end process capture;
	
------------------------------------------------------------------------------------
	ns_send_data_update: PROCESS (done, present_state, ascii_ready) is
	BEGIN
				CASE present_state IS 

				when idle =>  ps_send_data <= idle;  
						byte_out<= X"00"; 
						byte_out_ready <= '0';
						if (done = '1') then -- data is available from CORDIC
							next_state <= ch_xw; ns_send_data <= ch_xw;
							is_ascii <= '1';
						else  -- CORDIC is not done yet
							next_state <= idle; ns_send_data <= idle;
							is_ascii <= '0';
						end if; -- if done
-------------------------------------------------------------------------------------

-- X states
						
----------------------------------------------------------------------------------------						
				when ch_xw => ps_send_data <= ch_xw;
						byte_out <= X"58"; -- ASCII for X
						byte_out_ready <= '1'; is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_xw; ns_send_data <= ch_xw;
						else
							next_state <= ch_x; ns_send_data <= ch_x;	
						end if; 					
				when ch_x => ps_send_data <= ch_x;
						byte_out <= X"58"; -- ASCII for X 
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '0' then -- ascii did not respond to request yet
							next_state <= ch_x; ns_send_data <= ch_x;
						else -- ascii indicated it is sending the data
							next_state <= ch_xeqw; ns_send_data <= ch_xeqw;	
						end if;						
				when ch_xeqw => ps_send_data <= ch_xeqw;
						byte_out <= X"3D"; -- ASCII for =
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_xeqw;ns_send_data <= ch_xeqw;
						else
							next_state <= ch_xeq;ns_send_data <= ch_xeq;	
						end if; 						
				when ch_xeq => ps_send_data <= ch_xeq;
						byte_out <= X"3D"; -- ASCII for = 
						byte_out_ready <= '1';
						if ascii_ready = '0' then 
							next_state <= ch_xeq;ns_send_data <= ch_xeq;
							 is_ascii <= '1';
						else
							next_state <= sendx3w;ns_send_data <= sendx3w;	
							 is_ascii <= '0';
						end if; 
             when sendx3w => ps_send_data <= sendx3w;
                    byte_out<= x_data(31 downto 24); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendx3w;ns_send_data <= sendx3w;
                    else 
                         next_state <= sendx3;ns_send_data <= sendx3;
						  end if; 
             when sendx3 => ps_send_data <= sendx3;
                    byte_out<= x_data(31 downto 24);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendx3;ns_send_data <= sendx3;
                    else
                         next_state <= sendx2w;ns_send_data <= sendx2w;
						  end if;  
             when sendx2w => ps_send_data <= sendx2w;
                    byte_out<= x_data(23 downto 16); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendx2w;ns_send_data <= sendx2w;
                    else 
                         next_state <= sendx2;ns_send_data <= sendx2;
						  end if; 
             when sendx2 => ps_send_data <= sendx2;
                    byte_out<= x_data(23 downto 16);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendx2;ns_send_data <= sendx2;
                    else
                         next_state <= sendx1w;ns_send_data <= sendx1w;
						  end if;   
             when sendx1w => ps_send_data <= sendx1w;
                    byte_out<= x_data(15 downto 8); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendx1w;ns_send_data <= sendx1w;
                    else 
                         next_state <= sendx1;ns_send_data <= sendx1;
						  end if; 
             when sendx1 => ps_send_data <= sendx1;
                    byte_out<= x_data(15 downto 8);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendx1;ns_send_data <= sendx1;
                    else
                         next_state <= sendx0w;ns_send_data <= sendx0w;
						  end if;   
             when sendx0w => ps_send_data <= sendx0w;
                    byte_out<= x_data(7 downto 0); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendx0w;ns_send_data <= sendx0w;
                    else 
                         next_state <= sendx0;ns_send_data <= sendx0;
						  end if; 
             when sendx0 => ps_send_data <= sendx0;
                    byte_out<= x_data(7 downto 0);
                    byte_out_ready <= '1';
                    if ascii_ready = '0' then
                        next_state <= sendx0;ns_send_data <= sendx0;
								 is_ascii <= '0';
                    else
                         next_state <= ch_xcrw;ns_send_data <= ch_xcrw;
								  is_ascii <= '1';
						  end if;             
				when ch_xcrw => ps_send_data <= ch_xcrw;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_xcrw;ns_send_data <= ch_xcrw;
                    else 
                         next_state <= ch_xcr;ns_send_data <= ch_xcr;
						  end if; 
             when ch_xcr => ps_send_data <= ch_xcr;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_xcr;ns_send_data <= ch_xcr;
                    else
                         next_state <= ch_xlfw;ns_send_data <= ch_xlfw;
						  end if;            
				when ch_xlfw => ps_send_data <= ch_xlfw;
                    byte_out<= X"0A"; -- ASCII for LF 
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_xlfw;ns_send_data <= ch_xlfw;
                    else 
                         next_state <= ch_xlf;ns_send_data <= ch_xlf;
						  end if; 
             when ch_xlf => ps_send_data <= ch_xlf;
                    byte_out<= X"0A"; -- ASCII for LF
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_xlf;ns_send_data <= ch_xlf;
                    else
                         next_state <= ch_yw;ns_send_data <= ch_yw;
						  end if;

-------------------------------------------------------------------------------------

-- Y states
						
----------------------------------------------------------------------------------------						
				when ch_yw => ps_send_data <= ch_yw;
						byte_out <= X"59"; -- ASCII for Y
						byte_out_ready <= '1'; is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_yw;ns_send_data <= ch_yw;
						else
							next_state <= ch_y;ns_send_data <= ch_y;	
						end if; 					
				when ch_y => ps_send_data <= ch_y;
						byte_out <= X"59"; -- ASCII for Y 
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '0' then -- ascii did not respond to request yet
							next_state <= ch_y;ns_send_data <= ch_y;
						else -- ascii indicated it is sending the data
							next_state <= ch_yeqw;ns_send_data <= ch_yeqw;	
						end if;						
				when ch_yeqw => ps_send_data <= ch_yeqw;
						byte_out <= X"3D"; -- ASCII for =
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_yeqw;ns_send_data <= ch_yeqw;
						else
							next_state <= ch_yeq;ns_send_data <= ch_yeq;	
						end if; 						
				when ch_yeq => ps_send_data <= ch_yeq;
						byte_out <= X"3D"; -- ASCII for = 
						byte_out_ready <= '1';
						if ascii_ready = '0' then 
							next_state <= ch_yeq;ns_send_data <= ch_yeq;
							is_ascii <= '1';
						else
							next_state <= sendy3w;ns_send_data <= sendy3w;	
							is_ascii <= '0';
						end if; 
             when sendy3w => ps_send_data <= sendy3w;
                    byte_out<= y_data(31 downto 24); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendy3w;ns_send_data <= sendy3w;
                    else 
                         next_state <= sendy3;ns_send_data <= sendy3;
						  end if; 
             when sendy3 => ps_send_data <= sendy3;
                    byte_out<= y_data(31 downto 24);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendy3;ns_send_data <= sendy3;
                    else
                         next_state <= sendy2w;ns_send_data <= sendy2w;
						  end if;  
             when sendy2w => ps_send_data <= sendy2w;
                    byte_out<= y_data(23 downto 16); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendy2w;ns_send_data <= sendy2w;
                    else 
                         next_state <= sendy2;ns_send_data <= sendy2;
						  end if; 
             when sendy2 => ps_send_data <= sendy2;
                    byte_out<= y_data(23 downto 16);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendy2;ns_send_data <= sendy2;
                    else
                         next_state <= sendy1w;ns_send_data <= sendy1w;
						  end if;   
             when sendy1w => ps_send_data <= sendy1w;
                    byte_out<= y_data(15 downto 8); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendy1w;ns_send_data <= sendy1w;
                    else 
                         next_state <= sendy1;ns_send_data <= sendy1;
						  end if; 
             when sendy1 => ps_send_data <= sendy1;
                    byte_out<= y_data(15 downto 8);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendy1;ns_send_data <= sendy1;
                    else
                         next_state <= sendy0w;ns_send_data <= sendy0w;
						  end if;   
             when sendy0w => ps_send_data <= sendy0w;
                    byte_out<= y_data(7 downto 0); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendy0w;ns_send_data <= sendy0w;
                    else 
                         next_state <= sendy0;ns_send_data <= sendy0;
						  end if; 
             when sendy0 => ps_send_data <= sendy0;
                    byte_out<= y_data(7 downto 0);
                    byte_out_ready <= '1'; 
                    if ascii_ready = '0' then
                        next_state <= sendy0;ns_send_data <= sendy0;
								is_ascii <= '0';
                    else
                         next_state <= ch_ycrw;ns_send_data <= ch_ycrw;
								 is_ascii <= '1';
						  end if;            
				when ch_ycrw => ps_send_data <= ch_ycrw;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_ycrw;ns_send_data <= ch_ycrw;
                    else 
                         next_state <= ch_ycr;ns_send_data <= ch_ycr;
						  end if; 
             when ch_ycr => ps_send_data <= ch_ycr;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_ycr;ns_send_data <= ch_ycr;
                    else
                         next_state <= ch_ylfw;ns_send_data <= ch_ylfw;
						  end if;            
				when ch_ylfw => ps_send_data <= ch_ylfw;
                    byte_out<= X"0A"; -- ASCII for LF 
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_ylfw;ns_send_data <= ch_ylfw;
                    else 
                         next_state <= ch_ylf;ns_send_data <= ch_ylf;
						  end if; 
             when ch_ylf => ps_send_data <= ch_ylf;
                    byte_out<= X"0A"; -- ASCII for LF
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_ylf;ns_send_data <= ch_ylf;
                    else
                         next_state <= ch_zw;ns_send_data <= ch_zw;
						  end if;

-------------------------------------------------------------------------------------

-- Z states
						
----------------------------------------------------------------------------------------						
				when ch_zw => ps_send_data <= ch_zw;
						byte_out <= X"5A"; -- ASCII for Z
						byte_out_ready <= '1'; is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_zw;ns_send_data <= ch_zw;
						else
							next_state <= ch_z;ns_send_data <= ch_z;	
						end if; 					
				when ch_z => ps_send_data <= ch_z;
						byte_out <= X"5A"; -- ASCII for Z 
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '0' then -- ascii did not respond to request yet
							next_state <= ch_z;ns_send_data <= ch_z;
						else -- ascii indicated it is sending the data
							next_state <= ch_zeqw;ns_send_data <= ch_zeqw;	
						end if;						
				when ch_zeqw => ps_send_data <= ch_zeqw;
						byte_out <= X"3D"; -- ASCII for =
						byte_out_ready <= '1';	is_ascii <= '1';
						if ascii_ready = '1' then 
							next_state <= ch_zeqw;ns_send_data <= ch_zeqw;
						else
							next_state <= ch_zeq;ns_send_data <= ch_zeq;	
						end if; 						
				when ch_zeq => ps_send_data <= ch_zeq;
						byte_out <= X"3D"; -- ASCII for = 
						byte_out_ready <= '1';	
						if ascii_ready = '0' then 
							next_state <= ch_zeq;ns_send_data <= ch_zeq;
							is_ascii <= '1';
						else
							next_state <= sendz3w;ns_send_data <= sendz3w;
							is_ascii <= '0';							
						end if; 
             when sendz3w => ps_send_data <= sendz3w;
                    byte_out<= y_data(31 downto 24); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendz3w;ns_send_data <= sendz3w;
                    else 
                         next_state <= sendz3;ns_send_data <= sendz3;
						  end if; 
             when sendz3 => ps_send_data <= sendz3;
                    byte_out<= z_data(31 downto 24);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendz3;ns_send_data <= sendz3;
                    else
                         next_state <= sendz2w;ns_send_data <= sendz2w;
						  end if;  
             when sendz2w => ps_send_data <= sendz2w;
                    byte_out<= z_data(23 downto 16); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendz2w;ns_send_data <= sendz2w;
                    else 
                         next_state <= sendz2;ns_send_data <= sendz2;
						  end if; 
             when sendz2 => ps_send_data <= sendz2;
                    byte_out<= z_data(23 downto 16);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendz2;ns_send_data <= sendz2;
                    else
                         next_state <= sendz1w;ns_send_data <= sendz1w;
						  end if;   
             when sendz1w => ps_send_data <= sendz1w;
                    byte_out<= z_data(15 downto 8); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendz1w;ns_send_data <= sendz1w;
                    else 
                         next_state <= sendz1;ns_send_data <= sendz1;
						  end if; 
             when sendz1 => ps_send_data <= sendy1;
                    byte_out<= z_data(15 downto 8);
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '0' then
                        next_state <= sendz1;ns_send_data <= sendz1;
                    else
                         next_state <= sendz0w;ns_send_data <= sendz0w;
						  end if;   
             when sendz0w => ps_send_data <= sendz0w;
                    byte_out<= z_data(7 downto 0); 
                    byte_out_ready <= '1'; is_ascii <= '0';
                    if ascii_ready = '1' then
                        next_state <= sendz0w;ns_send_data <= sendz0w;
                    else 
                         next_state <= sendz0;ns_send_data <= sendz0;
						  end if; 
             when sendz0 => ps_send_data <= sendz0;
                    byte_out<= z_data(7 downto 0);
                    byte_out_ready <= '1'; 
                    if ascii_ready = '0' then
                        next_state <= sendz0;ns_send_data <= sendz0;
								is_ascii <= '0';
                    else
                         next_state <= ch_zcrw;ns_send_data <= ch_zcrw;
								 is_ascii <= '1';
						  end if;            
				when ch_zcrw => ps_send_data <= ch_zcrw;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_zcrw;ns_send_data <= ch_zcrw;
                    else 
                         next_state <= ch_zcr;ns_send_data <= ch_zcr;
						  end if; 
             when ch_zcr => ps_send_data <= ch_zcr;
                    byte_out<= X"0D"; -- ASCII for CR
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_zcr;ns_send_data <= ch_zcr;
                    else
                         next_state <= ch_zlfw;ns_send_data <= ch_zlfw;
						  end if;            
				when ch_zlfw => ps_send_data <= ch_zlfw;
                    byte_out<= X"0A"; -- ASCII for LF 
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '1' then
                        next_state <= ch_zlfw;ns_send_data <= ch_zlfw;
                    else 
                         next_state <= ch_zlf;ns_send_data <= ch_zlf;
						  end if; 
             when ch_zlf => ps_send_data <= ch_zlf;
                    byte_out<= X"0A"; -- ASCII for LF
                    byte_out_ready <= '1'; is_ascii <= '1';
                    if ascii_ready = '0' then
                        next_state <= ch_zlf;ns_send_data <= ch_zlf;
                    else
                         next_state <= final;ns_send_data <= idle;
						  end if; 
-----------------------------------------------------------------------
             when final => ps_send_data <= ch_zlf;
                    byte_out<= X"00"; -- ASCII for LF
                    byte_out_ready <= '0'; is_ascii <= '1';
                    if done = '1' then
                        next_state <= final; ns_send_data <= ch_zlf;
                    else
                         next_state <= idle; ns_send_data <= idle;
						  end if;
-----------------------------------------------------------------------
						
				when others =>
						byte_out<= (others => '0');
						byte_out_ready <= '0'; is_ascii <= '0';
						next_state <= idle; ns_send_data <= idle;
				end CASE;

				
	end process ns_send_data_update;
	----------------------------------------------------------------------------------
end architecture Behavioral;


