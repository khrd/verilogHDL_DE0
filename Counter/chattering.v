module chattering(clk, switch, led);
	input clk, switch;
	output [3:0] led;
	reg [3:0] ff;
	reg [15:0] cnt;
	reg swreg;
	wire c_clk, sw_out;
	
	//16bit Counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	
	assign c_clk=cnt[15];
	
	//switch latch
	always @(posedge c_clk) begin
		swreg=switch;
	end
	assign sw_out=swreg;
	
	always @(posedge switch) begin
		if(ff==4'h9)
			ff=4'h0;
		else
			ff=ff+1;
			
	end
	
	assign led=ff;
endmodule
