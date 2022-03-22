`timescale 1ns / 1ps

/******************************************************* 
Sweep.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:

Permite mostrar cada dígito del numero entregado al display de
7 segmento en su magnitud correspondiente

********************************************************/

module Sweep(
	input logic clk,
	input logic [31:0]  Data,
	output logic [2:0] sel,
	output logic [3:0] bcd
    );
    
	logic [3:0] unidad;
    logic [3:0] decena;
    logic [3:0] centena;
    logic [3:0] unidadm;
    logic [3:0] decenam;
    logic [3:0] centenam;
	logic [2:0] Aux;
	
	 assign unidad=Data[3:0];
	 assign decena=Data[7:4];
	 assign centena=Data[11:8];
	 assign unidadm=Data[15:12];
	 assign decenam=Data[19:16];
	 assign centenam=Data[23:20];
	 
	 always_ff @(posedge clk) begin
		Aux <= Aux + 1;
		if (Aux==1) begin
			sel <= 0;
			bcd <= unidad;
		end
		else if (Aux==2) begin
			sel <= 1;
			bcd <= decena;
		end
		else if (Aux==3) begin
			sel <= 2;
			bcd <= centena;
		end
		else if (Aux==4) begin
			sel <= 3;
			bcd <= unidadm;
		end
		else if (Aux==5) begin
			sel <= 4;
			bcd <= decenam;
		end
		else if (Aux==6) begin
			sel <= 5;
			bcd <= centenam;
			Aux <= 0;
		end 
	end 
	
endmodule
