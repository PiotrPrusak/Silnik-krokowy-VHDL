library ieee;
use ieee.STD_LOGIC_SIGNED.all;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity top_tb is
end top_tb;

architecture TB_ARCHITECTURE of top_tb is
	-- Component declaration of the tested unit
	component top
	port(
		AM : in STD_LOGIC;
		CE : in STD_LOGIC;
		CLK : in STD_LOGIC;
		DIR : in STD_LOGIC;
		RESET : in STD_LOGIC;
		START : in STD_LOGIC;
		DIV : in STD_LOGIC_VECTOR(2 downto 0);
		NUM1 : in STD_LOGIC_VECTOR(3 downto 0);
		NUM2 : in STD_LOGIC_VECTOR(3 downto 0);
		ANODES : out STD_LOGIC_VECTOR(7 downto 0);
		CATHODES : out STD_LOGIC_VECTOR(6 downto 0);
		O : out STD_LOGIC_VECTOR(3 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal AM : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal CLK : STD_LOGIC;
	signal DIR : STD_LOGIC;
	signal RESET : STD_LOGIC;
	signal START : STD_LOGIC;
	signal DIV : STD_LOGIC_VECTOR(2 downto 0);
	signal NUM1 : STD_LOGIC_VECTOR(3 downto 0);
	signal NUM2 : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal ANODES : STD_LOGIC_VECTOR(7 downto 0);
	signal CATHODES : STD_LOGIC_VECTOR(6 downto 0);
	signal O : STD_LOGIC_VECTOR(3 downto 0);  
	signal END_SIM : boolean := FALSE;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : top
		port map (
			AM => AM,
			CE => CE,
			CLK => CLK,
			DIR => DIR,
			RESET => RESET,
			START => START,
			DIV => DIV,
			NUM1 => NUM1,
			NUM2 => NUM2,
			ANODES => ANODES,
			CATHODES => CATHODES,
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
	


--	 AM : in STD_LOGIC;
--		CE : in STD_LOGIC;
--		CLK : in STD_LOGIC;
--		DIR : in STD_LOGIC;
--		RESET : in STD_LOGIC;
--		START : in STD_LOGIC;
--		DIV : in STD_LOGIC_VECTOR(2 downto 0);
--		NUM1 : in STD_LOGIC_VECTOR(3 downto 0);
--		NUM2
	PROC : process
	begin
		START <= '0'; 
		AM<='1';  
		NUM1<="0010";
		NUM2<="0000"; 
		CE<='1';
		DIR<='1';
		RESET<='0';
		DIV<="111";
		wait for 100 ns; 
		CE<='0';  
		wait for 100 ns; 
		CE<='1';
		wait for 100 ns; 
		RESET<='1';	
		wait for 100 ns; 
		RESET<='0';	
		wait for 100 ns; 
		DIR<='0';
		wait for 100 ns; 
		AM<='0';	
		wait for 100 ns;   	
		START <= '1';
		wait for 1 ns;   	
		START <= '0';  
		wait for 1 ns;   	
		START <= '1';
		wait for 1 ns;   	
		START <= '0';
		wait for 1 ns;   	
		START <= '1';  
		wait for 1 ns;   	
		START <= '0';
		wait for 1 ns;   	
		START <= '1';
		wait for 5000 ns;
		END_SIM<=TRUE;
		wait;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_top of top_tb is
	for TB_ARCHITECTURE
		for UUT : top
			use entity work.top(top);
		end for;
	end for;
end TESTBENCH_FOR_top;

