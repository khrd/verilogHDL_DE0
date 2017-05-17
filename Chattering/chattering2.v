module chattering2(clk, switch, led);
	input clk, switch;
	output [8:0] led;
	reg [8:0] ff;
	reg [23:0] cnt;
	reg swreg;
	wire c_clk, sw_out;
	
	//16bit Counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	
	assign c_clk=cnt[23];
	
	//switch latch
	always @(posedge c_clk) begin
		swreg=switch;
	end
	assign sw_out=swreg;
	
	always @(posedge c_clk) begin
		if(ff==9'b111111111)
			ff=9'h0;
		else
			ff=ff+1;
	end
	assign led=ff;
	
endmodule
