library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity prescaler_tb is
end prescaler_tb;

architecture TB_ARCHITECTURE of prescaler_tb is
	-- Component declaration of the tested unit
	component prescaler
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		DIV : in STD_LOGIC_VECTOR(2 downto 0);
		CEO : out STD_LOGIC;
		CEO7SEG : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal DIV : STD_LOGIC_VECTOR(2 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal CEO : STD_LOGIC;
	signal CEO7SEG : STD_LOGIC;
	signal END_SIM : boolean := FALSE;
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : prescaler
		port map (
			CLK => CLK,
			CE => CE,
			DIV => DIV,
			CEO => CEO,
			CEO7SEG => CEO7SEG
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
		DIV <= "111"; 
		CE<='0';
		wait for 50 ns; 
		CE<='1';	
		wait for 500 ns;   	

		END_SIM<=TRUE;
		wait;
	end process;
end TB_ARCHITECTURE;


configuration TESTBENCH_FOR_prescaler of prescaler_tb is
	for TB_ARCHITECTURE
		for UUT : prescaler
			use entity work.prescaler(prescaler);
		end for;
	end for;
end TESTBENCH_FOR_prescaler;

