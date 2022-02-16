`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2021 00:06:56
// Design Name: 
// Module Name: add
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

module add #(parameter
	DATAA_WIDTH = 16, DATAB_WIDTH = 17, RESULT_WIDTH = (DATAA_WIDTH > DATAB_WIDTH) ? DATAA_WIDTH + 1 : DATAB_WIDTH + 1
)(
	input clock, clock_ena,
	input logic [DATAA_WIDTH-1:0] dataa,
	input logic [DATAB_WIDTH-1:0] datab,
	output logic [RESULT_WIDTH-1:0] result
);
	always_ff @(posedge clock)
		if (clock_ena)
			result <= dataa + datab;
endmodule