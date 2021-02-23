

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;  



entity Prescaler is
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;	  
		DIV : in STD_LOGIC_VECTOR(2 downto 0);		  
		CEO : out STD_LOGIC	; 
		CEO7SEG	: out STD_LOGIC
		
		);	   
end Prescaler;



architecture Prescaler of Prescaler is
	
signal DIVIDER: std_logic_vector(23 downto 0):=(others => '0');	-- internal divider register  
signal DIVIDER_7seg: std_logic_vector(23 downto 0):=(others => '0');	-- internal divider register 
	signal divide_factor: integer := 2;			-- divide factor user constant

	
begin 	
	process(DIV)
	begin
		if DIV = "000" then	  
			divide_factor<=8000000;
		elsif DIV = "001" then 
			divide_factor<=2000000;	   
		elsif DIV = "010" then 
			divide_factor<=1000000;	
		elsif DIV = "011" then 
			divide_factor<=900000; 
		elsif DIV = "100" then 
			divide_factor<=800000;
		elsif DIV = "101" then 
			divide_factor<=700000;	 
		elsif DIV = "110" then 
			divide_factor<=600000; 
		elsif DIV = "111" then 
			divide_factor<=500000;--2; --for TB
		else  
			divide_factor<=1;	 
		end if;
		
	end process;
	
	
	process (CLK)
	begin
		--if CLR = '1' then
		--	DIVIDER <= (others => '0');
		if CLK'event and CLK = '1' then
			if CE = '1' then	 			
				if DIVIDER >= (divide_factor-1) then
					DIVIDER <= (others => '0');
				else
					DIVIDER <= DIVIDER + 1;
				end if;
			end if;
		end if;
	end process;	 	
	
		process (CLK)
	begin
		if CLK'event and CLK = '1' then	
				if DIVIDER_7seg >= (400000-1) then	 --1kHz
					DIVIDER_7seg <= (others => '0');
				else
					DIVIDER_7seg <= DIVIDER_7seg + 1;
				end if;
		end if;
	end process;	 	
	
	
	CEO <= '1' when DIVIDER = (divide_factor-1) and CE = '1' else '0';
	CEO7SEG <= '1' when DIVIDER_7SEG = (400000-1) else '0';
end Prescaler;





