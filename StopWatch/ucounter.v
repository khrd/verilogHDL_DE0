module ucounter(clk,nclr,cin,cout,q);
	parameter maxcnt=15; //default =HEX counter
	input clk;
	input nclr;
	input cin;
	output cout;
	output [3:0] q;
	reg [3:0] cnt;
	
	assign q=cnt;
	
	always @(posedge clk or negedge nclr) begin
		if(nclr==1'b0) begin
			cnt=4'h0;
		end
		else begin
			if(cin==1'b1) begin
				if(cnt==maxcnt)
					cnt=4'h0;
				else
					cnt=cnt+1;
			end
		end
	end
	
	assign cout=((cnt==maxcnt) && (cin==1'b1)) ? 1'b1 : 1'b0;
endmodule