LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY RegN IS
		GENERIC(N : Integer := 4);
PORT (D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ;
		Clear, Clock: IN STD_LOGIC ;
		Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ) ;
END RegN;

ARCHITECTURE Behavior OF RegN IS
BEGIN
	PROCESS ( Clear, Clock )
	BEGIN
		IF Clear = '0' THEN
			Q <= (others => '0');
		ELSIF Clock'EVENT AND Clock = '1' THEN 
			Q <= D;
		END IF;
	END PROCESS;
END Behavior;