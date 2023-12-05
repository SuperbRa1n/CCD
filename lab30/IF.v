`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  zju
// Engineer: qmj
//////////////////////////////////////////////////////////////////////////////////
module IF1(clk, reset, Branch,Jump, IFWrite, JumpAddr,Instruction_if,PC,IF_flush);
    input clk;
    input reset;
    input Branch;
    input Jump;
    input IFWrite;
    input [31:0] JumpAddr;
    output [31:0] Instruction_if;
    output [31:0] PC;
    output IF_flush;

    wire[31:0] NextPC_if, PCSource;
    reg[31:0] PC;

    assign IF_flush = Branch || Jump;

    assign PCSource = IF_flush?JumpAddr:NextPC_if;

    always@(posedge clk)
    begin
        if(reset)
            PC <= 32'd0;
        else if(IFWrite)
            PC <= PCSource;
        else
            PC <= PC;
    end

    adder_32bits adder0(
        .a(PC), 
        .b(32'd4), 
        .ci(0), 
        .s(NextPC_if), 
        .co()
    );

    InstructionROM InstROM0(
        .addr(PC[7:2]),
        .dout(Instruction_if)
    );

endmodule
