module Lesson2(sw,led);
	input [6:0] sw;
	output [3:0] led;
	
	wire w_and, w_or, w_not, w_xor;
	
	assign w_and=sw[0] & sw[1];
	assign w_or=sw[2] | sw[3];
	assign w_not=~sw[4];
	assign w_xor=sw[5]^sw[6];
	
	assign led={w_xor , w_not, w_or, w_and};
	
endmodule