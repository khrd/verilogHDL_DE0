module BaudrateGen(clk, mode, sioclk);
	input clk; 
	input [1:0] mode; 
	output sioclk;
	
	reg[11:0] cnt;
	reg bclk;
	reg [2:0] div;
	
	
	always @(posedge clk) begin
		if(cnt == 12'd650)
			cnt = 0;
		else
			cnt = cnt+1;
	end
	always @(posedge clk) begin
		if(cnt == 12'h000)
			bclk = 1'b1;
		else
			bclk = 1'b0;
	end
	
	
	always @(posedge bclk) begin
		div = div+1;
	end
	
	assign sioclk = (mode == 2'h0) ? bclk :
		(mode == 2'h1) ? div[0] :
		(mode == 2'h2) ? div[1] : div[2];
endmodule

module SerialIn(clk, sin, dat);
	input clk; 
	input sin;
	output [7:0] dat;
	
	reg [4:0] cnt; 
	reg [7:0] sreg;
	always @(posedge clk) begin
		if(cnt == 5'h0) begin
			if(sin == 1'b0)
				cnt = 5'h1;
		end
		else begin
			if(cnt == 5'd18)
				cnt = 5'd0;
			else
				cnt = cnt+1;
		end
	end
	always @(posedge clk) begin
		if(cnt[0] == 1'b1)
			sreg = {sin, sreg[7:1]};
	end
	assign dat = sreg;
endmodule

module SerialRx(clk, btn, sw, led, hled0, hled1, hled2, hled3, Txd, Rxd);
	input clk;
	input [2:0] btn;
	input [9:0] sw;
	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;
	output Txd;
	input Rxd;
	wire [7:0] bdat;
	wire [7:0] rdat;
	wire sclk;
	
	BaudrateGen bg(clk, sw[9:8], sclk);
	SerialIn si(sclk,Rxd, rdat);
	
	
	assign bdat = (sw[9:8] == 2'd0) ? 8'h38 :
		(sw[9:8] == 2'd1) ? 8'h19 :
		(sw[9:8] == 2'd2) ? 8'h96 : 8'h48;
	
	assign led = 10'h0;
	assign Txd = Rxd;
	HexSegDec(rdat[3:0], hled0);
	HexSegDec(rdat[7:4], hled1);
	HexSegDec(bdat[3:0], hled2);
	HexSegDec(bdat[7:4], hled3);
endmodule