library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity UART_TX is
	port (
			clk, start : in std_logic;
			busy, tx_line : out std_logic; --tx_line = saida do transmissor para a FPGA
			data_in : in std_logic_vector(7 downto 0)
		);
end UART_TX;

architecture Behavior of UART_TX is
	signal prescaler : integer range 0 to 5208 := 0;
	signal index : integer range 0 to 9 := 0;
	signal data_receiver : std_logic_vector(9 downto 0);
	signal tx_flag : std_logic := '0';
begin
	
	process(clk)
	begin
		if(clk'event and clk = '1') then	
			if(tx_flag = '0' and start = '1') then
				tx_flag <= '1';
				busy <= '1';
				data_receiver(0) <= '1';
				data_receiver(9) <= '0';
				data_receiver(8 downto 1) <= data_in;
			end if;
			if(tx_flag = '1') then 
				if(prescaler < 5207) then
					prescaler <= prescaler + 1;
				else
					prescaler <= 0;
				end if;
				if(prescaler = 2607) then	
					tx_line <= data_receiver(index);
					
					if(index < 9) then
						index <= index + 1;
					else
						tx_flag <= '0';
						busy <= '0';
						index <= 0;
					end if;
				end if;
			end if;
		end if;
	end process;
end Behavior;

	
