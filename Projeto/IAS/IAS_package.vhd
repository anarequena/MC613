library ieee;
use ieee.std_logic_1164.all;

package IAS_package is
	component IAS 
	port (clk, reset, load_memory_map : in std_logic;
			leds : out std_logic_vector(11 downto 0)
			);
	end component;
end IAS_package;