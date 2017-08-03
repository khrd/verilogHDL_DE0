module unchatter(din, clk, dout);
	input clk;
	input din;
	output  dout;
	reg [15:0] cnt=0;
	reg dff=0;
	wire c_clk, sw_out;
	
	//16bit Counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	
	//switch latch
	always @(posedge cnt[15]) begin
		dff=din;
	end
	assign dout=dff;
	
endmodule
