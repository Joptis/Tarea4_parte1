`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2021 11:41:43
// Design Name: 
// Module Name: Command_Decoder_Op
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
// command -> cmd -> CMD

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
				8'd1: begin 
					sel=1'b1;
					enableA<=1'b1;
					enableB<=1'b0;
					command<=8'd1;
				end
				8'd2: begin 
					sel=1'b1;
					enableA<=1'b0;
					enableB<=1'b1;
					command<=8'd2;
				end
				8'd3: begin
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd3;
				end
				8'd4: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd4;
				end
				8'd5: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd5;
				end
				8'd6: begin 
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd6;
				end
				8'd7: begin
					sel=1'b0;
					enableA<=1'b0;
					enableB<=1'b0;
					command<=8'd7;
				end
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
		if (flag_end_A == 1'b1 || flag_end_B == 1'b1) begin
			sel=1'b0;
			enableA<=1'b0;
			enableB<=1'b0;
		end
    end
    
     always_ff @(posedge clkin)
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
