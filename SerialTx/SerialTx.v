module BaudrateGen(clk, mode, sioclk);
    input clk;
    input [1:0] mode;
    output sioclk;

    reg [11:0] cnt=0;
    reg bclk=0;
    reg [2:0] div=0;

    always @(posedge clk) begin
        if(cnt==12'd1301)
            cnt=0;
        else
            cnt=cnt+1;
    end
    
    always @(posedge clk) begin
        if(cnt==12'h000)
            bclk=1'b1;
        else
            bclk=1'b0;
    end

    always @(posedge bclk) begin
        div=div+1;
    end

    assign sioclk=(mode==2'h0) ? bclk :
        (mode==2'h1) ? div[0] : 
        (mode==2'h2) ? div[1] : div[2];
endmodule

module SerialOut(clk, reset, dat, sout);
    input clk;
    input reset;
    input [7:0] dat;
    output sout;

    reg [3:0] cnt=0;

    function BitSel;
        input [7:0] dat;
        input [3:0] i;
        begin
            case (i)
                1: BitSel=0;
                2: BitSel=dat[0];
                3: BitSel=dat[1];
                4: BitSel=dat[2];
                5: BitSel=dat[3];
                6: BitSel=dat[4];
                7: BitSel=dat[5];
                8: BitSel=dat[6];
                9: BitSel=dat[7];
                default: BitSel=1;
            endcase
        end
    endfunction

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            cnt=0;
        end else begin
            if(cnt!=10)
                cnt=cnt+1;
        end
    end

    assign sout=BitSel(dat, cnt);

endmodule

module SerialTx(clk, btn, sw, led, hled0, hled1, hled2, hled3, Txd, Rxd);
    input clk;
    input [2:0] btn;
    input [9:0] sw;
    output [9:0] led;
    output [7:0] hled0;
    output [7:0] hled1;
    output [7:0] hled2;
    output [7:0] hled3;

    output Txd;
    input Rxd;
	 
    wire [7:0] bdat;
    wire reset, sclk;

    unchatter uc(btn[2],clk, reset);
    BaudrateGen bg(clk, sw[9:8], sclk);
    SerialOut so(sclk, reset, sw[7:0], Txd);
	 
    assign bdat=(sw[9:8]==2'd0) ? 8'h38 :
    (sw[9:8]==2'd1) ? 8'h19 : 
	 (sw[9:8]==2'd2) ? 8'h96 : 8'h48;

    assign led = 10'h0;
    HexSegDec(sw[3:0], hled0);
    HexSegDec(sw[7:4], hled1);
    HexSegDec(bdat[3:0], hled2);
    HexSegDec(bdat[7:4], hled3);
endmodule
