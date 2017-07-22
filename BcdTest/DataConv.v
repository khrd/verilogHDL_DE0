module BcdAdd(datA, datB, cin, cout, dout);
	input [3:0] datA;
	input [3:0] datB;
	input cin;
	output cout;
	output [3:0] dout;
	wire [4:0] adat;
	wire cry;

	assign adat = datA+datB+cin;
	assign cry = (adat>=5'd10) ? 1'b1 : 1'b0;
	assign dout = (cry==1'b1) ? (adat-5'd10) : adat[3:0];
	assign cout = cry;
endmodule

module BcdConv(data, q);
	input [7:0] data;
	output [11:0] q;
	wire c1, c2, co;
	wire [11:0] whbcd;
	wire [11:0] wlbcd;
	function [11:0] HBcdTbl;
		input [3:0] num;
		begin
			case (num)
				4'h0:	HBcdTbl = 12'h00;
				4'h1:	HBcdTbl = 12'h16;
				4'h2:	HBcdTbl = 12'h32;
				4'h3:	HBcdTbl = 12'h48;
				4'h4:	HBcdTbl = 12'h64;
				4'h5:	HBcdTbl = 12'h80;
				4'h6:	HBcdTbl = 12'h96;
				4'h7:	HBcdTbl = 12'h112;
				4'h8:	HBcdTbl = 12'h128;
				4'h9:	HBcdTbl = 12'h144;
				4'ha:	HBcdTbl = 12'h160;
				4'hb:	HBcdTbl = 12'h176;
				4'hc:	HBcdTbl = 12'h192;
				4'hd:	HBcdTbl = 12'h208;
				4'he:	HBcdTbl = 12'h224;
				4'hf:	HBcdTbl = 12'h240;
			endcase
		end
	endfunction
	
	function [7:0] LBcdTbl;
		input [3:0] num;
		begin
			case (num)
				4'h0:	LBcdTbl = 8'h00;
				4'h1:	LBcdTbl = 8'h01;
				4'h2:	LBcdTbl = 8'h02;
				4'h3:	LBcdTbl = 8'h03;
				4'h4:	LBcdTbl = 8'h04;
				4'h5:	LBcdTbl = 8'h05;
				4'h6:	LBcdTbl = 8'h06;
				4'h7:	LBcdTbl = 8'h07;
				4'h8:	LBcdTbl = 8'h08;
				4'h9:	LBcdTbl = 8'h09;
				4'ha:	LBcdTbl = 8'h10;
				4'hb:	LBcdTbl = 8'h11;
				4'hc:	LBcdTbl = 8'h12;
				4'hd:	LBcdTbl = 8'h13;
				4'he:	LBcdTbl = 8'h14;
				4'hf:	LBcdTbl = 8'h15;
			endcase
		end
	endfunction

	assign whbcd = HBcdTbl(data[7:4]);
	assign wlbcd = LBcdTbl(data[3:0]);

	BcdAdd ad0(wlbcd[3:0], whbcd[3:0],  1'b0, c1, q[3:0]);
	BcdAdd ad1(wlbcd[7:4], whbcd[7:4],  c1, c2, q[7:4]);
	BcdAdd ad2(4'h0,       whbcd[11:8], c2, co, q[11:8]);

endmodule