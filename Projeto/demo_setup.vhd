library ieee;
use ieee.std_logic_1164.all;

use work.all;

entity demo_setup is
	port (SW : in std_logic_vector(9 downto 0);
			KEY : in std_logic_vector(3 downto 0);
			LEDR : out std_logic_vector(9 downto 0);
			LEDG : out std_logic_vector(7 downto 0);
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			CLOCK_50 : in std_logic;
			UART_TXD : out std_logic;
			UART_RXD : in std_logic
			);
end demo_setup;

architecture Comportamento of demo_setup is
signal conv_7seg : std_logic_vector(12 downto 0);
signal en_hex : std_logic;
signal clk : std_logic;

begin
	clock_d: ClockDivisor 
	port map(
		Clock_quartus => CLOCK_50,
		clock => clk
	);	


	ias0: IAS 
	port map(
		clk => clk,
		reset => not KEY(0), 
		load_memory_map => not KEY(1),
		leds => conv_7seg
	);

	
	-- Display current PC on HEXs
	leds0: display7seg port map(CLOCK_50, "000" & conv_7seg(0), HEX0);
	leds: display7seg port map(CLOCK_50, conv_7seg(4 downto 1), HEX1);
	leds1: display7seg port map(CLOCK_50, conv_7seg(8 downto 5), HEX2);
	leds2: display7seg port map(CLOCK_50, conv_7seg(12 downto 9), HEX3);
end Comportamento;
