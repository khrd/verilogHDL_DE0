module timer(clk, led);

	input clk;
	output [9:0] led;
	
	reg [15:0] cnt1;
	reg [6:0] cnt2;
	reg [3:0] dcnt;
	wire iclk1;
	wire iclk2;
	
	// 1/50000 preScaler
	assign iclk1=(cnt1==16'd49999) ? 1'b1 : 1'b0;
	always @(posedge clk) begin
		if(iclk1==1'b1)
			cnt1=0;
		else
			cnt1=cnt1+1;
			
	end
	
	// 1/100 preScaler
	assign iclk2=(cnt2==7'd99) ? 1'b1 : 1'b0;
	always @(posedge clk) begin
		if(iclk1==1'b1) begin
			if(iclk2==1'b1)
				cnt2=0;
			else
				cnt2=cnt2+1;
		end
	end
	
	// decimal counter
	always @(posedge clk) begin
		if( (iclk1==1'b1) && (iclk2==1'b1) ) begin
			if(dcnt==4'd9)
				dcnt=0;
			else
				dcnt=dcnt+1;
		end
	end
	
	// decorder
	assign led[0]=(dcnt==4'd0) ? 1'b1 : 1'b0;
	assign led[1]=(dcnt==4'd1) ? 1'b1 : 1'b0;
	assign led[2]=(dcnt==4'd2) ? 1'b1 : 1'b0;
	assign led[3]=(dcnt==4'd3) ? 1'b1 : 1'b0;
	assign led[4]=(dcnt==4'd4) ? 1'b1 : 1'b0;
	assign led[5]=(dcnt==4'd5) ? 1'b1 : 1'b0;
	assign led[6]=(dcnt==4'd6) ? 1'b1 : 1'b0;
	assign led[7]=(dcnt==4'd7) ? 1'b1 : 1'b0;
	assign led[8]=(dcnt==4'd8) ? 1'b1 : 1'b0;
	assign led[9]=(dcnt==4'd9) ? 1'b1 : 1'b0;

endmodule