library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity debouncer_tb is
end debouncer_tb;

architecture TB_ARCHITECTURE of debouncer_tb is
	-- Component declaration of the tested unit
	component debouncer
	port(
		CLK : in STD_LOGIC;
		START : in STD_LOGIC;
		STARTO : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal START : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal STARTO : STD_LOGIC;
	signal END_SIM : boolean := FALSE;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : debouncer
		port map (
			CLK => CLK,
			START => START,
			STARTO => STARTO
		);

	-- Add your stimulus here ...
	    CLOCK : process
	begin 
		if END_SIM = FALSE then
			CLK <= '0';
			wait for 10 ns; 
		else
			wait;
		end if;	
		
		if END_SIM = FALSE then
			CLK <= '1';
			wait for 10 ns; 
		else
			wait;
		end if;	
	end process;
	
	PROC : process
	begin
		START<='1';
		wait for 150 ns; 
		START<='0';	
		wait for 50 ns;  
		START<='1';	
		wait for 2 ns;  
		START<='0';
		wait for 2 ns;  
		START<='1';
		wait for 2 ns;  
		START<='0';
		wait for 2 ns;  
		START<='1';
		wait for 2 ns;  
		START<='0';
		wait for 2 ns;  
		START<='1';
		wait for 200 ns;  

		

		END_SIM<=TRUE;
		wait;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_debouncer of debouncer_tb is
	for TB_ARCHITECTURE
		for UUT : debouncer
			use entity work.debouncer(debouncer);
		end for;
	end for;
end TESTBENCH_FOR_debouncer;

