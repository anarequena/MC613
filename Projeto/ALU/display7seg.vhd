library ieee;
use ieee.std_logic_1164.all ;
library work;
use work.all;

entity display7seg is
	port( en : in std_logic;
			number : in std_logic_vector(3 downto 0);
			display_segments : out std_logic_vector(6 downto 0));
end display7seg;

architecture structure of display7seg is
signal display : std_logic_vector(6 downto 0);
begin
	process(en)
	begin
		if(en'event and en = '1') then
			case number is
				when "0000" => display <=  "0111111";
				when "0001" => display <=  "0000110";
				when "0010"=> display <= "1011011" ;
				when "0011" => display <=  "1001111" ;
				when "0100"=> display <="1100110" ;
				when "0101"=> display <="1101101";
				when "0110"=> display <="1111101" ;
				when "0111"=> display <="0000111";
				when "1000"=> display <="1111111" ;
				when "1001"=> display <="1101111";
				when "1010"=> display <="1110111" ;
				when "1011"=> display <="1111100";
				when "1100"=> display <="0111001";
				when "1101"=> display <="1011110" ;
				when "1110"=> display <="1111001";
				when "1111"=> display <="1110001";
			end case;
		end if;
	end process;	
	display_segments <= not display;
end structure;