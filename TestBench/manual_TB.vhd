library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity manual_tb is
end manual_tb;

architecture TB_ARCHITECTURE of manual_tb is
	-- Component declaration of the tested unit
	component manual
	port(
		CLK : in STD_LOGIC;
		CE : in STD_LOGIC;
		CE7SEG : in STD_LOGIC;
		START : in STD_LOGIC;
		CEOUT : out STD_LOGIC;
		AM : in STD_LOGIC;
		NUM1 : in STD_LOGIC_VECTOR(3 downto 0);
		NUM2 : in STD_LOGIC_VECTOR(3 downto 0);
		ANODES : out STD_LOGIC_VECTOR(7 downto 0);
		CATHODES : out STD_LOGIC_VECTOR(6 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC;
	signal CE : STD_LOGIC;
	signal CE7SEG : STD_LOGIC;
	signal START : STD_LOGIC;
	signal AM : STD_LOGIC;
	signal NUM1 : STD_LOGIC_VECTOR(3 downto 0);
	signal NUM2 : STD_LOGIC_VECTOR(3 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal CEOUT : STD_LOGIC;
	signal ANODES : STD_LOGIC_VECTOR(7 downto 0);
	signal CATHODES : STD_LOGIC_VECTOR(6 downto 0);	
	signal END_SIM : boolean := FALSE;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : manual
		port map (
			CLK => CLK,
			CE => CE,
			CE7SEG => CE7SEG,
			START => START,
			CEOUT => CEOUT,
			AM => AM,
			NUM1 => NUM1,
			NUM2 => NUM2,
			ANODES => ANODES,
			CATHODES => CATHODES
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
	
	CLKE : process
	begin 
		if END_SIM = FALSE then
			CE <= '0';
			wait for 20 ns; 
		else
			wait;
		end if;	
		
		if END_SIM = FALSE then
			CE <= '1';
			wait for 20 ns; 
		else
			wait;
		end if;	
	end process;
	 CLKE7SEG : process
	begin 
		if END_SIM = FALSE then
			CE7SEG <= '0';
			wait for 20ns; 
		else
			wait;
		end if;	
		
		if END_SIM = FALSE then
			CE7SEG <= '1';
			wait for 20ns; 
		else
			wait;
		end if;	
	end process;



	PROC : process
	begin
		START <= '0'; 
		AM<='1';  
		NUM1<="0010";
		NUM2<="0000";
		wait for 100 ns; 
		AM<='0';	
		wait for 100 ns;   	
		START <= '1'; 
		wait for 5000 ns;
		END_SIM<=TRUE;
		wait;
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_manual of manual_tb is
	for TB_ARCHITECTURE
		for UUT : manual
			use entity work.manual(manual);
		end for;
	end for;
end TESTBENCH_FOR_manual;

