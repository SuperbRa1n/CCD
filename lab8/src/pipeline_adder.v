module pipeline_adder (clk, a, b, ci, s, co);
    input clk;
    input[31:0] a, b;
    input ci;
    output reg [31:0] s;
    output reg co;

    reg[31:0] ta0, tb0;  
    reg tci;                

    reg[7:0] sum0;             
    reg co0;
    reg[23:0] ta1, tb1;  

    reg[15:0] sum1;            
    reg co1;
    reg[15:0] ta2, tb2;  
    
    reg[23:0] sum2;            
    reg co2;
    reg[7:0] ta3, tb3;   

    d_ff #(.n(1)) d0(.clk(clk), .d(ci), .q(tci));
    d_ff #(.n(32)) d1(.clk(clk), .d(a), .q(ta0));
    d_ff #(.n(32)) d2(.clk(clk), .d(b), .q(tb0));
    d_ff #(.n(9)) d3(.clk(clk), .d(9'b0 + ta0[7:0] + tb0[7:0] + tci), .q({co0,sum0}));
    d_ff #(.n(24)) d4(.clk(clk), .d(ta0[31:8]), .q(ta1));
    d_ff #(.n(24)) d5(.clk(clk), .d(tb0[31:8]), .q(tb1));
    d_ff #(.n(17)) d6(.clk(clk), .d({9'b0 + ta1[7:0] + tb1[7:0] + co0, sum0}), .q({co1, sum1}));
    d_ff #(.n(16)) d7(.clk(clk), .d(ta1[23:8]), .q(ta2));
    d_ff #(.n(16)) d8(.clk(clk), .d(tb1[23:8]), .q(tb2));
    d_ff #(.n(25)) d9(.clk(clk), .d({9'b0 + ta2[7:0] + tb2[7:0] + co1, sum1}), .q({co2, sum2}));
    d_ff #(.n(8)) d10(.clk(clk), .d(ta2[15:8]), .q(ta3));
    d_ff #(.n(8)) d11(.clk(clk), .d(tb2[15:8]), .q(tb3));
    d_ff #(.n(33)) d12(.clk(clk), .d({9'b0 + ta3[7:0] + tb3[7:0] + co2, sum2}), .q({co, s}));

endmodule