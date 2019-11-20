library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;

entity principalMemory is
port
(
  clk : in std_logic;
  address,
  writeData: in  std_logic_vector (31 downto 0);
  memRead, memWrite : in std_logic;
  dataOut: out std_logic_vector (31 downto 0)
);

end principalMemory;

architecture arch of principalMemory is
	type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
	signal RAM: ram_type;
	signal a_reg: std_logic_vector(5 downto 0);
begin
	process(clk)
	begin
		if(clk'event and clk = '1' and memRead = '1') then
			dataOut <= RAM(conv_integer(address));
			if (memWrite = '1') then
				RAM(conv_integer(address)) <= writeData;
			end if;
		end if;
	end process;
end arch;
			