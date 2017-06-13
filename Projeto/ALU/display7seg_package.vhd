library ieee;
use ieee.std_logic_1164.all ;
library work;
use work.all;

package display7seg_package is
	component display7seg port(
			en : in std_logic;
			number : in std_logic_vector(3 downto 0);
			display_segments : out std_logic_vector(6 downto 0));
	end component;
end display7seg_package;