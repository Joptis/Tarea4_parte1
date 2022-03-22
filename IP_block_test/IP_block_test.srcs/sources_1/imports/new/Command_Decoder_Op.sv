`timescale 1ns / 1ps

/******************************************************* 
Command_Decoder_Op.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:

El responsable de decodificar la operacion reciba por puerto
serial, generando una salida que indica el valor de la operación recibida
, dado por command, y las señales de disparo, las cuales tienen "trigger"
en su nombre. Los codigos para cada operación son las siguientes:

1   : Escritura en memoria del vector A
2   : Escritura en memoria del vector A
3   : Lectura del vector A
4   : Lectura del vector B
5   : Suma elemento a elemento de los vectores A y B
6   : Promedio elemento a elemento de los vectores A y B
7   : Distancia de Manhattan
8   : Distancia Euclidiana

********************************************************/

module Command_Decoder_Op(
    input logic clkin,
    input logic rx_ready,
    input logic [7:0] rx_data,
    input logic flag_end_A,
    input logic flag_end_B,
    output logic enableA,
    output logic enableB,
    output logic sel,	
    output logic atrigger,
    output logic btrigger,
    output logic strigger,
    output logic ptrigger,
    output logic mtrigger,
    output logic etrigger,
    output logic [7:0] command
   );
   
    logic [7:0] Op_actual, prox;
   
   
          assign prox = command;   
   
   always_ff @(posedge clkin) begin 
        if (rx_ready) begin
			case (rx_data) 
				//BRAMA
				8'd1: begin 
					sel=1'b1;
					enableA<=1'b1;
					enableB<=1'b0;
					command<=8'd1;
				end
				//BRAMB
				8'd2: begin 
					sel=1'b1;
					enableA<=1'b0;
					enableB<=1'b1;
					command<=8'd2;
				end
				//readVec_A
				8'd3: begin
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd3;
				end
				//readVec_B
				8'd4: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd4;
				end
				//sumVec
				8'd5: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd5;
				end
				//AvgVec
				8'd6: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd6;
				end
				//ManDist
				8'd7: begin
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd7;
				end
				//EucDist
				8'd8: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd8;
				end
				default: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd0;
				end
			endcase 
        end
        //Termino operación funcional en cualquiera de los vectores,
        //Bajo todas las señales de interés
		if (flag_end_A == 1'b1 || flag_end_B == 1'b1) begin
			sel=1'b0;
			enableA<=1'b0;
			enableB<=1'b0;
		end
    end
    
     always_ff @(posedge clkin)
         //Operacion realizada, bajo todos los triggers de operación
         if (Op_actual==prox) begin
             atrigger <=1'd0;
             btrigger <=1'd0;
             strigger <=1'd0;
             ptrigger <=1'd0;
             mtrigger <=1'd0;
             etrigger <=1'd0;
         end
         else begin
             Op_actual<=prox;
             //Establezco el trigger correspondiente a la operacion a realizar
             case (prox)
                 3: atrigger <=1'd1;
                 4: btrigger <=1'd1;
                 5: strigger <=1'd1;
                 6: ptrigger <=1'd1;
                 7: mtrigger <=1'd1;
                 8: etrigger <=1'd1;
                 default: begin
                     atrigger <=1'd0;
                     btrigger <=1'd0;
                     strigger <=1'd0;
                     ptrigger <=1'd0;
                     mtrigger <=1'd0;
                     etrigger <=1'd0;
                 end
             endcase
         end
  
endmodule
