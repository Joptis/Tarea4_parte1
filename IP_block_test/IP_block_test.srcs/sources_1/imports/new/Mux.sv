`timescale 1ns / 1ps

/******************************************************* 
clock_divider.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:
Establece la multiplexació de las operaciones, tanto aritméticas
(suma, promedio, Manhattan y Euclidiana) como funcionales
(escritura y lectura)
********************************************************/

module Mux(
    input logic rx_ready,
    input logic [7:0] rx_data,
    input logic sel,
    output mrx_ready,
    output [7:0] mrx_data,
    output cmd_ready,
    output [7:0] cmd_data
    );
	logic [7:0] mdata, cdata;
	logic mready, cready;
	
	assign mrx_data=mdata;
	assign mrx_ready=mready;	
	assign cmd_data=cdata;
	assign cmd_ready=cready;
	
	always_comb
		if (sel) begin
			mready=rx_ready;
			mdata=rx_data;
			cready=1'b0;
			cdata=8'b0;
		end
		else begin
			cready=rx_ready;
			cdata=rx_data;
			mready=1'b0;
			mdata=8'b0;
		end	
endmodule
