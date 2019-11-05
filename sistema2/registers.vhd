library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity registers is
port
(
  clk, regWrite : in std_logic;
  readRegister1 : in std_logic_vector (4 downto 0);
  readRegister2 : in std_logic_vector (4 downto 0);
  writeRegister : in std_logic_vector (4 downto 0);
  writeData: in  std_logic_vector (31 downto 0);
  readData1: out std_logic_vector (31 downto 0);
  readData2: out std_logic_vector (31 downto 0)
);

end registers;

architecture arch of registers is
	type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
	signal RAM: ram_type;
	signal a_reg: std_logic_vector(5 downto 0);
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			readData1 <= RAM(conv_integer(readRegister1));
			readData2 <= RAM(conv_integer(readRegister2));
			if (regWrite = '1') then
				RAM(conv_integer(writeRegister)) <= writeData;
			end if;
		end if;
	end process;
end arch;
			
			
	