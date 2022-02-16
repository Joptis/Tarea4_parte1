`timescale 1ns / 1ps
module BCD_to_sevenSeg(
	input logic [3:0]  Data,
	input logic [2:0]  sel,
	input logic [7:0] cmd,
	output logic [7:0] Ena,
	output logic [6:0] sevenSeg
	
    );

// convierte Data a 7seg
always_comb begin
	case (Data)
		4'd0:   sevenSeg = ~7'b0111111; 
        4'd1:   sevenSeg = ~7'b0000110;
        4'd2:   sevenSeg = ~7'b1011011; // 
        4'd3:   sevenSeg = ~7'b1001111; 
        4'd4:   sevenSeg = ~7'b1100110; 
        4'd5:   sevenSeg = ~7'b1101101; 
        4'd6:   sevenSeg = ~7'b1111101;
        4'd7:   sevenSeg = ~7'b0000111;
        4'd8:   sevenSeg = ~7'b1111111;
        4'd9:   sevenSeg = ~7'b1101111; 
		default:sevenSeg = ~7'b0000000; 
	endcase
end
// habilita display
always_comb begin
    if(cmd==8'd7 || cmd==8'd8 ) begin
		 case (sel)
			0: Ena=8'b11111110;
			1: Ena=8'b11111101;
			2: Ena=8'b11111011;
			3: Ena=8'b11110111;
			4: Ena=8'b11101111;
			5: Ena=8'b11011111;
			6: Ena=8'b10111111;
			7: Ena=8'b01111111;
			default: Ena=8'b11111111;
		endcase
	end
	else Ena=8'b11111111;
end

endmodule

