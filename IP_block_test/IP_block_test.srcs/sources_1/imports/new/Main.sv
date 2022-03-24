`timescale 1ns / 1ps


/******************************************************* 
Main.sv
Creado por: Reiner López y José Cayo  
Funcionalidad:
Realiza la instanciacion de los módulos necesarios para la
implentacion de las operaciones a los Vectores enviados por
puerto serial
********************************************************/

module Main#(parameter N = 1024, numberbit = 8)(
    input logic clkin,
    input logic rx,
    output logic tx,
	output logic [7:0] Ena,
	output logic [6:0] Seg,
	output logic Euc_start, Euc_done
    );
    
 //  CLOCK
 logic clk, clk1KHz_out;
 
// UART 
     logic rx_ready;
     logic tx_busy;
     logic tx_start;
     logic [7:0] rx_data;
     logic [7:0] tx_data;

// MUX
	logic mrx_ready;;
	logic cmd_ready;;
	logic [7:0] mrx_data;
	logic [7:0] cmd_data;

// Driver_RAM
	logic flag_end_A, flag_end_B;
	logic [9:0] writeA, writeB;
    logic unsigned [numberbit-1:0] dataA [N-1:0];
    logic unsigned [numberbit-1:0] dataB [N-1:0];
	
// Command_Decoder_Op
	logic enableA, enableB, sel;
	logic [7:0] CMD;
	logic [7:0] Data;
    logic atrigger,btrigger,strigger,ptrigger,etrigger,mtrigger;

// Processing_Core
	logic [31:0] bcd, result_bcd;

// Para 7-seg	
	logic [3:0] datos;
	logic [2:0] selec;

// Clock
    Clock inst(
  // Clock out ports  
  .clk_out1(clk),
  // Clock in ports
  .clk_in1(clkin)
  );  
// Clock 1 Khz        
  clock_divider #(49999) Div_f1Khz(
    .clk_in(clkin),
    .reset(1'b0),
    .clk_out(clk1KHz_out)
    );
  // Uart Module, bajo autoría de Felipe Veas <felipe.veasv [at] usm.cl 
 uart_basic #(
.CLK_FREQUENCY(70000000),
.BAUD_RATE(115200)
 ) uart_basic(
.clk(clk),
.reset(1'b0),
.rx(rx),                // Se activa si rx
.rx_data(rx_data),      // data recibido
.rx_ready(rx_ready),    // Indica Byte listo
.tx(tx),                // enable tx ext
.tx_start(tx_start),    // start  tx  
.tx_data(tx_data),      // data tx
.tx_busy(tx_busy)       // busy
);   

// Mux Op    
Mux Mux(
    .rx_ready(rx_ready),
    .rx_data(rx_data),
    .sel(sel),
    .mrx_ready(mrx_ready),
    .mrx_data(mrx_data),
    .cmd_ready(cmd_ready),
    .cmd_data(cmd_data)
    );	
    
// Decoder    
Command_Decoder_Op Command_Decoder_Op(
    .clkin(clk),
    .rx_ready(cmd_ready),
    .rx_data(cmd_data),
	.flag_end_A(flag_end_A),
	.flag_end_B(flag_end_B),
    .enableA(enableA),
    .enableB(enableB),
    .sel(sel),	
    .atrigger(atrigger), // send A
	.btrigger(btrigger), // Send B
	.strigger(strigger), // Sum
	.ptrigger(ptrigger), // Avg
	.mtrigger(mtrigger), // Man
	.etrigger(etrigger), // Euc
    .command(CMD)            // Comand
  );   
     
// Pra escribir y enviar datos en la ram	
Driver_RAM#(.N(N))  SaveA(
    .clkin(clk),
    .enable(enableA),
    .rx_ready(mrx_ready),    // data ready
    .rx_data(mrx_data),      // recived data 
  //  .Write(writeA),          //  memory direction
    .Dato(dataA),           // send data to RAM
	.flag_end(flag_end_A)      // end   
    ); 
Driver_RAM#(.N(N))  SaveB(
    .clkin(clk),
    .enable(enableB),
    .rx_ready(mrx_ready), // data ready
    .rx_data(mrx_data), // recived data 
  // .Write(writeB),     //  memory direction
    .Dato(dataB),       // send data to RAM
	.flag_end(flag_end_B)   // end   
    ); 

//-------------------------------
Processing_Core2#(.N(N), .numberbit(8))  Processing_Core(
	.clkin(clk),
	.tx_busy(tx_busy),
	.atrigger(atrigger),
	.btrigger(btrigger),
	.strigger(strigger),
	.ptrigger(ptrigger),
	.mtrigger(mtrigger),
	.etrigger(etrigger),
    .command(CMD),
    .VectorA(dataA),
    .VectorB(dataB),
	.tx_start(tx_start),
    .tx_data(tx_data),
	.bcd(bcd),
	.Euc_done(Euc_done)
    );
// Felipe Veas <felipe.veasv [at] usm.cl
	UnsignedBcd bin2bcd(
		.clk(clk),             // Reloj
		.trigger(1'b1),        // Inicio de conversión
		.in(bcd),        // Número binario de entrada
		.idle(),               // Si vale 0, indica una conversión en proceso
		.bcd(result_bcd)       // Resultado de la conversión
	);
// Para 7-seg	
	Sweep Sweep(
	.clk(clk1KHz_out),
	.Data(result_bcd),
	.sel(selec),
	.bcd(datos)
    );
// Conversor de los datos a 7 segmentos
	BCD_to_sevenSeg BCD_to_sevenSeg(
	.Data(datos),
	.sel(selec),
	.Ena(Ena),
	.sevenSeg(Seg),
	.cmd(CMD)
    );
    
 //Salidas para medir latencia
 
 always_comb begin
    Euc_start=etrigger;
 end   
endmodule
