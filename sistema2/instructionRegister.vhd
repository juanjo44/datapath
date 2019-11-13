library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity instructionRegister is
port
(
	clk : in std_logic;
	enable : in std_logic;
	entrada : in std_logic_vector(31 downto 0);
	salida : out std_logic_vector(31 downto 0)
	---salida31_26 : out std_logic_vector(5 downto 0);
	---salida25_21 : out std_logic_vector(4 downto 0);
	---salida20_16 : out std_logic_vector(4 downto 0);
	---salida15_0  : out std_logic_vector(15 downto 0)
);

end instructionRegister;

architecture arch of instructionRegister is
begin
	process (enable, clk)
	begin
    if ( clk'event and clk = '1' and enable = '1' ) then
		salida <= entrada;
    end if;
		---salida31_26 <= entrada(31 downto 26);
		---salida25_21 <= entrada(25 downto 21);
		---salida20_16 <= entrada(20 downto 16);
		----salida15_0 <= entrada(15 downto 0);
	end process;
end arch;