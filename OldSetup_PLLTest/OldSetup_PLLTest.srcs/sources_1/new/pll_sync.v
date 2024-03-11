`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:51 05/24/2019 
// Design Name: 
// Module Name:    pll_sync 
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
module pll_sync(
	input		I_clk, // Main clock (200 MHz)
	input		I_pulseBit, // Input bit to pulse a sync pulse.
	output reg	O_PLL_sync	// Sync Output
    );
	
	reg [6:0] r_counter; 
	
	initial begin
		O_PLL_sync <= 0;
		r_counter <= 0;
	end
	
	always @ (posedge I_clk) begin 		// reset sync whenever its high 
		if(r_counter) r_counter <= r_counter - 1;
		if(I_pulseBit) begin
			r_counter <= 40;
			O_PLL_sync <= 1;
		end
		else begin
			if(!r_counter) O_PLL_sync <= 0;
		end
	end

endmodule
