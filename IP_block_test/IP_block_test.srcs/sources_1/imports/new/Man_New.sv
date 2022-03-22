`timescale 1ns / 1ps

module Man_New#(
  	parameter N = 1024)(
  	input logic clk,
  	input logic unsigned [7:0] vectorA [N - 1:0],
    input logic unsigned [7:0] vectorB [N - 1:0],
    output logic unsigned [23:0] result
    );
   
    integer unsigned i,j,k;
    logic unsigned [7:0] Res_comb[N-1:0];
    logic unsigned [14:0] aux[N-1:0]; 
    
    
    
		always_comb  begin  
// Para N = 8 Ok		
                for (i=0; i < N; i++) 
                    if(vectorA[i] <= vectorB[i])  Res_comb[i] = vectorB[i] - vectorA[i];
                    else  Res_comb[i] = vectorA[i] - vectorB[i];  
       end
       
       //Adder tree
       
       adder_tree #(.N(N<=1024?N:1024), .DATA_WIDTH(8),.RESULT_WIDTH(24)) arbolito(
        .clock(clk),
        .clock_ena(1'b1),
        .data(Res_comb),
        .result(result)
        
        );
       
       
  endmodule
