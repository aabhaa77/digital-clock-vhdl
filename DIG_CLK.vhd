library ieee;
use ieee.std_logic_1164.all;
use work.EE232.all;

entity DIG_CLK is
	port(CLK : in std_logic;
		RSTN : in std_logic;
		--STP : in std_logic;
		LDN0 : in std_logic;
		LDN1 : in std_logic;
		LDN2 : in std_logic;
		LDN3 : in std_logic;
		D1 : in std_logic_vector(3 downto 0);
		Sec0 : out std_logic_vector(6 downto 0);
		Sec1 : out std_logic_vector(6 downto 0);
		min0 : out std_logic_vector(6 downto 0);
		min1 : out std_logic_vector(6 downto 0);
		hour0 : out std_logic_vector(6 downto 0);
		hour1 : out std_logic_vector(6 downto 0));
end DIG_CLK;

architecture STRUCTURE of DIG_CLK is

signal D, N0, N1, N2, N3, X2, X3, X4, N4, N5, N6, Q7, LDN : std_logic_vector(3 downto 0);
signal E1, E2, E3, E4, E5, RSTN1, RSTN2, RSTN4, RSTN5, RSTN6, RSTN7, S, O, O1 : std_logic;
signal X, X5,I : std_logic_vector(7 downto 0);
signal X1 : std_logic_vector(9 downto 0);
signal E : std_logic_vector(5 downto 0);
signal Q1, Q2, Q3, Q4, Q5, Q6 : std_logic_vector(3 downto 0);				--counter outputs

begin
	D(0) <= '0';
	D(1) <= '0';
	D(2) <= '0';
	D(3) <= '0';
	
	--Reset signal for sec0 counter:
	W0 : AND_2 port map (Q1(3),N1(2),X2(0));
	W1 : AND_2 port map (N1(1),Q1(0),X2(1));
	W2 : AND_2 port map (X2(0),X2(1),X2(2));--
	W3 : MUX_2X1 port map (RSTN, '0', X2(2), X2(3));
	
	--Enable signal for sec0 counter:
	--T1 : MUX_2X1 port map ('1', '0', STP, E(0));
	
	--sec0 counter:
	C1 : MODULO11 port map (CLK, X2(3), '1', '1', E(0), D(3 downto 0), Q1(3 downto 0));
	
	--Reset signal for Sec1 counter:
	NOT_BANK1 :
		for i in 0 to 3 generate 
			U1 : NOT_1 port map(Q1(i), N1(i));
		end generate;	
	NOT_BANK2 :
		for i in 0 to 3 generate 
			U2 : NOT_1 port map(Q2(i), N2(i));
		end generate;
	U3 : AND_2 port map (N2(3),Q2(2), X(0)); 
	U4 : AND_2 port map (N2(1),Q2(0), X(1));
	U5 : AND_2 port map (X(0), X(1), X(2)); --5 condition 
	U6 : AND_2 port map (Q1(3), N1(2), X(3));
	U7 : AND_2 port map (N1(1), Q1(0), X(4));
	U8 : AND_2 port map (X(3), X(4), X(5)); --9 condition
	U9 : AND_2 port map (X(2), X(5), X(6)); --59 condition
	U10 : MUX_2X1 port map (RSTN, '0', X(6), X(7));
	
	--Enable for Sec1:
	M2 : MUX_2X1 port map ('0','1',X2(2),E1);
	--T2 : MUX_2x1 port map (E1,'0', STP, E(1));
	
	--Sec1 counter:
	C2 : MODULO7 port map (CLK, X(7), '1', '1',E(1), D(3 downto 0), Q2(3 downto 0));
	
	--Reset for min0:
	V0 : NOT_1 port map (Q3(2),N3(2));
	V1 : AND_2 port map (Q3(3),N3(2),X1(0));
	V2 : AND_2 port map (Q3(3),Q3(1),X1(1));
	V3 : AND_2 port map (X1(1),Q3(0),X1(2));
	V4 : OR_2 port map (X1(0),X1(2),X1(3));--modulo 11
	V5 : NOT_1 port map (Q3(1),N3(1));
	V6 : AND_2 port map (Q3(3),N3(2), X1(4));
	V7 : AND_2 port map (N3(1),Q3(0), X1(5));
	V8 : AND_2 port map (X1(4),X1(5), X1(6));--
	V9 : AND_2 port map (X1(6),X(6),X1(7));--959 condition
	V10 : MUX_2X1 port map (RSTN, '0', X1(7), X1(8));
	
	--Enable signal for min0 counter:
	M3 : MUX_2X1 port map ('0', '1', X(6), E2);
	--T3 : MUX_2X1 port map (E2, '0', STP, E(2));
	
	--min0 counter:
	C3 : MODULO11 port map (CLK, X1(8), '1', LDN0, E(2), D1(3 downto 0), Q3(3 downto 0));
	
	--Reset signal for min1 counter:
	W4 : NOT_1 port map (Q4(3),N4(3));
	W5 : NOT_1 port map (Q4(1),N4(1));
	W6 : AND_2 port map (N4(3),Q4(2),X3(0));
	W7 : AND_2 port map (N4(1),Q4(0),X3(1));
	W8 : AND_2 port map (X3(0),X3(1),X3(2));
	W11 : AND_2 port map (X3(2),X1(7),X3(3));--5959 condition
	W10 : MUX_2X1 port map (RSTN, '0', X3(3), RSTN4);
	
	--Enable signal for min1 counter;
	M4 : MUX_2X1 port map ('0','1',X1(7),E3);
	--T4 : MUX_2X1 port map (E3, '0', STP, E(3));
	
	--min1 counter:
	C4 : MODULO7 port map (CLK, RSTN4, '1', LDN1, E(3), D1(3 downto 0), Q4(3 downto 0));
	
	--Reset signal for hour0 counter:
