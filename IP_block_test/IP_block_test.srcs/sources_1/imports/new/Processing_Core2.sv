`timescale 1ns / 1ps
module Processing_Core2 #(parameter N = 8, numberbit = 8)(
    input logic clkin,
    input logic tx_busy,
	input logic atrigger,
	input logic btrigger,
	input logic strigger,
	input logic ptrigger,
	input logic mtrigger,
	input logic etrigger,
	input logic [7:0] command,
    input logic unsigned [numberbit-1:0] VectorA [N - 1:0],
    input logic unsigned [numberbit-1:0] VectorB [N - 1:0],
    output logic tx_start,
    output logic [7:0] tx_data,
	output logic [31:0] bcd
	);
   	
	logic tx_start_a, tx_start_b, tx_start_s, tx_start_p, tx_start_m, tx_start_e; 
	logic [9:0] readA_a, readA_s, readA_p, readA_m, readA_e; 
	logic [9:0] readB_b, readB_s, readB_p, readB_m, readB_e; 
	logic [7:0] result_readA, result_readB, result_sum,result_avg, result_euc,result_man;
    logic [7:0] tempA, tempB, LED;   
	logic [31:0] bcdm, bcde;  
   // assign tempA=vectorA;
   // assign tempB=vectorB;
    assign tx_start = tx_start_a || tx_start_b || tx_start_s || tx_start_p || tx_start_m || tx_start_e; 
   
   
   logic [23:0] result_tx;
   logic tx_startm;
   
   logic [numberbit-1:0] result_tx_save [2:0];
   
   logic unsigned [numberbit-1:0] Res_comb_SUM [N - 1:0];
   logic unsigned [numberbit-1:0] Res_comb_AVG [N - 1:0];
   integer i;
   
   
   	To_Host_FSM#(.N(N)) TX_A(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(atrigger),	
	.vector(VectorA),
	.vector_tx(result_readA),
	.tx_start(tx_start_a)
    );  
    
    To_Host_FSM#(.N(N)) TX_B(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(btrigger),	
	.vector(VectorB),
	.vector_tx(result_readB),
	.tx_start(tx_start_b)
    );   
    
  	always_comb begin
	for (i=0; i < N; i++)begin 
			Res_comb_SUM[i] = VectorA[i] + VectorB[i];
			Res_comb_AVG[i] = (VectorA[i] + VectorB[i])>>1;
	end		
	end
	
	
	
	To_Host_FSM#(.N(N)) TX_SUM(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(strigger),	
	.vector(Res_comb_SUM),
	.vector_tx(result_sum),
	.tx_start(tx_start_s)
    );  
    
   To_Host_FSM#(.N(N)) TX_AVG(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(ptrigger),	
	.vector(Res_comb_AVG),
	.vector_tx(result_avg),
	.tx_start(tx_start_p)
    );  
  
    //módulo para generar el valor de manhattan      
    
      Man_New#(.N(N)) DUT(
        .clk(clkin),
        .vectorA(VectorA),
        .vectorB(VectorB),
        .result(result_tx)
      
     );
     
    
    //Modulo para el nuevo modulo euclidiano
   logic [31:0] Euc_out;
   logic Euc_available;
   logic Euc_done;
   
   
    design_1 Euclin
   (
    .A1(VectorA[0]),
    .A2(VectorA[1]),
    .A3(VectorA[2]),
    .A4(VectorA[3]),
    .A5(VectorA[4]),
    .A6(VectorA[5]),
    .A7(VectorA[6]),
    .A8(VectorA[7]),
    .B1(VectorB[0]),
    .B2(VectorB[1]),
    .B3(VectorB[2]),
    .B4(VectorB[3]),
    .B5(VectorB[4]),
    .B6(VectorB[5]),
    .B7(VectorB[6]),
    .B8(VectorB[7]),
    .Euc_out(Euc_out),
    .Euc_available(Euc_available),
    .Euc_done(Euc_done),
    .clk(clkin),
    .reset_rtl_0(1'b0),
    .start(etrigger)
    );
    
    
   /*  always_ff @(posedge clkin) begin
        result_tx_save[0] <=  result_tx[18:16];
        result_tx_save[1] <=  result_tx[15:8];
        result_tx_save[2] <=  result_tx[7:0];
    end*/
    
    always_ff @(posedge clkin) begin
        result_tx_save[0]<=Euc_out;
    end		
   To_Host_FSM#(.N(1),.INCREMENT_DELAY_CONTINUOUS(400)) Euc_TX(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(Euc_done),	
	.vector(result_tx_save[0:0]),
	.vector_tx(result_euc),
	.tx_start(tx_start_e)
    );   
    
   /*   
   To_Host_FSM#(.N(3),.INCREMENT_DELAY_CONTINUOUS($clog2(N)-1)) Man_TX(
    .reset(1'b0),
    .clk(clkin),
    .tx_busy(tx_busy),
	.comand(mtrigger),	
	.vector(result_tx_save),
	.vector_tx(result_man),
	.tx_start(tx_start_m)
    ); 
    */
    always_comb begin
		case (command) 
			8'd3: begin 
				tx_data =result_readA;
				bcd=32'd0;				
			end
			8'd4: begin 
				tx_data =result_readB;
				bcd=32'd0;
			end
			8'd5: begin 
				tx_data =result_sum;
                bcd=32'd0;
			end
			8'd6: begin 
				tx_data =result_avg;
				bcd=32'd0;				
			end
			8'd7: begin 
				tx_data =result_man;
				bcd=result_tx;
			end
			8'd8: begin 
				tx_data =Euc_out;
				bcd=result_tx;
			end
			default: begin
				tx_data =1'b0;
				bcd=32'd0;
			end
		endcase
	end
	
 
    
	
	

endmodule
