library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unidadDeControl is
<<<<<<< HEAD
=======
--generic(ClockFrecuencyHz : integer);
>>>>>>> 622574e56f7174b9488f3a36987201c31f742f28
port(
	instruction	: in std_logic_vector (5 downto 0);
	Clk			: in  std_logic;
	nRst			: in	std_logic;  --NEgative reset
	Branch 		: out std_logic;
	PcWrite 		: out std_logic;
	IorD 			: out std_logic;
	MemRead 		: out std_logic;
	MemWrite 	: out std_logic;
	MemtoReg 	: out std_logic;
	IRWrite 		: out std_logic;
	PCSrc 		: out std_logic_vector (1 downto 0);
	ALUOp 		: out std_logic_vector (1 downto 0);
	ALUSrcB 		: out std_logic_vector (1  downto 0);
	ALUSrcA 		: out std_logic;
	RegWrite 	: out std_logic;
	RegDst 		: out std_logic
	);
end entity;

architecture uc of unidadDeControl is

	type uc_state is (Fetch, Decode, MemAddr, Execute,TipoI,TipoIWriteBack, BranchState, Jump, MemReadState, MemWriteState, AluWriteback, MemWriteback);
	signal State : uc_state;
	
begin

	process(Clk) is
	begin
		if rising_edge(Clk) then
			if state = Fetch then
				state <= Decode;
			else if state = Decode then
				--lw o sw
            if instruction = "100011" or instruction = "101011" then
            state <= MemAddr;
            --R-type
            elsif instruction = "000000" then
            state <= Execute;
            --beq
            elsif instruction = "000100" then
            state <= BranchState;
				--jump
				-- PENDIENTE
				-- -DSFWEFG
				--GFWEGWEG
				--EGWEGERG
				--elsif instruction = "..." then
				--state <= Jump;
            --addi
<<<<<<< HEAD
            else
=======
            --elsif instruction = "001000" then
				else
>>>>>>> 622574e56f7174b9488f3a36987201c31f742f28
            state <= TipoI;
            end if;
			elsif state = memAddr then
            --if lw
            if instruction = "100011" then
            state <= memReadState;
            else
            state <= memWriteState;
            end if;
			elsif state = TipoI then
            state <= TipoIWriteBack;
			elsif state = TipoIWriteBack then
            state <= Fetch;
			elsif state = memReadState then
            state <= memWriteBack;
			elsif state = memWriteBack then
            state <= Fetch;
			elsif state = memWriteState then
            state <= Fetch;
			elsif state = execute then
            state <= AluWriteback;
<<<<<<< HEAD
			else 
=======
			else-- state = AluWriteback then
>>>>>>> 622574e56f7174b9488f3a36987201c31f742f28
            state <= Fetch;
			--elsif state = "1000" then
            --currentState <="0000";
        end if;
		end if;
		end if;
	end process;
	
	process(state) is
	begin
			if nRst =  '0' then
				--Reset values
				--state		<= Fetch;
				Branch	<= '0';
				PcWrite	<= '0';
				IorD		<= '0';
				MemRead	<= '0';
				MemWrite <= '0';
				MemToReg <= '0';
				IRWrite	<= '0';
				PCSrc		<= "00";
				ALUOp		<= "00";
				ALUSrcB	<= "00";
				ALUSrcA	<= '0';
				RegWrite <= '0';
				regDst	<='0';
			else
			--	CUIDADO CON ESTA PARTE
				Branch	<= '0';
				PcWrite	<= '0';
				IorD		<= '0';
				MemRead	<= '0';
				MemWrite <= '0';
				MemToReg <= '0';
				IRWrite	<= '0';
				PCSrc		<= "00";
				ALUOp		<= "00";
				ALUSrcB	<= "00";
				ALUSrcA	<= '0';
				RegWrite <= '0';
				regDst	<= '0';
				
				case State is 
					when Fetch =>
						IorD <= '0';
						MemRead <= '1';
						ALUSrcA <= '0';
						ALUSrcB <= "01";
						ALUOp <= "00";
						PCSrc <= "00";
						IRWrite <= '1';
						PCWrite <= '1';
						-- las demas se ponen en 0's
						Branch	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						RegWrite <= '0';
						regDst	<='0';
					when Decode =>
						AluSrcA <= '0';
						AluSrcB <= "11";
						AluOp <= "00";
						-- los demas se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						RegWrite <= '0';
						regDst	<='0';
					--if instruction = "100011" or instruction = "101011" and state
					when MemAddr =>
						AluSrcA <= '1';
						AluSrcB <= "10";
						ALUOp <= "00";
						-- los demas se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						RegWrite <= '0';
						regDst	<='0';
						--aqui  va un if para decidir siguiente  estado
					when Execute =>
						AluSrcA <= '1';
						AluSrcB <= "00";
						ALUOp <= "10";
						-- los demas se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						RegWrite <= '0';
						regDst	<='0';
					when BranchState =>
						AluSrcA <= '1';
						AluSrcB <= "00";
						ALUOp <= "01";
						PCSrc <= "01";
						Branch <= '1';
						-- los demas se ponen en 0's
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						RegWrite <= '0';
						regDst	<='0';
					when Jump =>
						PCSrc <= "10";
						PCWrite <= '1';
						-- LAS DEMAS SEÑALES SE PONEN EN 0'S
						Branch	<= '0';
						--PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						--PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						RegWrite <= '0';
						regDst	<= '0';
					when MemReadState =>
						IorD <= '1';
						MemRead <= '1';
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						--IorD		<= '0';
						--MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						RegWrite <= '0';
						regDst	<= '0';
					when MemWriteState =>
						IorD <= '1';
						MemWrite <= '1';
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						--IorD		<= '0';
						MemRead	<= '0';
						--MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						RegWrite <= '0';
						regDst	<= '0';
					when AluWriteback =>
						RegDst <= '1';
						MemToReg <= '0';
						RegWrite <= '1';
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						--MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						--RegWrite <= '0';
						--regDst	<= '0';
					when MemWriteback =>
						RegDst <= '0';
						MemToReg <= '1';
						RegWrite <= '1';
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						--MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						--RegWrite <= '0';
						--regDst	<= '0';
					when tipoI =>
						PCWrite <= '0';
						PCSrc <= "10";
						ALUOp <= "00";
						ALUSrcB <= "10";
						ALUSrcA <= '1';
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						--PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						--PCSrc		<= "00";
						--ALUOp		<= "00";
						--ALUSrcB	<= "00";
						--ALUSrcA	<= '0';
						RegWrite <= '0';
						regDst	<= '0';
					when TipoIWriteBack =>
						PCSrc <= "00";
						ALUOp <= "00";
						ALUSrcB <= "00";
						ALUSrcA <= '0';
						RegWrite <= '1';
<<<<<<< HEAD
						-- las demas señales se ponen en 0's
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						--PCSrc		<= "00";
						--ALUOp		<= "00";
						--ALUSrcB	<= "00";
						--ALUSrcA	<= '0';
						--RegWrite <= '0';
						regDst	<= '0';
=======
>>>>>>> 622574e56f7174b9488f3a36987201c31f742f28
					when others =>
						state		<= Fetch;
						Branch	<= '0';
						PcWrite	<= '0';
						IorD		<= '0';
						MemRead	<= '0';
						MemWrite <= '0';
						MemToReg <= '0';
						IRWrite	<= '0';
						PCSrc		<= "00";
						ALUOp		<= "00";
						ALUSrcB	<= "00";
						ALUSrcA	<= '0';
						RegWrite <= '0';
						regDst	<='0';
				end case;
			
			end if;
	end process;
	
end architecture;