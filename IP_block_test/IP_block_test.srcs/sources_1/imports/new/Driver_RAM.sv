`timescale 1ns / 1ps

module Driver_RAM#(parameter N = 8, bits = 8)(
    input logic clkin,
    input logic enable,
    input logic rx_ready,
    input logic [7:0] rx_data,
   // output logic [9:0] Write,
    output logic unsigned [bits-1:0] Dato [N - 1:0],
	output logic flag_end
    ); 
    
    logic [9:0] counter=10'd0;
    
    always_ff @(posedge clkin) begin 
		if (~enable) flag_end <= 1'b0;
		if (enable && rx_ready) begin
            if (counter== N-1) begin
			//	Write<=counter;
				Dato[counter] <= rx_data;
				counter<=10'd0;
				flag_end<=1'b1;
            end
            else begin
			//	Write<=counter;
				Dato[counter]<=rx_data;
				counter<=counter+10'd1;
				flag_end<=1'b0;
            end      
        end 
    end       
endmodule
