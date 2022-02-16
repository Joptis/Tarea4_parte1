`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2022 15:59:43
// Design Name: 
// Module Name: Main
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Main#(parameter N = 8, numberbit = 8)(
    input logic clk,
    input logic unsigned [numberbit-1:0] dataA [N-1:0],
    input logic unsigned [numberbit-1:0] dataB [N-1:0],
	output logic [31:0] Euc_out
    );

endmodule

