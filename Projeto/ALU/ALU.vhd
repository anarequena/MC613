library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (clk : in std_logic;
			S   : in std_logic_vector(7 downto 0);
			AC, MQ, MBR : buffer std_logic_vector(39 downto 0)
			);
end ALU;

architecture Behavior of ALU is
	signal mul : std_logic_vector(79 downto 0);
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
	
	process(clk)
	begin
		if(clk'event and clk = '1') then
			-- Supondo que MBR ja recebeu o valor de Mem[X]
			case S is
			-- DATA 
				-- LOAD => MQ AC := MQ
				when "00001010" =>
					AC <= MQ;
					
				-- LOAD MQ,M(X) => MQ := Mem[X]
				when "00001001" =>
					MQ <= MBR;
					
				-- STOR M(X) => Mem[X] := AC
				when "00100001" =>
					MBR <= AC;
					
				-- LOAD M(X) => AC := Mem[X]
				when "00000001" =>
					AC <= MBR;
					
				-- LOAD -M(X) => AC := -(Mem[X])
				when "00000010" =>
					AC <= std_logic_vector(0 - signed(MBR));
				
				-- LOAD |M(X)| => AC := |Mem[X]|)
				when "00000011" =>
					if(signed(MBR) >= 0) then
						AC <= MBR;
					else 
						AC <= std_logic_vector(0 - signed(MBR));
					end if;
					
			-- JUMPS 
				
				
			-- ARITHMETIC 
				-- ADD M(X): AC := AC + Mem[X] ;
				when "00000101" => 
					AC <= std_logic_vector(signed(AC) + signed(MBR));  
					
				-- ADD |M(X)|: AC := AC + |Mem[X]|	
				when "00000111" => 
					if(signed(MBR) >= 0) then
						AC <= std_logic_vector(signed(AC) + signed(MBR));
					else
						AC <= std_logic_vector(signed(AC) - signed(MBR));
					end if;
					
				-- SUB M(X): AC := AC - Mem[X] ;
				when "00000110" => 
					AC <= std_logic_vector(signed(AC) - signed(MBR));
					
				-- SUB |M(X)|: AC := AC - |Mem[X]| ;
	 	      when "00001000" =>
					if(signed(MBR) >= 0) then
						AC <= std_logic_vector(signed(AC) - signed(MBR));
					else
						AC <= std_logic_vector(signed(AC) + signed(MBR));
					end if;
					
				-- MUL M(X): AC:MQ := MQ * Mem[X] ;
				when "00001011" =>
					mul <= std_logic_vector(signed(MQ) * signed(MBR));
					AC <= mul(79 downto 40);
					MQ <= mul(39 downto 0);
				
				-- DIV M(X): MQ := AC / Mem[X] AC := AC % Mem[X] ;
				when "00001100" => 
					MQ <= std_logic_vector(signed(AC)/signed(MBR));
				   AC <= std_logic_vector(signed(AC) rem signed(MBR));
				
				-- LSH: AC := AC << 1 ;
				when "00010100" =>
					lsh: for i in 1 to 39 loop
						AC(i) <= AC(i-1);
						end loop;
					AC(0) <= '0';
					
				-- RSH: AC := AC >> 1 ;
				when "00010101" => 
					rsh: for i in 0 to 38 loop
						AC(i) <= AC(i+1);
						end loop;
					AC(39) <= '0';
				
				-- Invalid instructions - por enquanto coloca 1 em AC e MQ, ver oq fazer nesses casos
				when others =>
					AC <= (others => '0');
					AC(0) <= '1';
					MQ(39 downto 1) <= (others => '0');
					MQ(0) <= '1';
			end case;
		end if;
	end process;
end Behavior;