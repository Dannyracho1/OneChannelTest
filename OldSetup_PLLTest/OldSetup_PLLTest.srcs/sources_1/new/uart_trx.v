`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	HFE RWTH Aachen University
// Engineer: 	Daniel Stracke / Patrick Dll
// 
// Create Date:    13:35:11 04/24/2019 
// Design Name: 	FD-RFDAC-Control
// Module Name:    uart_trx 
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
module uart_trx(
	input [7:0]			dataToSend,		// data which should be transmitted to PC
	input 				clk,			// input clock (200MHz)
	input				sendDataFlag,	// Flag indicates if it should send data

	input				uart_rts,		// Low if it can send data
	
	output reg		dataSend		// send data	

	);
	
	 
	wire clkB;
	
	reg		currSend; // Indicates, if data are currently sending (can be implemented as output)
	reg clkBTemp = 1'b0;
	
	reg sendDataFlagTemp = 1'b0;	// trigger to send data
	reg rst;
	
	reg [7:0] counter = 8'h00;
	
	initial begin
		// Data_Line is at the beginning always high
		dataSend <= 1'b1; 
		currSend <= 1'b0;
		rst <= 1'b1;
	end
	
	// Here Baudrate of 500000 (maximum possible)
	clkDiv #(200) div (
		.clk_in(clk),
		.clk_out(clkB),
		.rst(rst)
	);
	
	always @(posedge clk) begin
		// Detect rising edge
		sendDataFlagTemp <= sendDataFlag;
		if(sendDataFlagTemp > sendDataFlag) begin
			rst <= 1'b0;
			currSend <= 1'b1;
		end
		
		// Send data when currSend is high and uart_rts is low
		if (~uart_rts && currSend) begin
			clkBTemp <= clkB;
			if(clkBTemp < clkB) begin
				// Start with low bit 
				if(counter == 8'h00) begin
					dataSend <= 1'b0;
				end
				else if ((counter > 8'h00) && (counter <= 8'h08)) begin
					dataSend <= dataToSend[7 - (counter - 1)];
				end
				if (counter == 9) begin
					dataSend <= 1;
				end
				counter <= counter + 1;
			end
			else if(clkBTemp > clkB) begin
				if (counter == 10) begin
					rst <= 1'b1;
					currSend <= 1'b0;
					counter <= 8'h00;
				end
			end
		end
	end
endmodule 

/******************************************************************************************/
/*  Clock Divider Module										        										*/
/******************************************************************************************/
module clkDiv(
	input clk_in,				// Input clock
	input rst,					// Clock counter reset
	output reg clk_out = 0		// Output clock
	);
	
	parameter COUNTTO = 0;
	reg [13:0] r_count = 13'b0;
	
	always @ (posedge clk_in or posedge rst) begin
		if(rst) begin
			r_count <= 13'b0;
			clk_out <= 1'b0;
		end
		else begin
			r_count <= r_count + 1;
			if(r_count == COUNTTO) begin
				r_count <= 0;
				clk_out <= !clk_out;
			end
		end
	end
endmodule
