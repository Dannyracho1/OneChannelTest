`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:44:22 04/24/2019 
// Design Name: 
// Module Name:    crc 
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
module crc(
	input 				I_clk,		// Input clock 200Mhz
	input				I_newData,	// Flag which indicates if new data are available
	input				I_rst,		// Reset the rdy flag
	input 		[31:0] 	I_data,		// Data for which the crc have to be calculated
	
	output reg 	[7:0]	O_crc8,		// Resulting value
	output reg			O_rdy		// Indicates if the calculation is done
	);
	
	// Inital values
	initial begin
		O_crc8 <= 8'b00000000;
		O_rdy <= 1'b0;
	end
	
	reg [31:0]	r_intData			= 32'h69000000;		// internal data (69 is the WRTCODE from the main, inserted here just to eliminate synthesis warnings) 
	reg [7:0] 	r_counter 			= 8'b00000000;		
	reg [1:0] 	r_case 				= 4'b00;
	reg 		r_newDataFlag		= 1'b0;				// Rising edge detection
	reg [7:0] 	r_crc				= 8'b00000000;
	reg [7:0] 	r_adress			= 8'b00000000;		// Adress of the crc table
	reg 		r_rstFlag			= 1'b0;				// Rising edge detection
	
	parameter IDLE = 2'b00;
	parameter XOR  = 2'b01;
	parameter LUT  = 2'b10;
	parameter END  = 2'b11;
	
	always @(posedge I_clk) begin
		case(r_case)
			IDLE: begin
				// Detect rising edge of new data
				r_newDataFlag <= I_newData;
				if(I_newData > r_newDataFlag) begin
					// Init first CRC value
					r_crc <= 8'b00000000;
					r_case <= XOR;
					// Number of bytes left
					r_counter <= 31;
					// Safe input data
					r_intData <= I_data;
				end
			end
			XOR: begin
				// XOR input bytes with first crc value
				r_adress <= r_crc ^ r_intData[r_counter -: 8];
				r_case <= LUT;
			end
			
			LUT: begin
				// Get new CRC value from LUT
				case(r_adress)
					8'b00000000: r_crc <= 8'h0;
					8'b00000001: r_crc <= 8'h7;
					8'b00000010: r_crc <= 8'hE;
					8'b00000011: r_crc <= 8'h9;
					8'b00000100: r_crc <= 8'h1C;
					8'b00000101: r_crc <= 8'h1B;
					8'b00000110: r_crc <= 8'h12;
					8'b00000111: r_crc <= 8'h15;
					8'b00001000: r_crc <= 8'h38;
					8'b00001001: r_crc <= 8'h3F;
					8'b00001010: r_crc <= 8'h36;
					8'b00001011: r_crc <= 8'h31;
					8'b00001100: r_crc <= 8'h24;
					8'b00001101: r_crc <= 8'h23;
					8'b00001110: r_crc <= 8'h2A;
					8'b00001111: r_crc <= 8'h2D;
					8'b00010000: r_crc <= 8'h70;
					8'b00010001: r_crc <= 8'h77;
					8'b00010010: r_crc <= 8'h7E;
					8'b00010011: r_crc <= 8'h79;
					8'b00010100: r_crc <= 8'h6C;
					8'b00010101: r_crc <= 8'h6B;
					8'b00010110: r_crc <= 8'h62;
					8'b00010111: r_crc <= 8'h65;
					8'b00011000: r_crc <= 8'h48;
					8'b00011001: r_crc <= 8'h4F;
					8'b00011010: r_crc <= 8'h46;
					8'b00011011: r_crc <= 8'h41;
					8'b00011100: r_crc <= 8'h54;
					8'b00011101: r_crc <= 8'h53;
					8'b00011110: r_crc <= 8'h5A;
					8'b00011111: r_crc <= 8'h5D;
					8'b00100000: r_crc <= 8'hE0;
					8'b00100001: r_crc <= 8'hE7;
					8'b00100010: r_crc <= 8'hEE;
					8'b00100011: r_crc <= 8'hE9;
					8'b00100100: r_crc <= 8'hFC;
					8'b00100101: r_crc <= 8'hFB;
					8'b00100110: r_crc <= 8'hF2;
					8'b00100111: r_crc <= 8'hF5;
					8'b00101000: r_crc <= 8'hD8;
					8'b00101001: r_crc <= 8'hDF;
					8'b00101010: r_crc <= 8'hD6;
					8'b00101011: r_crc <= 8'hD1;
					8'b00101100: r_crc <= 8'hC4;
					8'b00101101: r_crc <= 8'hC3;
					8'b00101110: r_crc <= 8'hCA;
					8'b00101111: r_crc <= 8'hCD;
					8'b00110000: r_crc <= 8'h90;
					8'b00110001: r_crc <= 8'h97;
					8'b00110010: r_crc <= 8'h9E;
					8'b00110011: r_crc <= 8'h99;
					8'b00110100: r_crc <= 8'h8C;
					8'b00110101: r_crc <= 8'h8B;
					8'b00110110: r_crc <= 8'h82;
					8'b00110111: r_crc <= 8'h85;
					8'b00111000: r_crc <= 8'hA8;
					8'b00111001: r_crc <= 8'hAF;
					8'b00111010: r_crc <= 8'hA6;
					8'b00111011: r_crc <= 8'hA1;
					8'b00111100: r_crc <= 8'hB4;
					8'b00111101: r_crc <= 8'hB3;
					8'b00111110: r_crc <= 8'hBA;
					8'b00111111: r_crc <= 8'hBD;
					8'b01000000: r_crc <= 8'hC7;
					8'b01000001: r_crc <= 8'hC0;
					8'b01000010: r_crc <= 8'hC9;
					8'b01000011: r_crc <= 8'hCE;
					8'b01000100: r_crc <= 8'hDB;
					8'b01000101: r_crc <= 8'hDC;
					8'b01000110: r_crc <= 8'hD5;
					8'b01000111: r_crc <= 8'hD2;
					8'b01001000: r_crc <= 8'hFF;
					8'b01001001: r_crc <= 8'hF8;
					8'b01001010: r_crc <= 8'hF1;
					8'b01001011: r_crc <= 8'hF6;
					8'b01001100: r_crc <= 8'hE3;
					8'b01001101: r_crc <= 8'hE4;
					8'b01001110: r_crc <= 8'hED;
					8'b01001111: r_crc <= 8'hEA;
					8'b01010000: r_crc <= 8'hB7;
					8'b01010001: r_crc <= 8'hB0;
					8'b01010010: r_crc <= 8'hB9;
					8'b01010011: r_crc <= 8'hBE;
					8'b01010100: r_crc <= 8'hAB;
					8'b01010101: r_crc <= 8'hAC;
					8'b01010110: r_crc <= 8'hA5;
					8'b01010111: r_crc <= 8'hA2;
					8'b01011000: r_crc <= 8'h8F;
					8'b01011001: r_crc <= 8'h88;
					8'b01011010: r_crc <= 8'h81;
					8'b01011011: r_crc <= 8'h86;
					8'b01011100: r_crc <= 8'h93;
					8'b01011101: r_crc <= 8'h94;
					8'b01011110: r_crc <= 8'h9D;
					8'b01011111: r_crc <= 8'h9A;
					8'b01100000: r_crc <= 8'h27;
					8'b01100001: r_crc <= 8'h20;
					8'b01100010: r_crc <= 8'h29;
					8'b01100011: r_crc <= 8'h2E;
					8'b01100100: r_crc <= 8'h3B;
					8'b01100101: r_crc <= 8'h3C;
					8'b01100110: r_crc <= 8'h35;
					8'b01100111: r_crc <= 8'h32;
					8'b01101000: r_crc <= 8'h1F;
					8'b01101001: r_crc <= 8'h18;
					8'b01101010: r_crc <= 8'h11;
					8'b01101011: r_crc <= 8'h16;
					8'b01101100: r_crc <= 8'h3;
					8'b01101101: r_crc <= 8'h4;
					8'b01101110: r_crc <= 8'hD;
					8'b01101111: r_crc <= 8'hA;
					8'b01110000: r_crc <= 8'h57;
					8'b01110001: r_crc <= 8'h50;
					8'b01110010: r_crc <= 8'h59;
					8'b01110011: r_crc <= 8'h5E;
					8'b01110100: r_crc <= 8'h4B;
					8'b01110101: r_crc <= 8'h4C;
					8'b01110110: r_crc <= 8'h45;
					8'b01110111: r_crc <= 8'h42;
					8'b01111000: r_crc <= 8'h6F;
					8'b01111001: r_crc <= 8'h68;
					8'b01111010: r_crc <= 8'h61;
					8'b01111011: r_crc <= 8'h66;
					8'b01111100: r_crc <= 8'h73;
					8'b01111101: r_crc <= 8'h74;
					8'b01111110: r_crc <= 8'h7D;
					8'b01111111: r_crc <= 8'h7A;
					8'b10000000: r_crc <= 8'h89;
					8'b10000001: r_crc <= 8'h8E;
					8'b10000010: r_crc <= 8'h87;
					8'b10000011: r_crc <= 8'h80;
					8'b10000100: r_crc <= 8'h95;
					8'b10000101: r_crc <= 8'h92;
					8'b10000110: r_crc <= 8'h9B;
					8'b10000111: r_crc <= 8'h9C;
					8'b10001000: r_crc <= 8'hB1;
					8'b10001001: r_crc <= 8'hB6;
					8'b10001010: r_crc <= 8'hBF;
					8'b10001011: r_crc <= 8'hB8;
					8'b10001100: r_crc <= 8'hAD;
					8'b10001101: r_crc <= 8'hAA;
					8'b10001110: r_crc <= 8'hA3;
					8'b10001111: r_crc <= 8'hA4;
					8'b10010000: r_crc <= 8'hF9;
					8'b10010001: r_crc <= 8'hFE;
					8'b10010010: r_crc <= 8'hF7;
					8'b10010011: r_crc <= 8'hF0;
					8'b10010100: r_crc <= 8'hE5;
					8'b10010101: r_crc <= 8'hE2;
					8'b10010110: r_crc <= 8'hEB;
					8'b10010111: r_crc <= 8'hEC;
					8'b10011000: r_crc <= 8'hC1;
					8'b10011001: r_crc <= 8'hC6;
					8'b10011010: r_crc <= 8'hCF;
					8'b10011011: r_crc <= 8'hC8;
					8'b10011100: r_crc <= 8'hDD;
					8'b10011101: r_crc <= 8'hDA;
					8'b10011110: r_crc <= 8'hD3;
					8'b10011111: r_crc <= 8'hD4;
					8'b10100000: r_crc <= 8'h69;
					8'b10100001: r_crc <= 8'h6E;
					8'b10100010: r_crc <= 8'h67;
					8'b10100011: r_crc <= 8'h60;
					8'b10100100: r_crc <= 8'h75;
					8'b10100101: r_crc <= 8'h72;
					8'b10100110: r_crc <= 8'h7B;
					8'b10100111: r_crc <= 8'h7C;
					8'b10101000: r_crc <= 8'h51;
					8'b10101001: r_crc <= 8'h56;
					8'b10101010: r_crc <= 8'h5F;
					8'b10101011: r_crc <= 8'h58;
					8'b10101100: r_crc <= 8'h4D;
					8'b10101101: r_crc <= 8'h4A;
					8'b10101110: r_crc <= 8'h43;
					8'b10101111: r_crc <= 8'h44;
					8'b10110000: r_crc <= 8'h19;
					8'b10110001: r_crc <= 8'h1E;
					8'b10110010: r_crc <= 8'h17;
					8'b10110011: r_crc <= 8'h10;
					8'b10110100: r_crc <= 8'h5;
					8'b10110101: r_crc <= 8'h2;
					8'b10110110: r_crc <= 8'hB;
					8'b10110111: r_crc <= 8'hC;
					8'b10111000: r_crc <= 8'h21;
					8'b10111001: r_crc <= 8'h26;
					8'b10111010: r_crc <= 8'h2F;
					8'b10111011: r_crc <= 8'h28;
					8'b10111100: r_crc <= 8'h3D;
					8'b10111101: r_crc <= 8'h3A;
					8'b10111110: r_crc <= 8'h33;
					8'b10111111: r_crc <= 8'h34;
					8'b11000000: r_crc <= 8'h4E;
					8'b11000001: r_crc <= 8'h49;
					8'b11000010: r_crc <= 8'h40;
					8'b11000011: r_crc <= 8'h47;
					8'b11000100: r_crc <= 8'h52;
					8'b11000101: r_crc <= 8'h55;
					8'b11000110: r_crc <= 8'h5C;
					8'b11000111: r_crc <= 8'h5B;
					8'b11001000: r_crc <= 8'h76;
					8'b11001001: r_crc <= 8'h71;
					8'b11001010: r_crc <= 8'h78;
					8'b11001011: r_crc <= 8'h7F;
					8'b11001100: r_crc <= 8'h6A;
					8'b11001101: r_crc <= 8'h6D;
					8'b11001110: r_crc <= 8'h64;
					8'b11001111: r_crc <= 8'h63;
					8'b11010000: r_crc <= 8'h3E;
					8'b11010001: r_crc <= 8'h39;
					8'b11010010: r_crc <= 8'h30;
					8'b11010011: r_crc <= 8'h37;
					8'b11010100: r_crc <= 8'h22;
					8'b11010101: r_crc <= 8'h25;
					8'b11010110: r_crc <= 8'h2C;
					8'b11010111: r_crc <= 8'h2B;
					8'b11011000: r_crc <= 8'h6;
					8'b11011001: r_crc <= 8'h1;
					8'b11011010: r_crc <= 8'h8;
					8'b11011011: r_crc <= 8'hF;
					8'b11011100: r_crc <= 8'h1A;
					8'b11011101: r_crc <= 8'h1D;
					8'b11011110: r_crc <= 8'h14;
					8'b11011111: r_crc <= 8'h13;
					8'b11100000: r_crc <= 8'hAE;
					8'b11100001: r_crc <= 8'hA9;
					8'b11100010: r_crc <= 8'hA0;
					8'b11100011: r_crc <= 8'hA7;
					8'b11100100: r_crc <= 8'hB2;
					8'b11100101: r_crc <= 8'hB5;
					8'b11100110: r_crc <= 8'hBC;
					8'b11100111: r_crc <= 8'hBB;
					8'b11101000: r_crc <= 8'h96;
					8'b11101001: r_crc <= 8'h91;
					8'b11101010: r_crc <= 8'h98;
					8'b11101011: r_crc <= 8'h9F;
					8'b11101100: r_crc <= 8'h8A;
					8'b11101101: r_crc <= 8'h8D;
					8'b11101110: r_crc <= 8'h84;
					8'b11101111: r_crc <= 8'h83;
					8'b11110000: r_crc <= 8'hDE;
					8'b11110001: r_crc <= 8'hD9;
					8'b11110010: r_crc <= 8'hD0;
					8'b11110011: r_crc <= 8'hD7;
					8'b11110100: r_crc <= 8'hC2;
					8'b11110101: r_crc <= 8'hC5;
					8'b11110110: r_crc <= 8'hCC;
					8'b11110111: r_crc <= 8'hCB;
					8'b11111000: r_crc <= 8'hE6;
					8'b11111001: r_crc <= 8'hE1;
					8'b11111010: r_crc <= 8'hE8;
					8'b11111011: r_crc <= 8'hEF;
					8'b11111100: r_crc <= 8'hFA;
					8'b11111101: r_crc <= 8'hFD;
					8'b11111110: r_crc <= 8'hF4;
					8'b11111111: r_crc <= 8'hF3;
				endcase
				if(r_counter == 7) begin
					r_case <= END;
					O_rdy <= 1'b1;
				end
				
				else begin
					r_counter <= r_counter - 8;
					r_case <= XOR;
				end
			end
			
			END: begin
				O_crc8 <= r_crc;
				r_rstFlag <= I_rst;
				// Wait on rising edge of rst
				if(r_rstFlag < I_rst) begin
					r_case <= IDLE;
					O_rdy <= 0;
				end
			end
		endcase
		// Detecz rising edge
		
	end
endmodule
