`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:28 04/29/2019 
// Design Name: 
// Module Name:    signalgen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Controls all DAC signals (latching clock and data) and aligns their phases to PLL sync signals. Forwards the Processed Baseband data to the output.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module signalgen(
		input 				I_clk,			// Main clk 200MHz
		// DAC Data Outputs
		output reg 	[9:0] 	O_DAC_1,		
		output reg 	[9:0] 	O_DAC_2,
		output reg 	[9:0] 	O_DAC_3,
		output reg 	[9:0] 	O_DAC_4,
		output reg 	[9:0] 	O_DAC_5,
		output reg 	[9:0] 	O_DAC_6,
		output reg 	[9:0] 	O_DAC_7,
		output reg 	[9:0] 	O_DAC_8,
		// Data Clocks and control signals
		output reg 	[7:0] 	O_wrtIQ,
		output reg 	[7:0]	O_clkIQ,
		output reg 	[7:0] 	O_selIQ,
		output reg 	[7:0] 	O_resIQ,
		
		// PLL Sync Pad Connection
		output	 	O_PLL_sync,
		
		//Main clock divider (for DAC update rate reduction)
		input 		[7:0] 	I_speedDiv,
		input			I_pause, // Stop complete streaming (during SPI communication etc.)
		input		[7:0]	I_activeCore, // Selective (de-)activation of the different DAC Cores (Data streaming).
		
		input		[7:0]	I_mode,			// Switch between modi: 0 -> normal mode; 1 -> simple clock DAC output for synchronisation measurements
											// More modi implementation possible
		input			I_pllSyncRequest,
		input 		[7:0]	I_PLLSyncPulseShift,
		input		[7:0]	I_BB_Settings, // Bit 0 -> 16QAM; Bit 1 -> 4QAM reduced; Bit 2 -> shift output data by one cycle; Bit 3 -> IQ interchange; Bit 4 -> invert DAC ResetIQ ; Bit 5 -> noInterleavedFFT 
		//input		[7:0]	I_streamNr_Active
		input 			I_DACData_CycleShift // Delay the DAC Data output by one main clock cycle (i.e. 200MHz -> 5 ns) to align the output coarsly to the PLLs
	);
	

	
	// Memory for clock synchronisation output
	reg [9:0] r_memory_High_LOW [0:1];
	reg [9:0] r_memory_High_LOW_Q [0:1];

	wire w_PLL_SYNC;
	
	// Baseband generator outputs
	wire [10:0] w_Out_I_1;
	wire [10:0] w_Out_I_2;
	wire [10:0] w_Out_I_3;
	wire [10:0] w_Out_I_4;
	wire [10:0] w_Out_I_5;
	wire [10:0] w_Out_I_6;
	wire [10:0] w_Out_I_7;
	wire [10:0] w_Out_I_8;

	wire [10:0] w_Out_Q_1;
	wire [10:0] w_Out_Q_2;
	wire [10:0] w_Out_Q_3;
	wire [10:0] w_Out_Q_4;
	wire [10:0] w_Out_Q_5;
	wire [10:0] w_Out_Q_6;
	wire [10:0] w_Out_Q_7;
	wire [10:0] w_Out_Q_8;
	
	reg  [10:0] r_Out_I_Buffer_1;
	reg  [10:0] r_Out_I_Buffer_2;
	reg  [10:0] r_Out_I_Buffer_3;
	reg  [10:0] r_Out_I_Buffer_4;
	reg  [10:0] r_Out_I_Buffer_5;
	reg  [10:0] r_Out_I_Buffer_6;
	reg  [10:0] r_Out_I_Buffer_7;
	reg  [10:0] r_Out_I_Buffer_8;
	
	reg  [10:0] r_Out_Q_Buffer_1;
	reg  [10:0] r_Out_Q_Buffer_2;
	reg  [10:0] r_Out_Q_Buffer_3;
	reg  [10:0] r_Out_Q_Buffer_4;
	reg  [10:0] r_Out_Q_Buffer_5;
	reg  [10:0] r_Out_Q_Buffer_6;
	reg  [10:0] r_Out_Q_Buffer_7;
	reg  [10:0] r_Out_Q_Buffer_8;
	
	wire w_alternator;
	// baseband control register
	reg clk_for_bbgen;
	reg QAM16;
	reg reduced4QAM;
	reg rst; // Active Low reset for baseband_generator!
	reg [7:0] initial_rst_hold_counter; // Mandatory to implement an initial reset wich is long enough
	
	initial begin
		// Set everything to zero
		O_DAC_1 <= 0;
		O_DAC_2 <= 0;
		O_DAC_3 <= 0;
		O_DAC_4 <= 0;
		O_DAC_5 <= 0;
		O_DAC_6 <= 0;
		O_DAC_7 <= 0;
		O_DAC_8 <= 0;
		
		O_wrtIQ <= 8'b00000000;
		O_clkIQ <= 8'b00000000;
		O_selIQ <= 8'b00000000;
		O_resIQ <= 8'b00000000;
		
		r_memory_High_LOW[0] <= 1023;
		r_memory_High_LOW[1] <= 0;
		r_memory_High_LOW_Q[0] <= 700;
		r_memory_High_LOW_Q[1] <= 300;
		
		clk_for_bbgen = 1'b0;
		QAM16 = 1'b0;
		reduced4QAM = 1'b0;
		rst = 1'b0; // Active Low reset for baseband_generator!  -> start with reset
		initial_rst_hold_counter = 8'hFF;
	end
	
	
	
	// Internal State Machine
	
	// Output modi SM
	parameter NORMAL_OUTPUT = 0;
	parameter CLOCK_OUT_FOR_SYNC = 1;
	
	// data streaming state machine
	parameter SET_I_DATA 	= 3'b000;
	parameter PAUSE1		= 3'b001;
	parameter ADOPT_I_DATA 	= 3'b010;
	parameter SET_Q_DATA 	= 3'b011;
	parameter PAUSE2		= 3'b100;
	parameter ADOPT_Q_DATA 	= 3'b101;
	parameter SHIFT_CYCLE_STATE = 3'b110;
		
		
	
	// Register
	reg [2:0] 	r_state				= 3'b000;
	reg 		r_syncMemCounter	= 0;
	reg [7:0] 	r_streamDivCounter 	= 0;
	reg 		r_pauseCounter			= 0;	
	reg 		r_DACData_CycleShift = 0;	
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
	
	// The core part of the FD-DAC signal generation
	basebandTOP_Virtex7	bb_generator(
			.clk_fast(clk_for_bbgen),
			.rst(rst),
			.QAM16(QAM16),
			.reduced4QAM(reduced4QAM),
			.Out_re_0(w_Out_I_1),
			.Out_re_1(w_Out_I_2),
			.Out_re_2(w_Out_I_3),
			.Out_re_3(w_Out_I_4),
			.Out_re_4(w_Out_I_5),
			.Out_re_5(w_Out_I_6),
			.Out_re_6(w_Out_I_7),
			.Out_re_7(w_Out_I_8),
			.Out_im_0(w_Out_Q_1),
			.Out_im_1(w_Out_Q_2),
			.Out_im_2(w_Out_Q_3),
			.Out_im_3(w_Out_Q_4),
			.Out_im_4(w_Out_Q_5),
			.Out_im_5(w_Out_Q_6),
			.Out_im_6(w_Out_Q_7),
			.Out_im_7(w_Out_Q_8),
			.alternator_(w_alternator),
			.noInterleavedFFT(I_BB_Settings[5])
			);
	
	
	always @ (posedge I_clk) 
	begin
		// Cycle shift
		r_DACData_CycleShift <= I_DACData_CycleShift; 
		
		// Sync Pulse
		if(r_syncTrigger) // always reset the sync trigger, if set 
		begin
			r_syncTrigger <= 0;
		end
		if(I_pllSyncRequest)
		begin
			r_syncRequested <= 1;
		end
		if(r_syncRequestForwarded)
		begin
			if(r_syncDelayCounter == I_PLLSyncPulseShift)
			begin
				r_syncTrigger <= 1;
				r_syncRequestForwarded <= 0;
				r_syncDelayCounter <= 0;
			end
			else
			begin
				r_syncDelayCounter <= r_syncDelayCounter + 1;
			end
		end
		
		// DAC Data output
		if(!I_pause) // Stop the Convertion if I_pause or r_pause is set
		begin
			if(r_DACData_CycleShift) // Introduce a DAC output delay by one main clock cycle for coarse DAC to PLL aligment.
				r_DACData_CycleShift <= 0;
			else begin
				if(r_streamDivCounter) // Divider for the overall output speed. If set to 0 -> maximal output speed (ClockIQ of 100 MHz)	
					r_streamDivCounter <= r_streamDivCounter - 1;
				else begin
					case(I_mode)
						NORMAL_OUTPUT:
						begin
						case(r_state)
							SET_I_DATA: // In the first cycle set the data
							begin
								if(I_BB_Settings[2]) begin // Inphase output delayed by one DAC update cycle
									if(I_activeCore[0])
										O_DAC_1 <= r_Out_I_Buffer_1[9:0];
									if(I_activeCore[1])	
										O_DAC_2 <= r_Out_I_Buffer_2[9:0];
									if(I_activeCore[2])
										O_DAC_3 <= r_Out_I_Buffer_3[9:0];
									if(I_activeCore[3])
										O_DAC_4 <= r_Out_I_Buffer_4[9:0];
									if(I_activeCore[4])
										O_DAC_5 <= r_Out_I_Buffer_5[9:0];
									if(I_activeCore[5])
										O_DAC_6 <= r_Out_I_Buffer_6[9:0];
									if(I_activeCore[6])
										O_DAC_7 <= r_Out_I_Buffer_7[9:0];
									if(I_activeCore[7])
										O_DAC_8 <= r_Out_I_Buffer_8[9:0];
								end
								else begin // Inphase output NOT delayed by one DAC update cycle
									if(I_activeCore[0])
										O_DAC_1 <= w_Out_I_1[9:0];
									if(I_activeCore[1])	
										O_DAC_2 <= w_Out_I_2[9:0];
									if(I_activeCore[2])
										O_DAC_3 <= w_Out_I_3[9:0];
									if(I_activeCore[3])
										O_DAC_4 <= w_Out_I_4[9:0];
									if(I_activeCore[4])
										O_DAC_5 <= w_Out_I_5[9:0];
									if(I_activeCore[5])
										O_DAC_6 <= w_Out_I_6[9:0];
									if(I_activeCore[6])
										O_DAC_7 <= w_Out_I_7[9:0];
									if(I_activeCore[7])
										O_DAC_8 <= w_Out_I_8[9:0];
								end
								r_pauseCounter <= 0;
								r_state <= PAUSE1;
							end
							PAUSE1: // Pause for one cycle
							begin
								if(r_pauseCounter == 1) begin
									r_state <= ADOPT_I_DATA;
									clk_for_bbgen <= 1'b0; 
								end
								else
								begin
									O_wrtIQ <= 8'b00000000;
									O_clkIQ <= 8'b00000000;
									if(I_BB_Settings[3]) // Change the output selection of the DAC and thus exchange I and Q path
										O_selIQ <= 8'b00000000;
									else
										O_selIQ <= I_activeCore;
									if(I_BB_Settings[4]) // Change the update point of the DAC by one cycle, so the I and Q values are differntly interleaved
										O_resIQ <= 8'b00000000;
									else
										O_resIQ <= I_activeCore;
									r_pauseCounter <= 1;
								end
							end
							ADOPT_I_DATA: // Latch Clock trigger (at 75% of the data duty cycle, to let data signal reach fixed values)
							begin
								O_wrtIQ <= I_activeCore;
								O_clkIQ <= I_activeCore;
								r_state <= SET_Q_DATA;
							end 
							SET_Q_DATA: // Same for Q-Data
							begin
								if(I_BB_Settings[2]) begin // Inphase output delayed by one DAC update cycle
									if(I_activeCore[0])
										O_DAC_1 <= r_Out_Q_Buffer_1[9:0];
									if(I_activeCore[1])
										O_DAC_2 <= r_Out_Q_Buffer_2[9:0];
									if(I_activeCore[2])
										O_DAC_3 <= r_Out_Q_Buffer_3[9:0];
									if(I_activeCore[3])
										O_DAC_4 <= r_Out_Q_Buffer_4[9:0];
									if(I_activeCore[4])
										O_DAC_5 <= r_Out_Q_Buffer_5[9:0];
									if(I_activeCore[5])
										O_DAC_6 <= r_Out_Q_Buffer_6[9:0];
									if(I_activeCore[6])
										O_DAC_7 <= r_Out_Q_Buffer_7[9:0];
									if(I_activeCore[7])
										O_DAC_8 <= r_Out_Q_Buffer_8[9:0];

								end
								else begin
									if(I_activeCore[0])
										O_DAC_1 <= w_Out_Q_1[9:0];
									if(I_activeCore[1])
										O_DAC_2 <= w_Out_Q_2[9:0];
									if(I_activeCore[2])
										O_DAC_3 <= w_Out_Q_3[9:0];
									if(I_activeCore[3])
										O_DAC_4 <= w_Out_Q_4[9:0];
									if(I_activeCore[4])
										O_DAC_5 <= w_Out_Q_5[9:0];
									if(I_activeCore[5])
										O_DAC_6 <= w_Out_Q_6[9:0];
									if(I_activeCore[6])
										O_DAC_7 <= w_Out_Q_7[9:0];
									if(I_activeCore[7])
										O_DAC_8 <= w_Out_Q_8[9:0];
								end
								r_pauseCounter <= 0;
								r_state <= PAUSE2;				
							end
							PAUSE2:
							begin
								if(r_pauseCounter == 1) begin
									r_state <= ADOPT_Q_DATA;
									clk_for_bbgen <= 1'b1; // Latch new IQ information from the baseband-generator ( Toggle the bb clock for new data)

									// Buffer for data shift by one cycle
									r_Out_I_Buffer_1 <= w_Out_I_1;
									r_Out_I_Buffer_2 <= w_Out_I_2;
									r_Out_I_Buffer_3 <= w_Out_I_3;
									r_Out_I_Buffer_4 <= w_Out_I_4;
									r_Out_I_Buffer_5 <= w_Out_I_5;
									r_Out_I_Buffer_6 <= w_Out_I_6;
									r_Out_I_Buffer_7 <= w_Out_I_7;
									r_Out_I_Buffer_8 <= w_Out_I_8;
									
									r_Out_Q_Buffer_1 <= w_Out_Q_1;
									r_Out_Q_Buffer_2 <= w_Out_Q_2;
									r_Out_Q_Buffer_3 <= w_Out_Q_3;
									r_Out_Q_Buffer_4 <= w_Out_Q_4;
									r_Out_Q_Buffer_5 <= w_Out_Q_5;
									r_Out_Q_Buffer_6 <= w_Out_Q_6;
									r_Out_Q_Buffer_7 <= w_Out_Q_7;
									r_Out_Q_Buffer_8 <= w_Out_Q_8;
								end
								else
								begin
									r_pauseCounter <= 1;
									O_wrtIQ <= 8'b00000000;
									O_clkIQ <= 8'b00000000;
									if(I_BB_Settings[3]) // Change the output selection of the DAC and thus exchange I and Q path
										O_selIQ <= I_activeCore;
									else
										O_selIQ <= 8'b00000000;
									if(I_BB_Settings[4]) // Change the update point of the DAC by one cycle, so the I and Q values are differntly interleaved
										O_resIQ <= I_activeCore;
									else
										O_resIQ <= 8'b00000000;
								end
							end
							ADOPT_Q_DATA:
							begin								
								O_wrtIQ <= I_activeCore;
								O_clkIQ <= I_activeCore;
								r_state <= SET_I_DATA;
								if(r_syncRequested)
								begin
									r_syncRequested <= 0; // To be sure, the PLL Sync Pulse has a deterministic delay relative to the DAC update point, the Sync Request needs to be forwarded exactly here.
									r_syncRequestForwarded <= 1;
								end
							end
						endcase
						end
						CLOCK_OUT_FOR_SYNC: // Generates High Low signal at DAC output for synchronisation measurements with the PLL
						begin
						case(r_state)
							SET_I_DATA: 
							begin
								if(I_activeCore[0])
									O_DAC_1 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[1])	
									O_DAC_2 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[2])
									O_DAC_3 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[3])
									O_DAC_4 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[4])
									O_DAC_5 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[5])
									O_DAC_6 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[6])
									O_DAC_7 <= r_memory_High_LOW[r_syncMemCounter];
								if(I_activeCore[7])
									O_DAC_8 <= r_memory_High_LOW[r_syncMemCounter];
								r_pauseCounter <= 0;
								r_state <= PAUSE1;
							end
							PAUSE1:
							begin
								if(r_pauseCounter == 1)
									r_state <= ADOPT_I_DATA;
								else
								begin
									O_wrtIQ <= 8'b00000000;
									O_clkIQ <= 8'b00000000;
									O_selIQ <= I_activeCore;
									O_resIQ <= I_activeCore;
									r_pauseCounter <= 1;
								end
							end
							ADOPT_I_DATA:
							begin
								O_wrtIQ <= I_activeCore;
								O_clkIQ <= I_activeCore;
								r_state <= SET_Q_DATA;
							end
							SET_Q_DATA: 
							begin
								if(I_activeCore[0])
									O_DAC_1 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[1])
									O_DAC_2 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[2])
									O_DAC_3 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[3])
									O_DAC_4 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[4])
									O_DAC_5 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[5])
									O_DAC_6 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[6])
									O_DAC_7 <= r_memory_High_LOW_Q[r_syncMemCounter];
								if(I_activeCore[7])
									O_DAC_8 <= r_memory_High_LOW_Q[r_syncMemCounter];
								r_pauseCounter <= 0;
								r_state <= PAUSE2;				
							end
							PAUSE2:
							begin
								if(r_pauseCounter == 1)
									r_state <= ADOPT_Q_DATA;
								else
								begin
									r_pauseCounter <= 1;
									O_wrtIQ <= 8'b00000000;
									O_clkIQ <= 8'b00000000;
									O_selIQ <= 8'b00000000;
									O_resIQ <= 8'b00000000;
								end
							end
							ADOPT_Q_DATA:
							begin								
								O_wrtIQ <= I_activeCore;
								O_clkIQ <= I_activeCore;
								r_state <= SET_I_DATA;
								if(r_syncRequested)
								begin
									r_syncRequested <= 0; // To be sure, the PLL Sync Pulse has a deterministic delay relative to the DAC update point, the Sync Request needs to be forwarded exactly here.
									r_syncRequestForwarded <= 1;
								end
								if(r_syncMemCounter == 1) 	
									r_syncMemCounter <= 0;
								else 								
									r_syncMemCounter <= 1;
							end
						endcase
						end
					endcase
					
					if(initial_rst_hold_counter) // reset counter for the start
						initial_rst_hold_counter <= initial_rst_hold_counter - 1'b1;
					else
						rst <= 1'b1; // active low reset released
					
					// update evtl. changed settings from PC.
					r_streamDivCounter <= I_speedDiv;
					QAM16 <= I_BB_Settings[0];
					reduced4QAM <= I_BB_Settings[1];
				end
			end
		end
	end
endmodule
