-------------------------------------------------------------------------------
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;



entity Debouncer is
	port(
		CLK : in STD_LOGIC;	   -- clock
		START : in STD_LOGIC;	   -- start button entry
		STARTO : out STD_LOGIC        -- debounced output	
		);
end Debouncer;

architecture Debouncer of Debouncer is
	
   signal shift   : std_logic_vector(3 downto 0);
   signal state   : std_logic := '0';
	
begin
	debounce : process(CLK, shift, state)
   begin
     if CLK'event and CLK='1'  then
      shift(2 downto 0) <= shift(3 downto 1);
      shift(3) <= START;
      
      case shift is
         when "0000" => state <= '0';
         when "1111" => state <= '1';
         when others => state <= state;
      end case;
     end if;   
      STARTO <= state;
   end process;
	
end Debouncer;			
