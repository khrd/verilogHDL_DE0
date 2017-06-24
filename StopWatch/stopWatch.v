module stopWatch(clk, btn, sw, led, hled0, hled1, hled2, hled3);
	input clk;
	input [2:0] btn;
	input [9:0] sw;
	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;
	
	//wire ss_btn, ss_nrest;
	wire ss_btn;
	wire [3:0] cout;
	reg ss_ff=0;
	wire iclk;
	
	wire [3:0] dout0;
	wire [3:0] dout1;
	wire [3:0] dout2;
	wire [3:0] dout3;
	
	wire [7:0] whex0;
	wire [7:0] whex1;
	wire [7:0] whex2;
	wire [7:0] whex3;
	
	assign led=10'h0;
	
	unchatter unc(btn[2], clk, ss_btn);
	
	//assign ss_nrest=btn[1] | ~cout[3];
	
	always@(negedge ss_btn or negedge btn[1] or negedge ~cout[3]) begin
		if(btn[1]==1'b0  || ~cout[3]==1'b0)
			ss_ff=0;
		else
			ss_ff=~ss_ff;
	end
	
	Timer #(10) TM(clk, iclk);
	
	ucounter #(9) uc0(iclk, btn[1], ss_ff, cout[0], dout0);
	ucounter #(9) uc1(iclk, btn[1], cout[0], cout[1], dout1);
	ucounter #(9) uc2(iclk, btn[1], cout[1], cout[2], dout2);
	ucounter #(9) uc3(iclk, btn[1], cout[2], cout[3], dout3);
	
	HexSegDec hs0(dout0, whex0);
	HexSegDec hs1(dout1, whex1);
	HexSegDec hs2(dout2, whex2);
	HexSegDec hs3(dout3, whex3);
	
	assign hled0=whex0;
	assign hled1=whex1;
	assign hled2={1'b0,whex2[6:0]};
	assign hled3=whex3;
	
endmodule
