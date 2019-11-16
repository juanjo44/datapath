library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port(
	A, B : in std_logic_vector(31 downto 0);
	alu_sel : in std_logic_vector(2 downto 0);
	alu_out : out std_logic_vector(31 downto 0);
	zero : out std_logic
	);
end alu;

architecture Comportamiento of alu is
begin
	process(alu_sel)
	variable aux : std_logic_vector(31 downto 0);
	begin
		if alu_sel = "000" then
			aux := A + B;
		elsif alu_sel = "001" then
			aux := A - B;
		elsif alu_sel = "010" then
			aux := A and B;
		elsif alu_sel = "011" then
			aux := A or B;
		elsif alu_sel = "100" then
			aux := A;
		elsif alu_sel = "101" then
			aux := B;
		elsif alu_sel = "110" then
			aux := not A;
		elsif  alu_sel = "111" then
			aux := not B;
		end if;
	
	if (aux = "00000000000000000000000000000000") then
		zero <= '1';
	else
		zero <= '0';
	end if;
	
	alu_out <= aux;
	
	end process;
end Comportamiento;