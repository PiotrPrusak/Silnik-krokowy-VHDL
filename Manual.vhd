
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;


entity Manual is
	port(
		CLK : in STD_LOGIC;			-- clock 	  
		CE : in STD_LOGIC;			-- clock enable	   
		CE7SEG : in STD_LOGIC;		-- clock enable for 7 seg
		START : in STD_LOGIC;		-- 1-start 0-stop 
		CEOUT : out STD_LOGIC;		-- clock enable out
		AM : in STD_LOGIC;			-- automatic-1 manual-0 
		NUM1 : in STD_LOGIC_VECTOR(3 downto 0); -- choose 1st number on 4 switch
		NUM2 : in STD_LOGIC_VECTOR(3 downto 0);	-- choose 2nd number on 4 switch   
		ANODES : out STD_LOGIC_VECTOR (7 downto 0);	 --anodes on 7seg
		CATHODES : out STD_LOGIC_VECTOR (6 downto 0) --cothoeds on 7seg
		
		);	   
end Manual;



architecture Manual of Manual is	    		   
	
	signal position1: STD_LOGIC_VECTOR(3 downto 0) :=(others =>'0');--position of first number		   	  
	signal position2: STD_LOGIC_VECTOR(3 downto 0) :=(others =>'0');--position of second number	
	signal sig : STD_LOGIC:='0';								    --out signal	 
	signal counter32 : STD_LOGIC_VECTOR(5 downto 0) :=(others =>'0');--count to 32 becouse Step Angle: 5.625°/32   
	signal counter10 : STD_LOGIC_VECTOR(3 downto 0) :=(others =>'0');--decimal counter	
	signal num1_jednosci : STD_LOGIC_VECTOR(3 downto 0) :=(others =>'0');--1st number from 0-9
	signal num2_dziesiatki : STD_LOGIC_VECTOR(3 downto 0) :=(others =>'0');--2nd number from 0-9	 
	-- counting decimal number to be displayed on 4-digit 7-segment display
	signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
	signal LED_activating_counter: std_logic_vector(2 downto 0);
	
begin	 
	--BCD to 7seg coder
	process(LED_BCD)
	begin
		case LED_BCD is
			when "0000" => CATHODES <= "0000001"; -- "0"     
			when "0001" => CATHODES <= "1001111"; -- "1" 
			when "0010" => CATHODES <= "0010010"; -- "2" 
			when "0011" => CATHODES <= "0000110"; -- "3" 
			when "0100" => CATHODES <= "1001100"; -- "4" 
			when "0101" => CATHODES <= "0100100"; -- "5" 
			when "0110" => CATHODES <= "0100000"; -- "6" 
			when "0111" => CATHODES <= "0001111"; -- "7" 
			when "1000" => CATHODES <= "0000000"; -- "8"     
			when "1001" => CATHODES <= "0000100"; -- "9"   
			when others => CATHODES <= "1111111"; -- "nothing" 
			
		end case;
	end process;
	
	--7seg conroller
	process(CLK,CE7SEG)
	begin 
		if CE7SEG='1' then
			if(CLK'event and CLK = '1') then 
				if AM='1' then 
					LED_activating_counter <= "111";
				elsif LED_activating_counter >2 then 
					LED_activating_counter<=(others => '0');		
				else
					LED_activating_counter <= LED_activating_counter + 1;
				end if;	  
			end if;	  		   
		end if;	
		
	end process;
	
	 --mux to controll andoes for 4 leds
	process(LED_activating_counter,num1_jednosci,num2_dziesiatki,position1,position2)
	begin  
		case LED_activating_counter is
			when "000" =>
				ANODES <= "01111111";--1st anode
				LED_BCD <= num1_jednosci;--unity number
			when "001" =>
				ANODES <= "10111111";--2nd anode 
				LED_BCD <= num2_dziesiatki;--decimal number
			when "010" =>
				ANODES <= "11011111";--3rd anode 
				LED_BCD <= position2;--decimal position
			when "011" =>
				ANODES <= "11101111";--4th anode 
				LED_BCD <= position1;--unity position  
			when others =>
				ANODES <= "11111111";--no anoode  
				LED_BCD <= "1111";--nothing
		end case; 
	end process;
	
	
	
	
	process (CLK,CE,NUM1,NUM2,AM,num1_jednosci,num2_dziesiatki)
	begin	
		--change switch walue to digit
		if NUM1>9 then
			num1_jednosci<="1001";
		else
			num1_jednosci<=NUM1;
		end if;
		if NUM2>9 then
			num2_dziesiatki<="1001";
		else
			num2_dziesiatki<=NUM2;
		end if;
		
		
		--main counter
		if CLK'event and CLK = '1' then	  
			if CE = '1' then 
				if START='1' then 		
					if num2_dziesiatki>position2 then
						if position1<10 then
							if counter32<32 then 	   ---10 bo dziesiatki 32 bo tyle trzeba na obrót o 5,625 stopnia
								counter32<=counter32+1;
								sig<='1';
							else
								sig<='0'; 	
								counter32<=(others =>'0'); 
								position1<=position1+1;
							end if;
						else	
							position1<=(others =>'0'); 
							position2<=position2+1;	 
						end if;	 
					elsif num1_jednosci>position1 then	  
						if counter32<32 then
							counter32<=counter32+1;
							sig<='1';						  
						else
							sig<='0';
							counter32<=(others =>'0');
							position1<=position1+1;
						end if;
					end if;				 
				else
					sig<='0';
					position1<=(others =>'0');	   
					position2<=(others =>'0');	
					counter32<=(others =>'0');		
				end if;	 
			else
				sig<='0';
			end if;
		end if;
	end process;
	CEOUT<=sig when AM='0' else CE;	  
end Manual;






