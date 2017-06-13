library ieee;
use ieee.std_logic_1164.all;

package UART_TX_package is
	component UART_TX
	port (
			clk, start : in std_logic;
			busy, tx_line : out std_logic; --tx_line = saida do transmissor para a FPGA
			data_in : in std_logic_vector(7 downto 0)
		);
	end component;
end UART_TX_package;