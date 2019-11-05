library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity shiftLeft2 is
port
(
	cuatroMasSignificativo : in unsigned(3 downto 0);
	entrada : in unsigned(25 downto 0);
	salida : out unsigned(31 downto 0)
);

end shiftLeft2;

architecture arch of shiftLeft2 is
begin
	process (cuatroMasSignificativo, entrada)
	begin
		salida <= cuatroMasSignificativo & "00" & shift_left(entrada, 2);
	end process;
end arch;