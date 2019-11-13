library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port(
	A, B : in std_logic_vector(7 downto 0);
	alu_sel : in std_logic_vector(2 downto 0);
	alu_out : out std_logic_vector(7 downto 0);
	zero : out std_logic
	);
end alu;

architecture Comportamiento of alu is
begin
	with alu_sel select
		alu_out <= A + B when "000",
						A - B when "001",
						A and B when "010",
						A or B when "011",
						A when "100",
						B when "101",
						not A when "110",
						not B when others;
	if alu_out = '0' then
		zero <= '1';
	else
		zero <= '0';
	end if;

end Comportamiento;