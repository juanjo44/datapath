library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
entity sistemaComputo is
port
(
  clockS : in std_logic;
  clearS : in std_logic;
  pruebaSalida : out std_logic_vector(31 downto 0)
  
  --address,
  --writeData: in  std_logic_vector (31 downto 0);
  --memRead, memWrite : in std_logic;
  --dataAluOut, memData: out std_logic_vector (31 downto 0)
);

end sistemaComputo;

architecture arch of sistemaComputo is

component SISTEMA
port(
	clock : in std_logic;
	clear : in std_logic;
	entradaMemoria : in std_logic_vector (31 downto 0);
	salidadDelB : out std_logic_vector (31 downto 0);
	direccion : out std_logic_vector (31 downto 0);
	salidaMemWrite : out std_logic;
	salidaMemRead : out std_logic;
	salidaAluOut : out std_logic_vector(31 downto 0)
);
end component;

component principalMemory
port(
	clk : in std_logic;
	address :in std_logic_vector (31 downto 0);
	writeData: in std_logic_vector (31 downto 0);
	memRead :in std_logic;
	memWrite : in std_logic;
	dataOut: out std_logic_vector (31 downto 0)
);
end component;


signal senalSalidadDelB, senalEntradaMemoria, senalDataOut, senalDireccion, senalSalidaAluOut: std_logic_vector(31 downto 0);
signal senalSalidaMemRead, senalSalidaMemWrite : std_logic;

begin
	memoria : principalMemory
	port map(
		clk => clockS,
		address => senalDireccion,
		writeData => senalSalidadDelB,
		memRead => senalSalidaMemRead,
		memWrite => senalSalidaMemWrite,
		dataOut => senalDataOut
	);
	
	procesador : SISTEMA
	port map(
		clock => clockS,
		clear => clearS,
		entradaMemoria => senalDataOut,
		salidadDelB => senalSalidadDelB,
		direccion => senalDireccion,
		salidaMemWrite => senalSalidaMemWrite,
		salidaMemRead => senalSalidaMemRead,
		salidaAluOut => senalSalidaAluOut
	);
	
	pruebaSalida <= senalSalidaAluOut;
end arch;