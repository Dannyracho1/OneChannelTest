`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	HFE RWTH Aachen University
// Engineer: 	Daniel Stracke / Patrick Dll
// 
// Create Date:    12:41:24 04/24/2019 
// Design Name: 	FD-RFDAC-Control
// Module Name:    	uart_rcv 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_rcv(
	
	input 				dataRcv,		// single bit of data which is currently received
	input 				clk,			// input clock (200MHz)
	input 				rst,			// Reset data_rdy and data_recv
	




	
	output reg [7:0] 	data_recv,		// received data
	output reg 			data_rdy,		// Indicates, if data is ready

	// output 				clk_baud_debug, // pin which should stay high for half a Bit-Period at the beginning of a transmission for debugging
	output reg			uart_cts		// Set UART CTS

	);
	
	wire clkBaud;
	
	/* ---------------------------- Parameter ----------- */ 
	parameter IDLE 			= 4'b0000;
	parameter CHECKSTART 	= 4'b0001;
	parameter BIT0 			= 4'b0010;
	parameter BIT1 			= 4'b0011;
	parameter BIT2 			= 4'b0100;
	parameter BIT3 			= 4'b0101;
	parameter BIT4 			= 4'b0110;
	parameter BIT5 			= 4'b0111;
	parameter BIT6 			= 4'b1000;
	parameter BIT7 			= 4'b1001;
	parameter STOP 			= 4'b1010;
	
	parameter MAIN_CLOCK_DIVIDER = 400; // Divider of Main clock for the correct Baudrate (bsp: 20833 corresponds to 9600 Baud at 200 MHz Main Clock)
	parameter MAIN_CLOCK_DIVIDER_HALF = 200; // Half of Divider
	
	/*---------------- register ------------*/
	// reg			debug 		= 1'b0;
	reg[7:0] 	r_shift 		= 8'h00;
	reg[3:0] 	r_state 		= 4'b0000; // state for state machine in this module
	reg[15:0] 	r_count 		= 8'h00;
	//reg			r_crrRcv 	= 1'b0;
	
	reg	r_DataR 				= 1'b1;
	reg	r_DataMeta   		= 1'b1;
	/*
	clkDiv #(10416) div (
		.clk_in(clk),
		.clk_out(clkBaud),
		.rst(~clkBaud)
	);*/
	
	// assign clk_baud_debug = debug;
		
	always @ (posedge clk) begin
		// The hell avoid metastability 
      r_DataR <= dataRcv;
      r_DataMeta   <= r_DataR; // buffer for the (maybe) metastable output of r_DataR
	end
	
	always @ (posedge clk) begin
		uart_cts <= 1'b0;
		if(rst) begin
			data_rdy <= 1'b0;
			r_count 	<= 8'h00;
			r_shift 	<= 8'h00;
			r_state 	<= 4'b0000; // Reset state -> IDLE
			// r_crrRcv <= 1'b0;
		end
		
		// Countdown (runs continuosly for the correct timing in each state
		if(r_count != 8'h00) begin
			r_count <= r_count - 1;
		end
		
		case(r_state)
			IDLE: 
				// Check if there is a falling edge 
				if(!r_DataMeta) begin
					// debug <= 1;
					// Set state to CHECKSTART
					r_state <= CHECKSTART;
					// Start countdown
					r_count <= MAIN_CLOCK_DIVIDER_HALF;
					// r_crrRcv <= 1'b1;
					data_rdy <= 1'b0;
				end
			CHECKSTART:
				// Wait till counter is zero
				if(r_count == 8'h00) begin
					// Check if start bit is still zero
					if(!r_DataMeta) begin
						// Nice, go to the next bit and start the countdown again
						// debug <= 0;
						r_state <= BIT0;
						r_count <= MAIN_CLOCK_DIVIDER;
					end
					else begin
						// False detection
						// debug <= 0;
						r_state <= IDLE;
						// r_crrRcv <= 1'b0; 
					end
				end
			BIT0: if(r_count == 8'h00) begin 
					r_state <= BIT1;
					r_shift[0] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end

			BIT1: if(r_count == 8'h00) begin 
					r_state <= BIT2;
					r_shift[1] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end
			
			BIT2: if(r_count == 8'h00) begin 
					r_state <= BIT3;
					r_shift[2] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end

			BIT3: if(r_count == 8'h00) begin 
					r_state <= BIT4;
					r_shift[3] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end
			BIT4: if(r_count == 8'h00) begin 
					r_state <= BIT5;
					r_shift[4] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end

			BIT5: if(r_count == 8'h00) begin 
					r_state <= BIT6;
					r_shift[5] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end
			
			BIT6: if(r_count == 8'h00) begin 
					r_state <= BIT7;
					r_shift[6] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end

			BIT7: if(r_count == 8'h00) begin
					r_state <= STOP;
					r_shift[7] <=  r_DataMeta;
					r_count <= MAIN_CLOCK_DIVIDER;
				end
			
			STOP: if(r_count == 8'h00) begin
					data_recv <= r_shift;
					r_state <= IDLE;
					// r_crrRcv <= 1'b0;
					data_rdy <= 1'b1; 
				end
		endcase
	end
endmodule
