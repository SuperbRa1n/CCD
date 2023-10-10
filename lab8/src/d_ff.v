module d_ff (clk, q, d);
    parameter n = 1;
    input clk;
    input[n-1:0] d; 
    output reg [n-1:0] q;

    always @(posedge clk) begin
        q <= d;
    end

endmodule