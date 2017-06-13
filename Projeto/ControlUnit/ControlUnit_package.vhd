library ieee;
use ieee.std_logic_1164.all;

package ControlUnit_package is
	component ControlUnit
		port (
			clk	: in std_logic;
			clear : in std_logic;
			
			-- Communication with ULA
			E_ALU : out std_logic;
			S_ALU : out std_logic_vector(7 downto 0);
			get_AC : in std_logic_vector(39 downto 0); 
			
			-- Communication with memory
			E_Mem : out std_logic;
			S_Mem : out std_logic;
			MAR	: buffer integer range 0 to 1023;
			
			PC_out : out std_logic_vector(12 downto 0)
		);
	end component;
end ControlUnit_package;