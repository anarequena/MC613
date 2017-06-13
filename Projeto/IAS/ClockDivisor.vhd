LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use work.all;

ENTITY ClockDivisor IS
	PORT (Clock_quartus : in std_logic;
			clock   : OUT STD_logic) ;
END ClockDivisor ;

ARCHITECTURE Behavior OF ClockDivisor IS
	signal count : integer RANGE 0 TO 50000000-2; 
	signal aux : STD_logic;
BEGIN
	convert: CounterMod generic map (50000000 - 1)
							  port map(Clock_quartus, '1', '0', 0, count);
	
	PROCESS(Count)
	begin
		IF(Count = 0) then
			aux <= '1';
		else
			aux <= '0';
		end if;
		
		clock <= aux;
	end process;	
END Behavior ;