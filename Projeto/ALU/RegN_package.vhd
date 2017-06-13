library ieee;
use ieee.std_logic_1164.all ;

package RegN_package is
	component RegN 
		GENERIC(N : Integer := 4);
		PORT (D : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ;
				Clear, Clock: IN STD_LOGIC ;
				Q : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0) ) ;
	end component;
end RegN_package;
