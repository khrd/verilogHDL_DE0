module HexSegDec(dat,q);
	input [3:0] dat;
	output [7:0] q;
	
	function [7:0] LedDec;
		input [3:0] num;
		begin
			case (num)
				4'h0:		LedDec = 8'b11000000;
				4'h1:		LedDec = 8'b11111001;
				4'h2:		LedDec = 8'b10100100;
				4'h3:		LedDec = 8'b10110000;
				4'h4:		LedDec = 8'b10011001;
				4'h5:		LedDec = 8'b10010010;
				4'h6:		LedDec = 8'b10000010;
				4'h7:		LedDec = 8'b11111000;
				4'h8:		LedDec = 8'b10000000;
				4'h9:		LedDec = 8'b10011000;
				4'ha:		LedDec = 8'b10001000;
				4'hb:		LedDec = 8'b10000011;
				4'hc:		LedDec = 8'b10100111;
				4'hd:		LedDec = 8'b10100001;
				4'he:		LedDec = 8'b10000110;
				4'hf:		LedDec = 8'b10001110;
				default:	LedDec = 8'b11111111;
			endcase
		end
	endfunction
	
	assign q= LedDec(dat);
endmodule
	