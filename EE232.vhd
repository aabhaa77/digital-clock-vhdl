library IEEE;
use IEEE.std_logic_1164.all;
package EE232 is

component NOT_1 is

	port( I0 : in std_logic;
			O0 : out std_logic);
end component;

component AND_2 is

	port( I0, I1 : in std_logic;
			O0 : out std_logic);
end component;

component OR_2 is

	port( I0, I1 : in std_logic;
			O0 : out std_logic);
end component;

component XOR_2 is

	port( I0, I1 : in std_logic;
			O0 : out std_logic);
end component;

COMPONENT HALF_ADDER is

	port( A, B : in std_logic;
			S, C : out std_logic);
end COMPONENT;

component FULL_ADDER is

	port( I0, I1,  I2: in std_logic;
			S, C : out std_logic);
end component;

component MUX_2X1 is
	port(I0, I1, S0 : in std_logic;
		O0 : out std_logic); 
end component;

COMPONENT DEMUX_1X2 IS

	PORT(X0, S: IN STD_LOGIC;
	Y0, Y1 : OUT STD_LOGIC);
END COMPONENT;

COMPONENT FOUR_BIT_ADDER IS

	port (A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		CIN : in std_logic;
		SUM : out std_logic_vector(4 downto 0));
		
end COMPONENT;

COMPONENT CONVERTER1 IS

	port(A : in std_logic_vector(3 downto 0);
   	 B : out std_logic_vector(3 downto 0);
   	 INV : out std_logic);

end COMPONENT;

COMPONENT Converter2 is
    port(A : in std_logic_vector(3 downto 0);
   	 B : out std_logic_vector(3 downto 0));
end COMPONENT;

component D_FF is -- Entity declaration
    port( D : in std_logic; -- Data input of the D flipflop
          CLK : in std_logic; -- Clock input of the D flipflop
          CLRN : in std_logic; -- Active low clear input of the D flipflop
          PREN : in std_logic; -- Active low preset input of the D flipflop
          Q : buffer std_logic; -- Q output of the D flipflop
          QN : out std_logic); -- Q_bar output of the D flipflop
end component;

COMPONENT CLK_DVD is
    port(CLK_IN : in std_logic;          -- Input clock
            RSTN : in std_logic;         -- Active low reset
            CLK_OUT : out std_logic);    -- Output clock
end COMPONENT;

end package;