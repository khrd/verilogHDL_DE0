module Timer(clk, oclk);
	parameter scale=100;
	input clk;
	output oclk;
	
	reg [15:0] cnt1;
	reg [11:0] cnt2;
	reg [3:0] dcnt;
	wire iclk1;
	wire iclk2;
	reg rclk;
	
	assign iclk1=(cnt1==16'd49999) ? 1'b1 : 1'b0;
	
	always @(posedge clk) begin
		if(iclk1==1'b1)
			cnt1=0;
		else
			cnt1=cnt1+1;
	end
	
	assign iclk2=(cnt2==(scale-1)) ? 1'b1 : 1'b0;
	always @(posedge clk) begin
		if(iclk1==1'b1)
			if(iclk2==1'b1)
				cnt2=0;
			else
				cnt2=cnt2+1;
			end


	
	always @(posedge clk)
		rclk=iclk2;
	assign oclk=rclk;
	
endmodule
