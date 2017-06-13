library ieee;
use ieee.std_logic_1164.all;

package ALU_package is
	component ALU 
		port (clk : in std_logic;
			S   : in std_logic_vector(7 downto 0);
			AC, MQ, MBR : buffer std_logic_vector(39 downto 0)
		);
	end component;
end ALU_package;