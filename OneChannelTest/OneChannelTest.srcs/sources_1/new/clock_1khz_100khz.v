`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: RWTH Aachen - Lehrstuhl für Hoechstfrequenztechnik
// Engineer: Danny Racho
// 
// Create Date: 03/09/2024 08:45:01 PM
// Design Name: 
// Module Name: clock_1khz_100khz
// Project Name: Carbonara
// Target Devices: 
// Tool Versions: 
// Description: Added a new function to MATLAB GUI
// Streaming data from RAM register in FPGA to the DACs is now possible with an adjustable rate
// This function will adjust the rate according to the entered value in MATLAB GUI (Online change of data rate)
// The function is needed while using the debug card (XM105), but might be needed also later for the final version of the FDDAC
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// TODO: Rename to something like adjustable clock (1kHz - 100kHz)

module clock_1khz_100khz(
    input  wire         clk,
    input  wire [7:0]   divisor,
    output reg          clk_out
    );

integer counter = 0;

always @ (posedge clk) begin
   
    counter <= counter + 1;
    
    if (counter >= divisor - 1) begin
        counter <= 0;
    end
    
    clk_out <= (counter < (divisor/2)) ? 1 : 0;
end

endmodule


