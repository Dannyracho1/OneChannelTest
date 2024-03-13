`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:		10:15:28 03/07/2024 
// Design Name:		signalgen
// Module Name:		signalgen_DDR 
// Project Name:	Carbonara
// Target Devices: 	Xilinx 7-Series VC707 Evaluation Board
// Tool versions: 	Vivado 2023.2
// Description: 
// 
// Controls all DAC signals (including FIFO write and reset) 
// 
// Eventually align using one of the SYNC option(Check MATLAB GUI for documentation on SYNC Modes).
//
// Dependencies: 
//
// Revision: 
// Revision 1.0 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module signalgen_DDR(
		input 				I_clk,			   // Main clk 200MHz
		input               I_adjustable_clk,  // Trying to slow down data rate
		
		output reg 	[11:0] 	O_DAC_I,		// DAC Data Output CHA --> 12-bits
		output reg 	[11:0] 	O_DAC_Q,		// DAC Data Output CHB --> 12-bits
		
		//Main clock divider (for DAC update rate reduction)
		// input [7:0] I_speedDiv,
		
		// Stop complete streaming (during SPI communication etc.)
		input 				I_pause,
		// input 				I_activeCore, // implement later
		
		// Switch between SM modi: 
		// 1 -> normal output mode; 
		// 2 -> set IQ Data; 3 -> out of set state
		// 4 -> pause1	;	5 -> pause2
		
		input [7:0]	      	I_mode,

		// .I_wrtNewDataFlag(r_dacWRTConfig[0]),
		// .I_channelIndex(r_dacWRTConfig[4:1]),
		input 		[11:0]	I_dataLength,
		input 		[11:0]	I_Idata,
		input 		[11:0]	I_Qdata,
		
		// Data are ready to be written to RAM
		input				I_IQdataReady,	

		
		// Bit 0 -> 16QAM; Bit 1 -> 4QAM reduced; 
		// Bit 2 -> shift output data by one cycle; 
		// Bit 3 -> IQ interchange; Bit 4 -> invert DAC ResetIQ ; 
		// Bit 5 -> noInterleavedFFT 
		
		input [7:0]	      	I_BB_Settings
		);
		
	wire [10:0] w_Out_I_1;
	wire [10:0] w_Out_Q_1;		
	
	reg  [10:0] r_Out_I_Buffer_1;	
	reg  [10:0] r_Out_Q_Buffer_1;
	
	
    // Constants --> Implemented before
	parameter MEM_SIZE = 8348;			// Size of loop-memory for each DAC (Number of 10 bit words) (Bigger than 2^15 should not be implemented)
	parameter MEM_SIZE_FROM_ZERO  = MEM_SIZE-1;
	
	// Defining RAM: 12-bits of RAM for certain length: Ideally identical length
	reg [11:0] r_memory_I [0:MEM_SIZE_FROM_ZERO];
	reg [11:0] r_memory_Q [0:MEM_SIZE_FROM_ZERO];

    integer i;

	initial begin
		// Set everything to zero
		O_DAC_I <= 0;
		O_DAC_Q <= 0;
		
		for (i = 0; i < 8348; i = i + 1) begin
		  r_memory_I[i] <= 12'b0;
		  r_memory_Q[i] <= 12'b0;
		 end
	end
	
	
	// Internal State Machine
	
	// Output modi SM
	parameter NORMAL_OUTPUT = 8'b0000_0001;
	
	// data streaming state machine
	parameter SET_IQ_DATA 	= 8'b0000_0010;

	parameter PAUSE1		= 8'b0000_0100;
	parameter PAUSE2		= 8'b0000_0101;
	
	
	// Register	
	reg [15:0]	memory_idx			= 16'b0;	// keeps track of position in RAM
	reg [15:0]  uart_data_count		= 16'b0; 	// keeps track of UART data bits
	reg         output_flag			= 1'b1;		
	
	always @ (posedge I_clk) 
	begin
		if(!I_pause) // Stop the Convertion if I_pause is set
		begin
			case(I_mode)
				NORMAL_OUTPUT:	// Push the data from RAM to DAC
				begin
				    
				    if(I_adjustable_clk && output_flag) 
				    begin
                        O_DAC_I <= r_memory_I[memory_idx];
                        O_DAC_Q <= r_memory_Q[memory_idx];
                        if (memory_idx >= (I_dataLength-1))
                            memory_idx <= 0;
                        else
                            memory_idx <= memory_idx + 1;
                        
                        output_flag = 1'b0;
                    end
                    else if (!I_adjustable_clk && !output_flag)
                        output_flag = 1'b1;
				end
				SET_IQ_DATA:	// Gettin flag to store IQ to RAM
				begin
					if(I_IQdataReady)
					begin
						r_memory_I[uart_data_count] <= I_Idata;
						r_memory_Q[uart_data_count] <= I_Qdata;
						uart_data_count <= uart_data_count + 1;
					end
				end
				default:		// else-mode: reset both counters
				begin
					uart_data_count <= 0;
					memory_idx <= 0;
				end
			endcase
		end
	end
					
endmodule