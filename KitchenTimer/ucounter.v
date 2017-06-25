module ucounter(clk, reset, bin, bout, q);
	parameter maxcnt=15; //default =HEX counter
	input clk;
	input reset;
	input bin;
	output bout;
	output [3:0] q;
	reg [3:0] cnt=0;
	
	assign q=cnt;
	
	always @(posedge clk or posedge reset) begin
		if(reset==1'b1) begin
			cnt=0;
		end
		else begin
			if(bin==1'b1) begin
				if(cnt==0)
					cnt=maxcnt;
				else
					cnt=cnt-1;
			end
		end
	end
	
	assign bout=((cnt==0) && (bin==1'b1)) ? 1'b1 : 1'b0;
endmodule