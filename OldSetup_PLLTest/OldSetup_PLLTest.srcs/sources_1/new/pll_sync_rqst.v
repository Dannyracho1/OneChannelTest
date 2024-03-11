`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RWTH Aachen - Lehrstuhl für Hoechstfrequenztechnik
// Engineer: Danny Racho
// 
// Create Date: 10/26/2023 02:06:45 PM
// Design Name: 
// Module Name: pll_sync_rqst
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
//  cherry-picked from signalgen_v2.v
//  needed to produce a pulse to SYNC PLLs
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pll_sync_rqst(
    input       I_clk,
    //Main clock divider (for DAC update rate reduction)
    input			I_pllSyncRequest,
    input 		[7:0]	I_PLLSyncPulseShift,
    
    // PLL Sync Pad Connection
    output	 	O_PLL_sync
        
    );
    
    
    // for synch pulse with defined phase relation to the DAC latching clocks.
    reg 		r_syncTrigger		= 0;
    reg			r_syncRequested		= 0;
    reg			r_syncRequestForwarded = 0;
    reg [7:0]	r_syncDelayCounter 	= 0;
    
    
	
	
	// SYNC generator
	pll_sync PLLSync(
		.I_clk(I_clk),
		.I_pulseBit(r_syncTrigger),
		.O_PLL_sync(O_PLL_sync)
	);
	
	
	
	always @ (posedge I_clk) 
	begin
		// Sync Pulse
		if(r_syncTrigger) // always reset the sync trigger, if set 
		begin
			r_syncTrigger <= 0;
		end
		if(I_pllSyncRequest)
		begin
			r_syncRequested <= 1;
			r_syncRequestForwarded <= 1;
		end
		if(r_syncRequestForwarded)
		begin
            r_syncTrigger <= 1;
            r_syncRequestForwarded <= 0;
		end
	end
	
    
    
endmodule
