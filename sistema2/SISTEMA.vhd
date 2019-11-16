library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity SISTEMA is
port
(
	clock, clear : in std_logic;
	entradaMemoria : in std_logic_vector (31 downto 0);
	salidadDelB,direccion : out std_logic_vector (31 downto 0)
);
end SISTEMA;


architecture arch of SISTEMA is

component unidadDeControl
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
end component;
component registro
port(
	clk,
	clr: in  std_logic;
	d:   in  std_logic_vector (31 downto 0);
	q:   out std_logic_vector (31 downto 0)
);
end component;

component alu
port(
	A, B : in std_logic_vector(31 downto 0);
	alu_sel : in std_logic_vector(2 downto 0);
	alu_out : out std_logic_vector(31 downto 0);
	zero : out std_logic
);
end component;

component MUX2
port
(
	enable : in std_logic;--_vector(1 downto 0);
	A, B : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;

component MUX25Bits
port
(
	enable : in std_logic;--_vector(1 downto 0);
	A, B : in std_logic_vector(4 downto 0);
	salida : out std_logic_vector(4 downto 0)
);
end component;

component MUX4
port
(
	enable : in std_logic_vector(1 downto 0);
	A, B, C, D : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;

component signExtend
port
(
	entrada : in std_logic_vector(15 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;


component shiftLeft2
port
(
	cuatroMasSignificativo : in std_logic_vector(3 downto 0);
	entrada : in std_logic_vector(25 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;

component shiftLeft2Abajo
port
(
	entrada : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;

component instructionRegister
port
(
	clk : in std_logic;
	enable : in std_logic;
	entrada : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
);
end component;
component registers
port(
	clk, regWrite : in std_logic;
	readRegister1 : in std_logic_vector (4 downto 0);
	readRegister2 : in std_logic_vector (4 downto 0);
	writeRegister : in std_logic_vector (4 downto 0);
	writeData: in  std_logic_vector (31 downto 0);
	readData1: out std_logic_vector (31 downto 0);
	readData2: out std_logic_vector (31 downto 0)
);
end component;

component cajitaAnds
port(
	entradaZeroAlu, entradaBranch, entradaPcWrite : in std_logic;
	senalSalida : out std_logic
);
end component;

component pc
port(
	enable, clk: in  std_logic;
	entrada:   in  std_logic_vector (31 downto 0);
	salida:   out std_logic_vector (31 downto 0)
);
end component;



--Senales de 1
signal senalBranch, senalPcWrite, senalIorD,senalMemRead, senalMemWrite, senalMemtoReg, senalIRWrite, senalALUSrcA, senalRegWrite,senalRegDst,senalZero,senalCajitaAnds : std_logic;
--Senales de 2
signal senalPCSrc, senalALUSrcB : std_logic_vector(1 downto 0);
--Senales de 3
signal senalALUOp : std_logic_vector(2 downto 0);
--Senales de 6
signal senalIsa31_26 : std_logic_vector(5 downto 0);
--Senales de 5
signal senalIsa25_21, senalIsa20_16, entradaWriteRegister : std_logic_vector(4 downto 0);
--Senales de 15
signal senalIsa15_0 : std_logic_vector(14 downto 0);
--Senales de 25
signal senalIsa25_0 : std_logic_vector(24 downto 0);
--Senales de 32
signal conectorMux2AAbajoRegister,entradaA, entradaB, salidaA, salidaB,conectorMux2AAlu, senalSalidaPc,salidaSignExtend,salidaShiftLeft2Abajo,conectorMux4AAlu,senalMDR,salidaMux3,salidaShiftLeftArriba,salidaAlu, senalSalidaAluOut, conectorAluAluOut : std_logic_vector(31 downto 0);

begin


	--unidad de Control
	unidad_de_control : unidadDeControl
	port map(
	instruction => senalIsa31_26,
	clk => clock,
	nRst => clear,
	Branch => senalBranch,
	PcWrite => senalPcWrite,
	IorD => senalIorD,
	MemRead => senalMemRead,
	MemWrite => senalMemWrite,
	MemtoReg => senalMemtoReg,
	IRWrite => senalIRWrite,
	PCSrc => senalPCSrc,
	ALUOp => senalALUOp, --De tres
	ALUSrcB => senalALUsrcB,
	ALUSrcA => senalALUSrcA,
	RegWrite => senalRegWrite,
	RegDst => senalRegDst
	);

	--Parte del instruction register enviando salidas tanto a registers como 
	instruction_register : instructionRegister
	port map(
	enable => senalIRWrite,
	entrada => entradaMemoria,
	clk => clock,
	salida(31 downto 26) => senalIsa31_26,
	salida(25 downto 21) => senalIsa25_21,
	salida(21 downto 16) => senalIsa20_16,
	salida(15 downto 0) => senalIsa15_0,
	salida(25 downto 0) => senalIsa25_0
	);
	
	--Multiplexor para decidir entre rt o rd
	mux_instruction_a_registers : MUX25Bits
	port map(
	enable => senalRegDst,
	A => senalIsa20_16,
	B => senalIsa15_0(15 downto 11),
	salida => entradaWriteRegister
	);
	
	--Trabajo con el registers
	registers_reg : registers
	port map(
	clk => clock,
	regWrite => senalRegWrite,
	readRegister1 => senalIsa25_21,
	readRegister2 => senalIsa20_16,
	writeRegister => entradaWriteRegister,
	writeData => conectorMux2AAbajoRegister, -- ESta quemado mientras
	readData1 => entradaA,
	readData2 => entradaB
	);
	
	
	--Trabajo con el registro A
	regA : registro
	port map(
	clk => clock,
	clr => clear,
	d => entradaA,
	q => salidaA
	);
	
	-- Trabajo con el registro B
	regB : registro
	port map(
	clk => clock,
	clr => clear,
	d => entradaB,
	q => salidaB
	);
	
	--Trabajo con el mux de 2 entre A y la ALU
	multiplexor2 : MUX2
	port map(
	enable => senalALUSrcA,
	A => senalSalidaPc,
	B => salidaA,
	salida => conectorMux2AAlu
	);
	
	--Trabajo con el mux de 4 entre B y la ALU
	multiplexor4 : MUX4
	port map(
	enable => senalALUsrcB,
	A => salidaB,
	B => ("00000000000000000000000000000100"),
	C => salidaSignExtend,
	D => salidaShiftLeft2Abajo,
	salida => conectorMux4AAlu
	);
	
	
	--Trabajo con el SignExtend
	sign_extend : signExtend
	port map(
	entrada => senalIsa15_0,
	salida => salidaSignExtend
	);
	
	
	--Trabajo con el shiftLeft2 de abajo
	shift_left_2_abajo : shiftLeft2Abajo
	port map(
	entrada => salidaSignExtend,
	salida => salidaShiftLeft2Abajo
	);
	
	--Trabajo con el Memory data register
	memoryDataRegister : registro
	port map(
	clk => clock,
	clr => clear,
	d => entradaMemoria,-------------------------------------
	q => senalMDR
	);
	
	--multiplexor para decidir entre aluout y mdr
	muxMDRALUout : MUX2
	port map(
	enable => senalMemtoReg,
	
	A => senalSalidaAluOut,
	B => senalMDR,
	salida => conectorMux2AAbajoRegister
	);
	--Trabajo caja And y or de arriba
	cajita_and_or : cajitaAnds
	port map(
	entradaZeroAlu => senalZero,
	entradaBranch => senalBranch, 
	entradaPcWrite => senalPcWrite,
	senalSalida => senalCajitaAnds
	);

	--Trabajo con el pc
	pc_counter : pc
	port map(
	enable => senalCajitaAnds,
	clk => clock,
	entrada => salidaMux3,
	salida => senalSalidaPc
	);
	--trabajo shiftLeft2 de arriba
	shift_left_2_arriba :shiftLeft2
	port map(
	cuatroMasSignificativo => senalSalidaPc(31 downto 28),
	entrada => senalIsa25_0,
	salida => salidaShiftLeftArriba
	);
	
	
	--Trabajo con el MUX4 de mas arriba
	multiplexor4Arriba :MUX4
	port map(
	enable => senalALUsrcB,
	A => salidaAlu,
	B => senalSalidaAluOut,
	C => salidaShiftLeftArriba,
	D => ("00000000000000000000000000000000"),
	salida => salidaMux3
	);
	
	
	
	--Trabajo con alu
	aluSiste : alu
	port map(
	
	
	A => conectorMux2AAlu,
	B => conectorMux4AAlu,
	alu_sel => senalALUOp,
	alu_out => conectorAluAluOut,
	zero => senalZero
	);
	
	
	--Trabajo con aluout
	aluOut : registro
	port map(
	clk => clock,
	clr => clear,
	d => conectorAluAluOut,
	q => senalSalidaAluOut
	);
	
	--Trabajo con el mux entre pc y memeory
	muxPCAMemory : MUX2
	port map(
	enable => senalIOrD,
	
	A => senalSalidaPc,
	B => senalSalidaAluOut,
	salida => direccion
	);

end arch;