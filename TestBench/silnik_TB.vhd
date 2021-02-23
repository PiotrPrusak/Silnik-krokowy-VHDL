library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity silnik_tb is
end silnik_tb;

architecture TB_ARCHITECTURE of silnik_tb is
	-- Component declaration of the tested unit
	component silnik
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		RESET : in STD_LOGIC;
		DIR : in STD_LOGIC;
		O : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal RESET : STD_LOGIC;
	signal DIR : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal O : STD_LOGIC_VECTOR(3 downto 0); 
	signal END_SIM : boolean := FALSE;

	-- Add your code here ...

begin
	-- Unit Under Test port map
	UUT : silnik
		port map (
			CLK => CLK,
			CE => CE,
			RESET => RESET,
			DIR => DIR,
			O => O
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
		DIR <= '1'; 
		CE<='1';
		RESET<='1';	
		wait for 50 ns; 
		RESET<='0';	
		wait for 500 ns;   	
		DIR <= '0'; 
		wait for 500 ns;
		DIR <='1';	
		CE<='0';
		wait for 450 ns;
		END_SIM<=TRUE;
		wait;
	end process;
end TB_ARCHITECTURE;



configuration TESTBENCH_FOR_silnik of silnik_tb is
	for TB_ARCHITECTURE
		for UUT : silnik
			use entity work.silnik(silnik);
		end for;
	end for;
end TESTBENCH_FOR_silnik;

