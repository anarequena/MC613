LIBRARY ieee ;
USE ieee.std_logic_1164.all ;


ENTITY CounterMod IS
	GENERIC ( modulus : INTEGER := 9 ) ;
	PORT (Clock, E, P : IN   STD_LOGIC ;
			W : IN INTEGER RANGE 0 TO modulus-1;
			Q   : OUT INTEGER RANGE 0 TO modulus-1 ) ;
END CounterMod ;

ARCHITECTURE Behavior OF CounterMod IS
	SIGNAL Count : INTEGER RANGE 0 TO modulus-1 ;
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL (Clock'EVENT AND Clock = '1') ;
			if P = '1' then
				Count <= W;
			end if;
			IF E = '1' THEN
				IF Count >= modulus THEN
					Count <= 0; 
				ELSE
					Count <= Count+1 ;
				END IF ;
			END IF ;
		END PROCESS;
	Q <= Count ;
END Behavior ;