module KitchenTimer(clk, btn, sw, led, hled0, hled1, hled2, hled3);
	input clk;
	input [2:0] btn;
	input [9:0] sw;
	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;
	
	wire sreset;
	wire [2:0] ibtn;
	wire [3:0] bout;
	wire [3:0] bin;
	wire [3:0] iclk;
	
	reg ss_ff=0;
	reg cntend=0;
	wire sclk;
	
	wire [3:0] dout0;
	wire [3:0] dout1;
	wire [3:0] dout2;
	wire [3:0] dout3;
	
	wire [7:0] whex0;
	wire [7:0] whex1;
	wire [7:0] whex2;
	wire [7:0] whex3;
	
	assign led=({dout0,dout1,dout2,dout3}==16'h0000) ? 10'h3ff : 10'h0;
	
	unchatter unc0(btn[0],clk,ibtn[0]);
	unchatter unc1(btn[1],clk,ibtn[1]);
	unchatter unc2(btn[2],clk,ibtn[2]);
	
	always@(negedge sclk)
		cntend=bout[3];
		//assign street=sw[0] | cntend;
		always@(posedge ibtn[2] or posedge sw[0] or posedge cntend ) begin
			if(sw[0]==1'b1 || cntend==1'b1)
				ss_ff=0;
			else
				ss_ff=~ss_ff;
		end
		
		Timer #(1000) TM(clk, sclk);
		
		assign iclk[0]=(sw[0]==1'b0) ? sclk : 1'b0;
		assign iclk[1]=(sw[0]==1'b0) ? sclk : ~ibtn[0];
		assign iclk[2]=(sw[0]==1'b0) ? sclk : ~ibtn[1];
		assign iclk[3]=(sw[0]==1'b0) ? sclk : ~ibtn[2];
		
		assign bin[0]=(sw[0]==1'b0) ? ss_ff : 1'b0;
		assign bin[1]=(sw[0]==1'b0) ? bout[0] : 1'b1;
		assign bin[2]=(sw[0]==1'b0) ? bout[1] : 1'b1;
		assign bin[3]=(sw[0]==1'b0) ? bout[2] : 1'b1;
		
		ucounter #(9) uc0(iclk[0], sw[0], bin[0], bout[0], dout0);
		ucounter #(5) uc1(iclk[1], 1'b0,  bin[1], bout[1], dout1);
		ucounter #(9) uc2(iclk[2], 1'b0,  bin[2], bout[2], dout2);
		ucounter #(5) uc3(iclk[3], 1'b0,  bin[3], bout[3], dout3);
		
		HexSegDec hs0(dout0, whex0);
		HexSegDec hs1(dout1, whex1);
		HexSegDec hs2(dout2, whex2);
		HexSegDec hs3(dout3, whex3);
		
		assign hled0=whex0;
		assign hled1=whex1;
		assign hled2={1'b0,whex2[6:0]};
		assign hled3=whex3;
		
endmodule