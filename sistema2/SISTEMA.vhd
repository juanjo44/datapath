library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity SISTEMA is
port
(
	clock, clear : in std_logic;
	entradaSistema : in std_logic_vector (31 downto 0);
	regDst : in std_logic;
	enableMux4 : in std_logic_vector (1 downto 0);
	enableMux2 : in std_logic;
	salidaAlu: out std_logic_vector (7 downto 0)
);
end SISTEMA;


architecture arch of SISTEMA is
component registro
port(
	clk,
	clr: in  std_logic;
	d:   in  std_logic_vector (7 downto 0);
	q:   out std_logic_vector (7 downto 0)
);
end component;

component alu
port(
	A, B : in std_logic_vector(31 downto 0);
	alu_sel : in std_logic_vector(2 downto 0);
	alu_out : out std_logic_vector(31 downto 0)
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
	A, B, C, D : in std_logic_vector(7 downto 0);
	salida : out std_logic_vector(7 downto 0)
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
	cuatroMasSignificativo : in unsigned(3 downto 0);
	entrada : in unsigned(25 downto 0);
	salida : out unsigned(31 downto 0)
);
end component;

component shiftLeft2Abajo
port
(
	entrada : in unsigned(31 downto 0);
	salida : out unsigned(31 downto 0)
);
end component;

component instructionRegister
port
(
	entrada : in std_logic_vector(31 downto 0);
	salida31_26 : out std_logic_vector(5 downto 0);
	salida25_21 : out std_logic_vector(4 downto 0);
	salida20_16 : out std_logic_vector(4 downto 0);
	salida15_0  : out std_logic_vector(15 downto 0)
);
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

signal isa31_26, isa25_21, isa20_16, isa15_0, entradaA, entradaB, salidaA, salidaB, salidaSignExtend,salidaShiftLeft2Abajo, conectorMux2AAlu, conectorMux4AAlu, conectorAluAluOut:std_logic_vector (7 downto 0);

begin

	--Parte del instruction register enviando salidas tanto a registers como 
	instruction_register : instructionRegister
	port map(
	entrada => entradaSistema,
	salida31_26 => isa31_26,
	salida25_21 => isa25_21,
	salida20_16 => isa20_16,
	salida15_0 => isa15_0
	);
	
	--Multiplexor para decidir entre rt o rd
	mux_instruction_a_registers : MUX25Bits
	port map(
	enable => regDst,
	A => isa20_16,
	B => isa15_0(15 downto 11)
	salida => entradaWriteRegister
	);
	
	--Trabajo con el registers
	registers_ : registers
	port map(
	clk => clock,
	regWrite => regWriteUC,
	readRegister1 => isa25_21,
	readRegister2 => isa20_16,
	writeRegister => entradaWriteRegister,
	writeData => ("00000000000000000000000000000000"), -- ESta quemado mientras
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
	enable => ALUscrA,
	A => , -- PC Counter
	B => salidaA,
	salida => conectorMux2AAlu
	);
	
	--Trabajo con el mux de 4 entre B y la ALU
	multiplexor4 : MUX4
	port map(
	enable => enableMux4,
	A => salidaB,
	B => ("00000000000000000000000000000100"),
	C => salidaSignExtend,
	D => salidaShiftLeft2Abajo,
	salida => conectorMux4AAlu
	);
	
	
	--Trabajo con el SignExtend
	sign_extend : signExtend
	port map(
	entrada => isa15_0,
	salida => salidaSignExtend
	);
	
	
	--Trabajo con el shiftLeft2 de abajo
	shift_left_2_abajo : shiftLeft2Abajo
	port map(
	entrada => salidaSignExtend,
	salida => salidaShiftLeft2Abajo
	);
	
	aluSiste : alu
	port map(
	A => conectorMux2AAlu,
	B => conectorMux4AAlu,
	alu_sel => ("000"),
	alu_out => conectorAluAluOut 
	);
	
	aluOut : registro
	port map(
	clk => clock,
	clr => clear,
	d => conectorAluAluOut,
	q => salidaAlu
	);


end arch;