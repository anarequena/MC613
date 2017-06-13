library ieee;
use ieee.std_logic_1164.all;

package reg_package is
	component RegN IS
		GENERIC(N : Integer := 4);
		PORT (D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ;
				Clear, Clock: IN STD_LOGIC ;
				Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ) ;
		END component;
end reg_package;