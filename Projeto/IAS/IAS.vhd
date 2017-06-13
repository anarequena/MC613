library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity IAS is
	port (clk, reset, load_memory_map : in std_logic;
			leds : out std_logic_vector(12 downto 0)
			);
end IAS;

architecture Behavior of IAS is

	-- Between ULA and Control Unit
	signal sig_S_ALU : std_logic_vector(7 downto 0);
	signal sig_AC : std_logic_vector(39 downto 0);
	signal en_ALU : std_logic;
	
	-- Between Control Unit and Memory
	signal sig_S_Mem : std_logic;
	signal sig_addres: integer range 0 to 1023;
	signal en_Mem: std_logic;
	
	-- Between Memory and ULA
	signal sig_mem_data : std_logic_vector(39 downto 0);
	
	-- Between ULA and I/O (?)

	
begin

-- Create Control Unit
control_unit: ControlUnit 
	port map(
		clk	=> clk,
		clear => reset,
			
		-- Communication with ULA
		E_ALU => En_ALU,
		S_ALU => sig_S_ALU,
		get_AC => sig_AC,
		
		-- Communication with memory
		E_Mem => En_Mem,
		S_Mem => sig_S_Mem,
		MAR	=> sig_addres,
		
		PC_out => leds
	);

-- Create Memory
memory : single_port_ram

	generic map(
		DATA_WIDTH => 40,
		ADDR_WIDTH => 10
	)

	port map(
		clk	=> En_Mem,
		addr	=> sig_addres,
		data	=> sig_mem_data,
		we		=> sig_S_Mem,
		q		=> sig_mem_data
	);

-- Create ALU	
logic_arit_unit : ALU 
	port map(
		clk => En_ALU,
		S   => sig_S_ALU,
		AC	 => sig_AC,
 		MBR => sig_mem_data
	);

	
end Behavior;