--	Z0 : NOT_1 port map (Q4(2),N4(2));
--	Z1 : NOT_1 port map (Q4(1),N4(1));
--	Z3 : AND_2 port map (Q4(3),N4(2),X4(0));
--	Z4 : AND_2 port map (N4(1),Q4(0),X4(1));
--	Z5 : AND_2 port map (X4(0),X4(1),X4(2));
--	Z6 : AND_2 port map (X4(2),X3(3),X4(3));--95959 condition
--	Z7 : MUX_2X1 port map (RSTN, '0', X4(3), RSTN5);
--	Z8 : AND_2 port map (RSTN5, RSTN6, RSTN7);
	M8 : R1 port map (Q4(3 downto 0),X3(3),RSTN,O,RSTN5);
	M9 : AND_2 port map (RSTN5, RSTN6, RSTN7);
	
	--Enable signal for hour 1 counter:
	M5 : MUX_2X1 port map ('0','1',X3(3),E4);
	--T5 : MUX_2X1 port map (E4, '0', STP, E(4));
	
	--hour0 counter:
	C5 : MODULO11 port map (CLK, RSTN7, '1', LDN2, E(4), D1(3 downto 0), Q5(3 downto 0));
	
	--Reset signal for hour1 counter:
	NOT_BANK3 :
		for i in 0 to 3 generate 
			Y0 : NOT_1 port map(Q5(i), N5(i));
		end generate;
	NOT_BANK4 :
		for i in 0 to 3 generate 
			Y1 : NOT_1 port map(Q6(i), N6(i));
		end generate;
	Y2 : AND_2 port map (N6(3),N6(2),X5(0));
	Y3 : AND_2 port map (Q6(1),N6(0),X5(1));
	Y4 : AND_2 port map (X5(0),X5(1),X5(2));--2 condition
	Y5 : AND_2 port map (N5(3),N5(2),X5(3));
	Y6 : AND_2 port map (Q5(1),Q5(0),X5(4));
	Y7 : AND_2 port map (X5(3),X5(4),X5(5));--3 condition
	Y8 : AND_2 port map (X5(2),X5(5),X5(6));--23 condition
	Y9 : AND_2 port map (X5(6),X3(3),X5(7));--235959 condition
	Y10 : MUX_2X1 port map (RSTN, '0',X5(7), RSTN6);
	
	--Enable signal for hour1 counter:
	M6 : Convert0 port map (Q5(3 downto 0),X3(3),O1);
	M7 : MUX_2X1 port map ('0','1',O1,E5);
	--T6 : MUX_2X1 port map (E5, '0', STP, E(5));
	
	--hour1 counter:
	C6 : MODULO11 port map (CLK, RSTN6, '1', LDN3, E5, D1(3 downto 0), Q6(3 downto 0));
	
	--BCD to SSD conversion:
	Convert0 : BCD2SSD port map (Q1(3 downto 0), Sec0(6 downto 0), I(1));
	Convert1 : BCD2SSD port map (Q2(3 downto 0), Sec1(6 downto 0), I(2));
	Convert2 : BCD2SSD port map (Q3(3 downto 0), min0(6 downto 0), I(3));
	Convert3 : BCD2SSD port map (Q4(3 downto 0), min1(6 downto 0), I(4));
	Convert4 : BCD2SSD port map (Q5(3 downto 0), hour0(6 downto 0), I(5));
	Convert5 : BCD2SSD port map (Q6(3 downto 0), hour1(6 downto 0), I(6));
	
end STRUCTURE;

