library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shiftLeft2Abajo is
port
(
	entrada : in unsigned(31 downto 0);
	salida : out unsigned(31 downto 0)
);

end shiftLeft2Abajo;

architecture arch of shiftLeft2Abajo is
begin
	process (entrada)
	begin
		salida <= shift_left(entrada, 2);
	end process;
end arch;