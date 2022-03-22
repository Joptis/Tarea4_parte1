`timescale 1ns / 1ps

/******************************************************* 
Driver_RAM.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:

Establece el hardware para implementar la memoria de un Vector, tanto para su 
lectura como para su escritura.
Este tipo de Random Access Memory se lleva a cabo mediante la implementación 
de un sistema SIPO (Single Input Parallel Output)
********************************************************/


module Driver_RAM#(parameter N = 8, bits = 8)(
    input logic clkin,
    input logic enable,
    input logic rx_ready,
    input logic [7:0] rx_data,
    output logic unsigned [bits-1:0] Dato [N - 1:0],
	output logic flag_end
    ); 
    
    logic [9:0] counter=10'd0;
    
    always_ff @(posedge clkin) begin 
		if (~enable) flag_end <= 1'b0;
		if (enable && rx_ready) begin
            if (counter== N-1) begin
				Dato[counter] <= rx_data;
				counter<=10'd0;
				flag_end<=1'b1;
            end
            else begin
				Dato[counter]<=rx_data;
				counter<=counter+10'd1;
				flag_end<=1'b0;
            end      
        end 
    end       
endmodule
