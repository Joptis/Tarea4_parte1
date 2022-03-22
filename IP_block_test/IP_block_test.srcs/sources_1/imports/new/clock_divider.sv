`timescale 1ns / 1ps

/******************************************************* 
clock_divider.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:
En base a un contador y a la llegada del mismo a un valor dado
por el parámetro "COUNTER_MAX" permite obtener una señal
de reloj "clk_out", cuya frecuencia está dado por:

    f_clk_out= f_clk_in/(2*COUNTER_MAX)
********************************************************/


module clock_divider

#(parameter COUNTER_MAX = 100000000) //100MHZ
( input logic clk_in ,
  input logic reset ,
  output logic clk_out  );
  
  localparam DELAY_WIDTH = $clog2(COUNTER_MAX);
  logic [DELAY_WIDTH-1:0] counter = 'd0 ;
  
  
  always_ff @(posedge clk_in) begin
    if (reset == 1'b1) begin
    
        counter <= 'd0;
        clk_out <= 0;
    end else if (counter == COUNTER_MAX -1) begin
    
      counter <= 'd0;
      clk_out <= ~clk_out;
    end else begin
    
    counter <= counter + 'd1;
    clk_out <= clk_out;
  end
 end
 
endmodule
      
        