
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;


entity Silnik is
	port(
		CLK : in STD_LOGIC;			-- clock 
		CE : in STD_LOGIC;			-- clock active   
		RESET : in STD_LOGIC;		--switch to turn on/off device
		DIR : in STD_LOGIC;			--choose direction
		O : out STD_LOGIC_VECTOR(3 downto 0):="0000"	-- outputs				   
		);
end Silnik;


architecture Silnik of Silnik is	  
	type stan is(s0, s1, s2, s3, s4);  --states to enable stepper motor
	signal stan_obecny, stan_nastepny: stan;   
	signal Q_INT: STD_LOGIC_VECTOR(3 downto 0):="0000";	--out signal
begin			 
	--change state 
	process(CLK,RESET)
	begin
		if RESET='1' then
			stan_obecny<=s0;		
		elsif CLK'event and CLK='1' then   
			if CE='1' then
				stan_obecny<=stan_nastepny;
			end if;	 
		end if;
	end process;
	--moore state machine
	process(DIR,stan_obecny)
	begin	
		case stan_obecny is
			when s0 =>
				Q_INT <= "0000";
				stan_nastepny <=s1;
			
			when s1 =>                  
				Q_INT <= "1000";
				if DIR='1' then
					stan_nastepny <=s2;
				else
					stan_nastepny <=s4; 		           
				end if;   
			
			when s2 =>                     
				Q_INT <= "0100";                   
				if DIR='1' then                
					stan_nastepny <=s3;         
				else                           
					stan_nastepny <=s1;         	   
				end if;               
			
			when s3 =>       
				Q_INT <= "0010";     
				if DIR='1' then  
					stan_nastepny <=s4;
				else             
					stan_nastepny <=s2;
				end if;          
			
			when s4 =>                                   
				Q_INT <= "0001";                            
				if DIR='1' then                              
					stan_nastepny <=s1;                      
				else                                         
					stan_nastepny <=s3;                      
			end if;  
		end case;
	end process;
	
	
	
	
	O <= Q_INT;	
	
end Silnik;







