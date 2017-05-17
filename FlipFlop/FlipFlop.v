module FlipFlop(switch, led);
	input switch;
	output led;
	reg ff;
	
	always @(posedge switch) begin
		ff = ~ff;
	end
	
	assign led=ff;
endmodule