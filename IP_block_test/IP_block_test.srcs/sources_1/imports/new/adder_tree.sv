`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 23:39:12
// Design Name: 
// Module Name: adder_tree
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


(* multstyle = "dsp" *) module adder_tree #(parameter
	N = 32, DATA_WIDTH = 8,
	//RESULT_WIDTH = ((N-1) < 2**$clog2(N)) ? DATA_WIDTH + $clog2(N) : DATA_WIDTH + $clog2(N) + 1
	RESULT_WIDTH=24
)(
	input clock, clock_ena,
	input logic [DATA_WIDTH-1:0] data[N-1:0],
	output logic [RESULT_WIDTH-1:0] result
);
	generate
		if (N == 2)
			add #(.DATAA_WIDTH(DATA_WIDTH), .DATAB_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RESULT_WIDTH))
				add_inst(.clock(clock), .clock_ena(clock_ena), .dataa(data[0]), .datab(data[1]), .result(result));
		else
			begin
				localparam RES_WIDTH = (RESULT_WIDTH > DATA_WIDTH + 1) ? DATA_WIDTH + 1 : RESULT_WIDTH;
				localparam RESULTS = (N % 2 == 0) ? N/2 : N/2 + 1;
				
				logic [RES_WIDTH-1:0] res[RESULTS - 1:0];
				
				add_pairs #(.N(N), .DATA_WIDTH(DATA_WIDTH), .RESULT_WIDTH(RES_WIDTH))
					add_pairs_inst(.clock(clock), .clock_ena(clock_ena), .data(data), .result(res));
				
				adder_tree #(.N(RESULTS), .DATA_WIDTH(RES_WIDTH))
					adder_tree_inst(.clock(clock), .clock_ena(clock_ena), .data(res), .result(result));
			end
	endgenerate
	
endmodule
