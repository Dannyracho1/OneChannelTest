`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:21:14 04/25/2019 
// Design Name: 
// Module Name:    realSPI 
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
module realSPI(
	input 				I_clk,				// By default 200Mhz
	input [7:0] 		I_regAdress,		// MSB indicates if R or W. See datasheet. Adress of the LMX
	input 				I_newDataFlag,		// If rising flag, I_data will be written to the indivual LMX
	input	[15:0]		I_data,				// Data
	input				I_reset,			// Back to default/IDL
	input				I_MUXout,			// Pin to read data from LMX
	input [7:0]			I_actMOD,			// PLL/DAC which has to be programmed
	output reg			O_doneFlag,			// WARN: Not decently implemented yet. Indicates if wrt done
	output reg [15:0]	O_data,				// Data read 
	output reg			O_SCK,				// SPI Clock
	output reg			O_SDI,				// SPI SDI
	output reg [7:0]	O_CSB			    // PLL/DAC SPI latch (Chip Select)
	
	// output reg[3:0]	r_state				// DEBUG: Indicates the state of the state machine
	);
	
	initial begin
		O_doneFlag 	<= 0;
		O_data 		<= 0;
		O_SCK		<= 0;
		O_SDI 		<= 0;
		// CSB is active low
		O_CSB		<= 1;		
	end
	
	reg [3:0]	r_state 		= 4'b0000;
	reg 		r_newData		= 0;		
	reg			r_resetFlg		= 0;
	reg [15:0]	r_dataToSend	= 0;
	reg [7:0]	r_address		= 0;
	reg [15:0]	r_counter		= 0;
	reg [7:0]	r_bitCount		= 0;
	reg [15:0]	r_dataRead		= 0;
	
	parameter	IDLE 		= 4'b0000;
	parameter	READREG		= 4'b0001; 
	parameter	WRTREG		= 4'b0010; 
	parameter	SENDADDR	= 4'b0011; 
	
	parameter	COUNT10MHz	= 2000;
	parameter 	ADDR_WIDTH	= 8;
	parameter	DATA_WIDTH 	= 16;
	
	always @(posedge I_clk) begin
		if(r_counter) r_counter <= r_counter - 1;
		if(r_resetFlg < I_reset) begin
			// Just reset everything
			O_doneFlag 	<= 0;
			O_data 		<= 0;
			O_SCK		<= 0;
			O_SDI 		<= 0;
			// CSB is active low
			O_CSB		<= 8'b11111111;
		end
		
		// Detect rising edge
		r_newData <= I_newDataFlag;
		r_resetFlg <= I_reset;
		
		case(r_state)
			IDLE: begin
				O_SDI <= 0;
				O_SCK <= 0;
				if(r_newData < I_newDataFlag) begin
					// New data available
					r_address 		<= I_regAdress;
					r_dataToSend 	<= I_data;
					
					// Set individual CSB to low
					// NEW (Danny): Choose between PLL or DAC
                    O_CSB <= ~(I_actMOD);
					
					r_state			<= SENDADDR;
					r_bitCount		<= ADDR_WIDTH - 1;
					r_counter 		<= 0;
				end
				else begin
					O_CSB 			<= 8'b1111_1111;
				end
			end
			
			SENDADDR: begin
				if(!r_counter) begin
					O_SDI <= r_address[r_bitCount];
					r_counter <= COUNT10MHz;
					if(!r_bitCount) begin
						// Check if read or write
						// DEBUG
						r_state <= r_address[7] ? READREG : WRTREG;
						r_bitCount <= DATA_WIDTH; 
					end
					else begin
						r_bitCount <= r_bitCount - 1;
					end
					if(r_bitCount < (ADDR_WIDTH - 1)) O_SCK <= !O_SCK; // Falling Edge
				end
				// Rising edge
				if(r_counter == 1000) O_SCK <= !O_SCK;				
			end
			
			READREG: begin
				// Read data on rising edge
				if(r_counter == 1000) begin
					O_SCK <= !O_SCK;
					if(r_bitCount)
						r_dataRead[r_bitCount - 1] <=  I_MUXout;
					r_bitCount <= r_bitCount - 1;
				end
				// Falling edge
				if(!r_counter) begin
					O_SCK <= !O_SCK;
					if(!r_bitCount) 
						r_state <= IDLE;
					r_counter <= COUNT10MHz;
				end
			end
			
			WRTREG: begin
				if(!r_counter) begin
					r_counter <= COUNT10MHz;
					if(!r_bitCount) begin
						r_state <= IDLE;
					end
					else begin
						O_SDI <= r_dataToSend[r_bitCount - 1];
						r_bitCount <= r_bitCount - 1;
					end
					O_SCK <= !O_SCK; // Falling Edge
				end
				// Rising edge
				if(r_counter == 1000) O_SCK <= !O_SCK;				
			end
		endcase
	end
endmodule
