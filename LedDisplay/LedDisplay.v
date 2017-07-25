module FontRom(radr, dat);
	input [4:0] radr;
	output [9:0] dat;

	function [9:0] FontDec;
		input [4:0] dadr;
		begin
			case (dadr)
			5'h00: FontDec=10'h006;
			5'h01: FontDec=10'h382;
			5'h02: FontDec=10'h2bb;
			5'h03: FontDec=10'h2aa;
			5'h04: FontDec=10'h2ea;
			5'h05: FontDec=10'h2ab;
			5'h06: FontDec=10'h2aa;
			5'h07: FontDec=10'h2bb;
			5'h08: FontDec=10'h382;
			5'h09: FontDec=10'h006;
			5'h0a: FontDec=10'h000;
			5'h0b: FontDec=10'h082;
			5'h0c: FontDec=10'h28a;
			5'h0d: FontDec=10'h2ab;
			5'h0e: FontDec=10'h1ae;
			5'h0f: FontDec=10'h1ab;
			5'h10: FontDec=10'h3fa;
			5'h11: FontDec=10'h1ab;
			5'h12: FontDec=10'h1ab;
			5'h13: FontDec=10'h2ab;
			5'h14: FontDec=10'h28a;
			5'h15: FontDec=10'h082;
			5'h16: FontDec=10'h000;
			5'h17: FontDec=10'h07c;
			5'h18: FontDec=10'h044;
			5'h19: FontDec=10'h044;
			5'h1a: FontDec=10'h044;
			5'h1b: FontDec=10'h3ff;
			5'h1c: FontDec=10'h044;
			5'h1d: FontDec=10'h044;
			5'h1e: FontDec=10'h044;
			5'h1f: FontDec=10'h07c;
			endcase
		end
	endfunction
	assign dat=FontDec(radr);
endmodule

module LedDisplay(clk, btn, sw, led, hled0, hled1, hled2, hled3);
	input clk;
	input [2:0] btn;
	input [9:0] sw;
	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;
	wire reset, msclk;
	wire [9:0] fdat;
	reg [4:0] areg;

	assign hled0 =8'hff;
	assign hled1 =8'hff;
	assign hled2 =8'hff;
	assign hled3 =8'hff;

	assign reset = btn[2];

	Timer #(4) tm(clk, msclk);

	always @(posedge msclk or posedge reset) begin
		if (reset==1'b1) begin
			areg=5'h00;
		end
		else begin
			areg=areg+1;
		end
	end

	FontRom fr(areg, fdat);
	assign led = (reset==1'b1) ? 10'h00 : fdat;
endmodule