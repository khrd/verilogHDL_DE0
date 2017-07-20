module PWM(clk, btn, sw, led, hled0, hled1, hled2, hled3);

	input clk;
	input [2:0] btn;
	input [9:0] sw;

	output [9:0] led;
	output [7:0] hled0;
	output [7:0] hled1;
	output [7:0] hled2;
	output [7:0] hled3;

	reg [7:0] cnt;
	
	assign hled0 = 8'hff;
	assign hled1 = 8'hff;
	assign hled2 = 8'hff;
	assign hled3 = 8'hff;

	always @(posedge clk)
		cnt=cnt+1;

	assign led[0] = 1'b0;
	assign led[1] = (cnt<8'd30) ? 1'b1 : 1'b0;
	assign led[2] = (cnt<8'd60) ? 1'b1 : 1'b0;
	assign led[3] = (cnt<8'd90) ? 1'b1 : 1'b0;
	assign led[4] = (cnt<8'd120) ? 1'b1 : 1'b0;
	assign led[5] = (cnt<8'd150) ? 1'b1 : 1'b0;
	assign led[6] = (cnt<8'd180) ? 1'b1 : 1'b0;
	assign led[7] = (cnt<8'd210) ? 1'b1 : 1'b0;
	assign led[8] = (cnt<8'd240) ? 1'b1 : 1'b0;
	assign led[9] = 1'b1;


endmodule