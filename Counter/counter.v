module counter(switch, led);
	input switch;
	output [3:0] led;
	reg [3:0] ff;
	
	always @(posedge switch) begin
		if(ff==4'h9)
			ff=4'h0;
		else
			ff=ff+1;
			
	end
	
	assign led=ff;
endmodule