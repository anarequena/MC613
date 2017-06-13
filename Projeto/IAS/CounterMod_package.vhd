library ieee;
use ieee.std_logic_1164.all ;

package CounterMod_package IS
	component CounterMod IS
		GENERIC ( modulus : INTEGER := 9 ) ;
		PORT (Clock, E, P : IN   STD_LOGIC ;
				W : IN INTEGER RANGE 0 TO modulus-1;
				Q   : OUT INTEGER RANGE 0 TO modulus-1 ) ;
	END component;
end CounterMod_package;
