library ieee;
use ieee.std_logic_1164.all ;

package ClockDivisor_package is
	component CLockDivisor IS
		PORT (Clock_quartus : in std_logic;
				clock   : OUT STD_logic) ;
	END component;
end ClockDivisor_package;
