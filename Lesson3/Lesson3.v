module Lesson3(sw, led, button);
	input [7:0] sw;
	output [3:0] led;
	input button;
	assign led=(button==1'b1) ? sw[3:0] : sw[7:4];
endmodule