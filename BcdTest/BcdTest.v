module BcdTest(clk, btn, sw, led, hled0, hled1, hled2, hled3, ncs, sck, sdi, sdo);
	input clk;
	input [2:0] btn;
	input [9:0] sw;
	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;
	output ncs, sck, sdi;
	input sdo;
	wire [11:0] wbcd;
	assign led = sw;

	BcdConv dc(sw[7:0], wbcd);

	HexSegDec hs0(wbcd[3:0], hled0);
	HexSegDec hs1(wbcd[7:4], hled1);
	HexSegDec hs2(wbcd[11:8], hled2);
	assign hled3 = 8'hff;
endmodule