`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2021 00:01:26
// Design Name: 
// Module Name: add_pairs
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

module add_pairs #(parameter
	N = 32, DATA_WIDTH = 18,
	RESULT_WIDTH = DATA_WIDTH + 1,
	RESULTS = (N % 2 == 0) ? N/2 : N/2 + 1
	//RESULT_WIDTH=19
)(
	input clock, clock_ena,
	input logic [DATA_WIDTH-1:0] data[N - 1:0],
	output logic [RESULT_WIDTH-1:0] result[RESULTS - 1:0]
);
	genvar i;
	
	generate
		for (i = 0; i < N/2; i++)
			begin :a
				add #(.DATAA_WIDTH(DATA_WIDTH), .DATAB_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RESULT_WIDTH))
					add_inst(.clock, .clock_ena, .dataa(data[2*i]), .datab(data[2*i + 1]), .result(result[i]));
			end
		
		if (RESULTS == N/2 + 1)
			begin
				reg [RESULT_WIDTH-1:0] res;
			
				always @(posedge clock)
					if (clock_ena)
						res <= data[N-1];
				
				assign result[RESULTS-1] = res;
			end
	endgenerate
endmodule 
