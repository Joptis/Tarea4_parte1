`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2022 14:16:06
// Design Name: 
// Module Name: IP_sim
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


module IP_sim(

    );
    
    
    logic [7:0] A1,A2,A3,A4,A5,A6,A7,A8;
    logic [7:0] B1,B2,B3,B4,B5,B6,B7,B8;
    logic [31:0] Euc_out;
    logic clk,reset,start;
    design_1 DUT
   (
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .A4(A4),
    .A5(A5),
    .A6(A6),
    .A7(A7),
    .A8(A8),
    .B1(B1),
    .B2(B2),
    .B3(B3),
    .B4(B4),
    .B5(B5),
    .B6(B6),
    .B7(B7),
    .B8(B8),
    .Euc_out(Euc_out),
    .clk(clk),
    .reset_rtl_0(reset),
    .start(start)
    );
    
     always  #1 clk=~clk;
     
     initial begin
     
     clk=0;reset=0;start=0;
     A1=1;
     A2=2;
     A3=3;
     A4=4;
     A5=5;
     A6=6;
     A7=7;
     A8=8;
     B8=1;
     B7=2;
     B6=3;
     B5=4;
     B4=5;
     B3=6;
     B2=7;
     B1=8;
     #10 start=1;
     end
    
endmodule


