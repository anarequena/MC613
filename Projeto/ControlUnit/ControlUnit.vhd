library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity ControlUnit is
	port (clk	: in std_logic;
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
end ControlUnit;

architecture Behavior of ControlUnit is
	signal jump_flag :std_logic := '0'; 				--'1' if a jump instruction qas executed
	signal jump_right_flag : std_logic := '0'; 		-- 1 if jump to right was executed
	signal PC: std_logic_vector(12 downto 0); 		-- value of PC register
	signal PC_en: std_logic := '0'; 							-- PC enable
	
	type Cycle_type is (fetch_left, fetch_right, exec);
	signal current_cycle, next_cycle : Cycle_type;  -- FSM
	
	
	signal mv_PC2MAR : std_logic := '0'; 				-- move PC to MAR flag
	signal mv_IBR2IR : std_logic := '0'; 				-- move instruction opcode from IBR to IR
	signal mv_IBR2MAR : std_logic := '0';				-- 
	signal pre_en_mem : std_logic := '0';	
	
	signal fetch_right_flag : std_logic := '0';
	signal fetch_left_flag : std_logic := '0';
	signal execute_flag : std_logic := '0';
	
	signal MBR : std_logic_vector(11 downto 0);

begin
	-- OP codes:
	--
	-- Data 
	-- 	00001010 LOAD  				=> MQ AC := MQ
	-- 	00001001 LOAD MQ,M(X)   	=> MQ := Mem[X]
	-- 	00100001 STOR M(X) 			=> Mem[X] := AC
	--		00000001 LOAD M(X) 			=> AC := Mem[X]
	-- 	00000010 LOAD -M(X) 			=> AC := -(Mem[X])
	-- 	00000011 LOAD |M(X)| 		=> AC := |Mem[X]|)
	--
	-- Jumps
   -- 	00001101 JUMP M(X,0:19) 	=> PC := X, left 
	-- 	00001110 JUMP M(X,20:39)	=> PC := X, right
	-- 	00001111 JUMP+M(X,0:19)		=> if(AC >= 0) then PC := X, left
	-- 	00010000 JUMP+M(X,20:39) 	=> if(AC >= 0) then PC := X, right
	--
	-- Arithmetic
	--		00000101 ADD M(X) 			=> AC := AC + Mem[X]
	-- 	00000111 ADD |M(X)| 			=> AC := AC + |Mem[X]|
	-- 	00000110 SUB M(X) 			=> AC := AC - Mem[X]
	-- 	00001000 SUB |M(X)| 			=> AC := AC - |Mem[X]|
	-- 	00001011 MUL M(X) 			=> AC:MQ := MQ × Mem[X]
	--		00001100 DIV M(X) 			=> MQ := AC / Mem[X], AC := AC % Mem[X]
	-- 	00010100 LSH 					=> AC := AC << 1
	-- 	00010101 RSH 					=> AC := AC >> 1	
	--
	-- Address modification
	--		00010010 STOR M(X,8:19) 	=> M(X)(19 downto 8) := AC(11 downto 0)
	-- 	00010011 STOR M(X,28:39) 	=> M(X)(39 downto 28) := AC(11 downto 0)	
	
	-- Update FSM and enables 
	process(clk)
	begin
		if(clk'event and clk = '1') then
			fetch_right_flag <= '0';
			fetch_left_flag <= '0';
			execute_flag <= '0';
			PC_en <= '0';
			
			case current_cycle is
				when fetch_Left =>
					next_cycle <= exec;
					fetch_left_flag <= '1';
				
				when fetch_right =>
					next_cycle <= exec;
					fetch_right_flag <= '1';
					
				when others =>
					-- execution: ver se o prox vai ser left ou right
					if(PC(0) = '1') then -- ou a instrucao vai ser um jump pra direita... 
						next_cycle <= fetch_right;
					else
						next_cycle <= fetch_left;
					end if;
						
					execute_flag <= '1';
					PC_en <= '1';
				
			end case;
		end if;
	end process;
	
	current_cycle <= next_cycle;
	
	-- fetch Left Cyle
	process(fetch_left_flag)
	begin
		if(fetch_left_flag'event and fetch_left_flag = '1') then
		end if;
			
	end process;
	
	-- fetch Right Cycle
	process(fetch_right_flag)
	begin
		if(fetch_right_flag'event and fetch_right_flag = '1') then
			if(jump_flag = '1') then
				mv_PC2MAR <= '1';
				pre_en_mem <= '1';
				--continuar
			else
				mv_IBR2IR <= '1';
				mv_IBR2MAR <= '1';
			end if;
		end if;
	end process;
	
	-- Execution Cyle
	process(execute_flag)
	begin
		if(execute_flag'event and execute_flag = '1') then
			jump_flag <= '0';
			jump_right_flag <= '0';
		end if;
	end process;

	
	-- TESTE PC
	process(PC_en)
	begin
		if(clear = '1') then
			PC <= (others => '0');
		elsif(PC_en'event and PC_en = '1') then
			PC <= std_logic_vector(unsigned(PC) + 1);
			PC_out <= PC;
		end if;
	end process;
	
end Behavior;