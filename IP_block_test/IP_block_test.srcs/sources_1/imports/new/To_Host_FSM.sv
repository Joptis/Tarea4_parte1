`timescale 1ns / 1ps
module To_Host_FSM#(
    parameter INCREMENT_DELAY_CONTINUOUS = 3,
   	parameter comand_decoder = 1,
	parameter size_mem = 10,
	parameter N = 8) (
	input logic reset,
    input logic clk, tx_busy,
	input logic comand,	
	input logic unsigned [7:0] vector[N - 1:0],
	output logic [7:0] vector_tx,
	output logic  tx_start
    );
    
	logic [size_mem-1:0] counter;		 // counter memory_dir
	logic [1:0] memory_dir_plus; // to increment the memory_dir
	
	localparam DELAY_WIDTH = $clog2(INCREMENT_DELAY_CONTINUOUS);
    logic [DELAY_WIDTH-1:0] delay_timer;  

	
	// Estados de la maquina
    enum logic [3:0]{Idle, Memory, Tx, Busy} state, next_state;
   //Timer keeps track of how many cycles the FSM remains in a given state
   //Automatically resets the counter "delay_timer" when changing state
    // Para incrementar el contador para moverme en el arreglo de vector
        always_ff @(posedge clk) begin
		if (state != next_state) delay_timer <= 0; //reset the timer when state changes
		else delay_timer <= delay_timer + 1;
    end
	always_ff @(posedge clk) begin
		if (memory_dir_plus == 0) counter <= counter;	
		else if (memory_dir_plus == 1) counter <= counter + 1;
		else counter <= 0;
	end	
	
    // logica secuencial sincronica
    always_ff @(posedge clk)begin
        if(reset == 1) state <= Idle;
        else           state <= next_state;
    end
    // logica combinacional para los estados
  always_comb begin
            case(state)
                Idle : begin
                           if(comand == comand_decoder)
                              next_state = Memory;
                           else next_state = Idle;
                         end
                Memory : begin
                            if(delay_timer >= INCREMENT_DELAY_CONTINUOUS - 1)
                              next_state = Tx;
                           else next_state = Memory;
                         end
                Tx :    next_state = Busy;
                Busy : begin
							if(tx_busy)	next_state = Busy;
							else if (counter < N -1) next_state = Memory;
							else next_state = Idle; 
						end	
                default : next_state = Idle;  
             endcase          
    end
   // logica de salida 
   always_comb begin
    case(state)
        Idle :  begin
					memory_dir_plus = 2;
					vector_tx = 0;
					tx_start = 0;
				end	
        Memory : begin
					memory_dir_plus = 0;
					vector_tx = 0;
					tx_start = 0;
				end		
        Tx :    begin
                    vector_tx = vector[counter];
					tx_start = 1;
					memory_dir_plus = 0;
				end
		Busy :	begin
		            tx_start = 0;
					vector_tx = vector[counter];
					if(tx_busy) memory_dir_plus = 0;
					else if(counter < N -1) memory_dir_plus = 1;
					else memory_dir_plus = 2;
    			end
		        default : begin
					memory_dir_plus = 2;
					vector_tx = 0;
					tx_start = 0;
				end
    endcase
   end 
endmodule




