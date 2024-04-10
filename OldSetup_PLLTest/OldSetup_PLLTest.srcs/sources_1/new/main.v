`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	HFE RWTH Aachen University
// Engineer: 	Daniel Stracke / Patrick Doell
// 
// Create Date:    11:17:40 04/24/2019 
// Design Name: 	FDDAC-8Channel-Control
// Module Name:    	main 
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
module main(

/*--------------------------------------------------------------------------------------------*/
/*----  Outputs/Inputs -----------------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------*/
	
	// USER_CLOCK 100MHz - set first to 200MHz for test
	
	input			USER_CLOCK,
	
	// Systemclock 200MHz - will be connected to a buffer with single ended output "clk"
    input			SYSCLK_P,
    input			SYSCLK_N,

	// LEDs on the VC707_FPGA Board itself
	output [7:0]	GPIO_LED,		// LED0..7
   
	// PC Control
	output 			USB_UART_RX,		// Data to the PC
	input 			USB_UART_TX,		// Data from the PC
	output 			USB_UART_CTS,		// Indicates the UART IC, if it can accepted data from the PC	

	// Signals to DAC on PCB
	
	output [11:0] 	DACData1_P,			// DAC data from CH1 positive
	output [11:0] 	DACData1_N,			// DAC data from CH1 negative
	output [11:0] 	DACData2_P,			// ...
	output [11:0] 	DACData2_N,			// ...
	output [11:0] 	DACData3_P,			// ...
	output [11:0] 	DACData3_N,			// ...
	output [11:0] 	DACData4_P,			// ...
	output [11:0] 	DACData4_N,			// ...
	output [11:0] 	DACData5_P,			// ...
	output [11:0] 	DACData5_N,			// ...
	output [11:0] 	DACData6_P,			// ...
	output [11:0] 	DACData6_N,			// ...
	output [11:0] 	DACData7_P,			// ...
    output [11:0] 	DACData7_N,			// ...
    output [11:0] 	DACData8_P,			// ...
    output [11:0] 	DACData8_N,			// ...

	

    // DAC Global Clocks (critical: low-jitter prefered)
	
	output [7:0] 	DACCLK_P,			// DAC Clocks positive
	output [7:0] 	DACCLK_N,			// DAC Clocks negative
	
	// DAC Data Clocks (less critical than DACCLK_P/N)
	
	output [7:0] 	DATACLK_P,			// DAC DATA Clock  positive
	output [7:0] 	DATACLK_N,			// DAC DATA Clock negative
	
	// DAC SYNC Signal
	
	output			SYNC_P,	
	output			SYNC_N,
	

	// PLL SPI Signals
	output			PLL_MOSI,
	input			PLL_MISO,
	output			PLL_SCK,
	output [7:0]	PLL_CSB, // 8 Latch-Pins for 8 PLLs
	
	// PLL SPI Signals
	output			DAC_MOSI,
	input			DAC_MISO,
	output			DAC_SCLK,
	
	output [7:0]	DAC_CSB, // 8 Latch-Pins for 8 DACs
	
	// DAC_CONFIG Pins: Bit0 -> Resetb, Bit1 -> Alarm, Bit2 -> Ex_ENA, Bit3 -> Sleep
	input 			ALARM,		// Not set yet
	output 			RESETB,
	output			TXENABLE,
	output 			SLEEP,
	
	// PLL SYNC (maybe not needed)
	output 			PLL_SYNC // When used, PLL readback through SPI_MISO isn't available
	);

/*---------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------Initial----------------*/
/*---------------------------------------------------------------------------------------------------*/

	initial begin
		
	end
	
/*---------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------------Wires-------------*/
/*---------------------------------------------------------------------------------------------------*/
	
	// Clock
	wire 			clk;			// 200 MHz System Clock
	wire			w_clk;			// 200 MHz (might not be needed)
	
	// UART
	wire 			w_dataRdy;		// UART Data available		
	wire [7:0]		w_uartrx; 		// UART Data	
	
	// CRC
	wire [7:0]		w_crcResult; 	// Result of the CRC check to be send back to PC
	wire 			w_crcRdy; 		// Indicates whether the CRC calculation is done or not
	
	// SPI
	wire			w_MOSI;			// SPI Data Output
	wire			w_SCK;			// SPI Clock
	wire [7:0]		w_PLL_CSB;			// SPI Chip Select for the 8 different PLLs
	wire [7:0]		w_DAC_CSB;			// SPI Chip Select for the 8 different DACs
	
	// PLL SYNC
	wire			w_PLL_SYNC;			// Synchronisation line for PLLs
	
	// DAC CONFIG
	wire            w_ALARM;
	wire            w_RESETB; 
    wire            w_TXENABLE;
	wire            w_SLEEP;	
	
	//Signal generator
	wire [7:0]	    w_DACCLKIQ_delayed;
	wire [7:0]	    w_DACCLKIQ;			// Clock Signals for every Transmit Core
	wire [7:0]	    w_DACWRTIQ;
	wire [7:0]	    w_DACSELIQ;
	wire [7:0]	    w_DACRESETIQ;

	// IMPORTANT: For ODDR & OBUFDS wires needed
	
	wire [11:0]     w_DACData_I;			// DAC Data In-Phase:   from RAM to ODDR (Double-Data Rate)
	wire [11:0]     w_DACData_Q;			// DAC Data Quadrature: from RAM to ODDR (Double-Data Rate)

    wire [11:0]	    w_DACData1_toDIFF;		// DAC Data 1 over ODDR to OBUFDS
	wire [11:0]	    w_DACData2_toDIFF;		// DAC Data 1 over ODDR to OBUFDS
	wire [11:0]		w_DACData7_toDIFF;		// DAC Data 7 over ODDR to OBUFDS
    wire [11:0]	    w_DACData8_toDIFF;		// DAC Data 8 over ODDR to OBUFDS
	
	// SYNC Signal!!
	wire            w_DAC_SYNC;
	
	// DACData Protection: 10Hz from tenhz_mod
	wire            w_10hz_clock;

	// DACData Protection: 10Hz from tenhz_mod
	wire            w_adjustable_clock;
	
	// DACData2: delayed to meet the setup+hold constraints of the DAC
	wire			DATACLK_delayed;
	
	// Daniel suggestion:                      --> ODELAY2 ODATAIN not connected (error)
	// [DRC REQP-131] enum_DELAY_SRC_ODATAIN_connects_ODATAIN_connects_ODATAIN_ACTIVE: ODELAY2_DAC_CLK1: 
	// For DELAY_SRC ODATAIN programming the ODATAIN input pin of ODELAYE2 must be connected.

	// assign w_DACCLKIQ[7:0] = 8'b0000_0000;
	
	// Try also:                               --> 
	// assign w_DACCLKIQ[7:0] = 8'b1111_1111;
	// Or:                                     --> 
	assign w_DACCLKIQ[7:0] = w_DACCLKIQ_delayed[7:0];
	assign w_DACCLKIQ_delayed[7:0] = 8'b0000_0000;
	
	// Driving UART_RX/TX out to debug
	wire			w_datasend_rx;
	wire			w_switch_to_tx;
	
	
/*---------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------Parameter (constants)----*/
/*---------------------------------------------------------------------------------------------------*/

	// Different states of the main programm state machine
	parameter IDLE				= 4'b0000; 			// No data comes from PC. Nothing to do.
	parameter READREG 			= 4'b0001; 			// PC wants to read data from a specific register
	parameter REGADDR 			= 4'b0010; 			// Since we are reading 8-bit sequences this is the state where we get the REGADDR to read or write to.
	parameter REGVAL 			= 4'b0011; 			// The value to write to the register
	parameter WRTREG			= 4'b0101; 			// Here the register is actually written
	parameter RST				= 4'b0110; 			// Reset state -> every module is reset
	parameter CALCCRC			= 4'b0111; 			// State where to calculate the crc (wait for the crc module to be finished)

	// Register Adresses (LUT)
	parameter ID 				= 8'h00;			// "Unique" Device ID
	parameter LED 				= 8'h01;			// Set LEDs on and off
	parameter UARTSET 			= 8'h02;			// Settings for UART
	parameter UARTTX 			= 8'h03;			// Data to send over UART
	parameter DACSET			= 8'h0A;			// Settings for DAC connection
	parameter DAC_I_LSB 		= 8'h0B;			// Data for DAC Channel A
	parameter DAC_I_MSB			= 8'h0C;			// |0000 00 MSB MSB||LSB ... LSB| since we only need 10 bit per sample for the DAC
	parameter DAC_Q_LSB 		= 8'h0D;	
	parameter DAC_Q_MSB			= 8'h0E;
	parameter DACCLOCK			= 8'h0F;

	parameter REALSPI			= 8'h10;			// Trigger for the unique PLLs
	parameter SPITXMSB			= 8'h11;			// 16 bit data register to transmit
	parameter SPITXLSB			= 8'h12;			// ...
	parameter SPIREGADDR		= 8'h13;			// PLL register address
	parameter SPIRXMSB			= 8'h14;			// Received data. Not implemented yet.
	parameter SPIRXLSB			= 8'h15;			// ...
	parameter SPIACTPLL			= 8'h16;			// Controls the SPI_CSB pins on PLL
	
	parameter DACDATALENGTH_LSB	= 8'h17;			// Length of looped DAC-Data LSB (minus one)
	parameter DACDATALENGTH_MSB	= 8'h18;			// Length of looped DAC-Data MSB (minus one)
	parameter DACWRTCONFIG		= 8'h19;			// Write configuration of DAC
	parameter DACACTIVECORE		= 8'h20;			// Select DAC Cores to be active (with streaming)
	parameter DAC_MODE			= 8'h21;			// Select DAC Mode (0 - Normal; 1 - Clock sync)
	
	parameter PLLSYNC			= 8'h22;			// Triggers the PLL Sync pulse
	parameter PLLSYNCPULSESHIFT = 8'h23;			// This register Shifts the output of the PLL Sync Pulse relative to the DAC update clock. (Actually just delays it by a number of reference clock cycles)
	
	parameter CLKDELAY_CLK1		= 8'h24;			// Delay for DAC1 output clock
	parameter CLKDELAY_CLK2		= 8'h25;			// Delay for DAC2 output clock
	parameter CLKDELAY_CLK3		= 8'h26;			// Delay for DAC3 output clock
	parameter CLKDELAY_CLK4		= 8'h27;			// Delay for DAC4 output clock
	parameter CLKDELAY_CLK5		= 8'h28;			// Delay for DAC5 output clock
	parameter CLKDELAY_CLK6		= 8'h29;			// Delay for DAC6 output clock
	parameter CLKDELAY_CLK7		= 8'h2A;			// Delay for DAC7 output clock
	parameter CLKDELAY_CLK8		= 8'h2B;			// Delay for DAC8 output clock

	parameter BB_SETTINGS		= 8'h2C;			// Baseband settings (16QAM, reduced 4QAM, data shift by one DAC update cycle) 
	parameter DAC_CONFIG		= 8'h2D;			// New (Danny): Resetb, Alarm, Ex_ENA, Sleep directly to PINS (41, 47, 48, 49) on each DAC
	parameter SPIACTDAC			= 8'h2E;			// New (Danny): Controls the SPI_CSB pins on DAC
	parameter ODDR_Settings		= 8'h2F;			// New (Danny): Testing settings for ODDR on DACData7
	
	// Internal constant parameters
	parameter RESETTIME 		= 2_000_000; 		// Whenever reset is triggered, this number of clock cycles does the reset takes time (in case of 2_000_000 this is 10 ms)
	
	// UART operational codes
	parameter READCODE			= 8'b11110001;		// This instruction code indicates, that the PC wants to read from the FPGA registers
	parameter WRTCODE			= 8'b01101001;		// This instruction code indicates, that the PC wants to write to the FPGA registers
	parameter RSTCODE			= 8'b10010100;		// Reset Code to trigger the reset state
	
/*---------------------------------------------------------------------------------------*/
/*-------------------------------------------------Registers and their initial values-----*/
/*---------------------------------------------------------------------------------------*/

	// external register for PC-access
	reg	[7:0] 	r_idval 		= 8'h4E;			// "Unique" Device ID
	reg [7:0] 	r_ledval 		= 8'h00; 			// Set LEDs on and off
	reg [7:0] 	r_uarttx		= 8'h00;			// Data to send over UART
	reg [7:0]	r_uartset		= 8'b0;				// Settings for UART (MSB -> reset UART) 

	reg [7:0] 	r_regaddr		= 8'b0;
	
	reg [7:0] 	r_dacSet		= 8'h00;			// Settings for DAC connection (Bit 6: Pause dac stream; Bit 0: DAC output cycle shift trigger )
	reg [7:0] 	r_dac_I_lsb		= 8'h00;			// Data for DAC Channel A
	reg [7:0] 	r_dac_I_msb		= 8'h00;			// |0000 MSB MSB MSB MSB||LSB ... LSB| since we only need 12 bit per sample for the DAC
	reg [7:0] 	r_dac_Q_lsb		= 8'h00;			// Data for DAC Channel B
	reg [7:0] 	r_dac_Q_msb		= 8'h00;			// MSB and data ready to save to memory flag in one byte: Bit 0 and 1 ->
	reg [7:0] 	r_dacCLOCK		= 8'h09;			// Might be used for debug (output clock division)
	
	reg [7:0]	r_dacWRTConfig	= 8'h00;			// Write configuration (bit 0: 1->Memory Write State , 0->normal output operation ; bit 4,3,2 and 1: PCB memory index (which PCBs data should be overwritten))
	reg [7:0]	r_dacDataLength_lsb	= 8'hDB;			// Length of expected data, which comes from PC.
	reg [7:0]	r_dacDataLength_msb	= 8'h05;			// Length of expected data, which comes from PC.
	
	reg [7:0] 	r_realspi		= 8'h00;			// Trigger for the unique PLLs
	reg [7:0] 	r_spiTXMSB		= 8'h00;			// 16 bit data register to transmit
	reg [7:0] 	r_spiTXLSB		= 8'h00;			// ...
	reg [7:0] 	r_spiREGADDR	= 8'h00;			// PLL register address
	reg [7:0] 	r_spiRXMSB		= 8'h00;			// Received data. Not implemented yet.
	reg [7:0] 	r_spiRXLSB		= 8'h00;			// ...
	reg [7:0] 	r_spiACTPLL		= 8'h00;			// Controls the SPI_CSB pins, since we need to talk to 8 different PLLs
	reg [7:0]	r_dacActiveCore	= 8'hFF;			// Each bit controls the active state of one DAC Core.
	reg [7:0]	r_dacMode		= 8'h00;			// DAC Mode select
	reg [7:0]	r_pll_sync		= 8'h00;			// Controls the PLLs sync pulse
	reg [7:0]	r_syncPulseShift = 8'h00;			// This register Shifts the output of the PLL Sync Pulse relative to the DAC update clock. (Actually just delays it by a number of reference clock cycles)
	
	reg	[7:0]	r_delayValue_CLK1	= 8'h00;		// DAC1 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK2	= 8'h00;		// DAC2 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK3	= 8'h00;		// DAC3 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK4	= 8'h00;		// DAC4 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK5	= 8'h00;		// DAC5 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK6	= 8'h00;		// DAC6 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK7	= 8'h00;		// DAC7 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	reg	[7:0]	r_delayValue_CLK8	= 8'h00;		// DAC8 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented) 
	
	reg [7:0]	r_BB_Settings	= 8'h00;			// Bit 0 -> 16QAM; Bit 1 -> 4QAM reduced; Bit 2 -> shift output data by one cycle; Bit 3 -> IQ interchange; Bit 4 -> invert DAC ResetIQ ; Bit 5 -> noInterleavedFFT
	reg [7:0]	r_dacconfig		= 8'h00;			// New (Danny): Bit0 -> Resetb, Bit1 -> Alarm, Bit2 -> Ex_ENA, Bit3 -> Sleep
	reg [7:0]	r_spiACTDAC		= 8'h00;			// New (Danny): 8 different latches on 8 DACs
	reg [7:0]	r_oddrsettings	= 8'h01;			// New (Danny): Check ODDR instance for documentation about register values

	
	// Internal register (state machine etc.)
	reg [3:0]	r_state 		= 4'b0000; 			// State of the state machine. Initialized with the IDLE state
	reg		 	r_crcNewData	= 0;				// indicates new data to the CRC check module
	reg			r_crcRst		= 0; 
	reg			r_reset			= 1'b0;				// If high, reset complete system
	reg	[20:0] 	r_resetCounter	= 0;				// counter to time the reset state
	reg	[7:0]  	r_tempRegVal	= 8'h00;			// temporary memory for the received Register Value
	reg	[31:0] 	r_crcCheckInp	= {WRTCODE,24'h00};		// complete received data (4 Bytes) from the PC for the CRC calculation
	reg		 	r_uartrxFlag	= 0;				// Flag to indicate that there is data available from the UART
	reg		 	r_crcRdyFlag	= 0;				// Flag to indicate the finished CRC calculation

	
/*-------------------------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------- IO-Buffer ----*/
/*-------------------------------------------------------------------------------------------*/
	
	/* As stated in Xilinx application note UG799 and especially UG471, buffers are used to 
	isolate the internal circuit and provides drive current for signals leaving the chip. 
	Nice to know: You can set the drive strength (only OBUF) and even the slewrate of the 
	individual buffers. But: "faster slew rates can also lead to reflections or increased 
	noise issues if not properly designed"
	*/
	/*		
 	IBUFGDS clk_in_buff( 
 		.O  (clk),		// (This buffer may cause some warnings about a missing DQS_BIAS flag, but this can be ignored)
 		.I  (SYSCLK_P),
 		.IB (SYSCLK_N)	); 	
	*/
	
	// Differential to single ended buffer for the input System clock of 200 MHz
	IBUFGDS #(
        .DIFF_TERM("FALSE"), .IBUF_LOW_PWR("TRUE"), .IOSTANDARD("DEFAULT")
        ) 
    IBUFGDS_inst (
        .O(w_clk),
        .I(SYSCLK_P),
        .IB(SYSCLK_N)
    );

	
	// 200 MHz Main Clock generated from the 100 MHz reference
	system_clk_creator clk_gen(
		.CLK_IN1(USER_CLOCK),
		.CLK_OUT1(clk)
	);
	

	// PLL/DAC MISO
	IBUF IBUF_PLL_MISO(
		.I(PLL_MISO), 
		.O(w_PLL_MISO));

	IBUF IBUF_DAC_MISO(
		.I(DAC_MISO),
		.O(w_DAC_MISO));
	
	// PLL_SPI
	OBUF OBUF_PLL_MOSI(
		.I(w_PLL_MOSI), 
		.O(PLL_MOSI));
		
	OBUF OBUF_PLL_SCK(
		.I(w_PLL_SCK), 
		.O(PLL_SCK) );
		
	OBUF OBUF_PLL_CSB[7:0] (
		.I(w_PLL_CSB), 
		.O(PLL_CSB) );
	
	
	// DAC_SPI
	OBUF OBUF_DAC_MOSI(
		.I(w_DAC_MOSI), 
		.O(DAC_MOSI));
		
	OBUF OBUF_DAC_SCLK(
		.I(w_DAC_SCLK), 
		.O(DAC_SCLK) );
		
	OBUF OBUF_DAC_CSB[7:0] (
		.I(w_DAC_CSB), 
		.O(DAC_CSB) );
		
	// PLL_SYNC
	OBUF OBUF_PLLSYNC(
		.I(w_PLL_SYNC), 
		.O(PLL_SYNC) );
		
	// DAC CONFIG IN-/OUTPUT

	IBUF IBUF_ALARM(
		.I(ALARM), 
		.O(w_ALARM) );
	
	OBUF OBUF_RESETB(
		.I(w_RESETB), 
		.O(RESETB) );
	
	OBUF OBUF_TXENABLE(
		.I(w_TXENABLE), 
		.O(TXENABLE) );
		
	OBUF OBUF_SLEEP(
		.I(w_SLEEP), 
		.O(SLEEP) );
	
	// DAC Clocks
	
	OBUFDS OBUFDS_DACCLK[7:0] (
    	.I(w_adjustable_clock), 
    	.O(DACCLK_P), 
    	.OB(DACCLK_N)
    );
	
	// Danny: Refactor the ODELAY2 again!!! NOT FINAL
	// DAC2 Clk_Delay, Bit [3:0] -> Delay Value (~75 picoseconds per step); Bit 4: if set to one, the new value will be set (autoreset implemented)

	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value (round about 75 ps delay per step)
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DATACLK2 (
		.DATAOUT(DATACLK_delayed),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK2[4:0]),
		.LD(r_delayValue_CLK2[5]),
		.ODATAIN(w_adjustable_clock),
		.REGRST(1'b0)
	);


	OBUFDS OBUFDS_DATACLK0 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[0]),
    	.OB(DATACLK_N[0])
    );

	OBUFDS OBUFDS_DATACLK1 (
    	.I(DATACLK_delayed), 
    	.O(DATACLK_P[1]),
    	.OB(DATACLK_N[1])
    );
	
	OBUFDS OBUFDS_DATACLK2 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[2]),
    	.OB(DATACLK_N[2])
    );
	
	OBUFDS OBUFDS_DATACLK3 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[3]),
    	.OB(DATACLK_N[3])
    );
	
	OBUFDS OBUFDS_DATACLK4 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[4]),
    	.OB(DATACLK_N[4])
    );
	
	OBUFDS OBUFDS_DATACLK5 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[5]),
    	.OB(DATACLK_N[5])
    );
	
	OBUFDS OBUFDS_DATACLK6 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[6]),
    	.OB(DATACLK_N[6])
    );
	
	OBUFDS OBUFDS_DATACLK7 (
    	.I(w_adjustable_clock), 
    	.O(DATACLK_P[7]),
    	.OB(DATACLK_N[7])
    );
	


    
    // SYNC Signal!!
	OBUFDS OBUFDS_SYNC (
    	.I(w_DAC_SYNC), 
    	.O(SYNC_P),
    	.OB(SYNC_N)
    );
	
	// DAC Data
	
	
	// Check the documentation of Xilinx (UG953): https://docs.xilinx.com/r/en-US/ug953-vivado-7series-libraries/ODDR
	// Also the SelectIO document (UG471) (Page 128): https://docs.xilinx.com/v/u/en-US/ug471_7Series_SelectIO  
	
  
    ODDR #(
       .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
    ) ODDR_DACData1[11:0] (
       .Q(w_DACData1_toDIFF),   // 1-bit DDR output
       .C(w_adjustable_clock),   // 1-bit clock input
       .CE(I_mode == 8'b1111_1111), // 1-bit clock enable input
       .D1(w_DACData_I), // 1-bit data input (positive edge)
       .D2(w_DACData_Q), // 1-bit data input (negative edge)
       .R(12'b0),   // 1-bit reset
       .S(12'b1)    // 1-bit set
    );
    

	/************** r_oddrsettings for ODDR test on DACData7 **************/
	/************** 	Add r_oddrsettings to MATLAB!!		 **************/
	/************** 	Register settings as follows:		 **************/
	// Check: https://docs.xilinx.com/v/u/2012.2-English/ug953-vivado-7series-libraries (Page 292) for S/R and SRTYPE
	// r_oddrsettings[0] = 1: CE (Enable Input) or 0: Not-Enable
	// r_oddrsettings[2] = 1: clk (200MHz)		or 0: clk is adjustable_clock
	// r_oddrsettings[3] = 1: RESET=1 			or 0: RESET=0
	// r_oddrsettings[X] NOT ASSIGNED YET 

	ODDR #(
       .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
    ) ODDR_DACData2[11:0] (
       .Q(w_DACData2_toDIFF),   // 1-bit DDR output
       .C((r_oddrsettings[2]) ? clk : w_adjustable_clock),   // 1-bit clock input
       .CE((r_oddrsettings[0]) || (I_mode == 8'b1111_1111)), // 1-bit clock enable input
       .D1(w_DACData_I), // 1-bit data input (positive edge)
       .D2(w_DACData_Q), // 1-bit data input (negative edge)
       .R((r_oddrsettings[3]) ? 12'b1 : 12'b0),   // 1-bit reset
       .S(12'b0)    // 1-bit set
    );


    ODDR #(
       .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
    ) ODDR_DACData7[11:0] (
       .Q(w_DACData7_toDIFF),   // 1-bit DDR output
       .C((r_oddrsettings[2]) ? clk : w_adjustable_clock),   // 1-bit clock input
       .CE(r_oddrsettings[0]), // 1-bit clock enable input
       .D1(w_adjustable_clock), // 1-bit data input (positive edge)
       .D2(w_adjustable_clock), // 1-bit data input (negative edge)
       .R((r_oddrsettings[3]) ? 12'b1 : 12'b0),   // 1-bit reset
       .S(12'b0)    // 1-bit set
    );
    
    
    ODDR #(
       .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE"
       .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
       .SRTYPE("SYNC") // Set/Reset type: "SYNC" or "ASYNC"
    ) ODDR_DACData8[11:0] (
       .Q(w_DACData8_toDIFF),   // 1-bit DDR output
       .C((r_oddrsettings[2]) ? clk : w_adjustable_clock),   // 1-bit clock input
       .CE((r_oddrsettings[0]) || (I_mode == 8'b1111_1111)), // 1-bit clock enable input
       .D1(w_DACData_I), // 1-bit data input (positive edge)
       .D2(w_DACData_Q), // 1-bit data input (negative edge)
       .R((r_oddrsettings[3]) ? 12'b1 : 12'b0),   // 1-bit reset
       .S(12'b0)    // 1-bit set
    );
    
    
    
    OBUFDS OBUFDS_DACData1[11:0] (
    	.I(w_DACData1_toDIFF), 
    	.O(DACData1_P), 
    	.OB(DACData1_N)
    );
    
    
    // Unused BUT buffered for protection
    
    OBUFDS OBUFDS_DACData2[11:0] (
    	.I(w_DACData2_toDIFF), 
    	.O(DACData2_P), 
    	.OB(DACData2_N)
    );

    OBUFDS OBUFDS_DACData3[11:0] (
    	.I(w_10hz_clock), 
    	.O(DACData3_P), 
    	.OB(DACData3_N)
    );
    
    OBUFDS OBUFDS_DACData4[11:0] (
    	.I(w_10hz_clock), 
    	.O(DACData4_P), 
    	.OB(DACData4_N)
    );
        
    OBUFDS OBUFDS_DACData5[11:0] (
    	.I(w_10hz_clock), 
    	.O(DACData5_P), 
    	.OB(DACData5_N)
    );
    
    OBUFDS OBUFDS_DACData6[11:0] (
    	.I(w_adjustable_clock), 
    	.O(DACData6_P), 
    	.OB(DACData6_N)
    );
    
    OBUFDS OBUFDS_DACData7[11:0] (
    	.I(w_DACData7_toDIFF), 
    	.O(DACData7_P), 
    	.OB(DACData7_N)
    );
        
    OBUFDS OBUFDS_DACData8[11:0] (
    	.I(w_DACData8_toDIFF), 
    	.O(DACData8_P), 
    	.OB(DACData8_N)
    );
    
    
	/////////////// DAC update Clock Delay Modules ( to adjust disaligned DAC Clocks) //////////////////
	////////////////////////////////////////////////////////////////////////////////////////////////////
	/*
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value (round about 75 ps delay per step)
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK1 (
		.DATAOUT(w_DACCLKIQ_delayed[0]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK1[4:0]),
		.LD(r_delayValue_CLK1[5]),
		.ODATAIN(w_DACCLKIQ[0]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK2 (
		.DATAOUT(w_DACCLKIQ_delayed[1]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK2[4:0]),
		.LD(r_delayValue_CLK2[5]),
		.ODATAIN(w_DACCLKIQ[1]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK3 (
		.DATAOUT(w_DACCLKIQ_delayed[2]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK3[4:0]),
		.LD(r_delayValue_CLK3[5]),
		.ODATAIN(w_DACCLKIQ[2]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK4 (
		.DATAOUT(w_DACCLKIQ_delayed[3]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK4[4:0]),
		.LD(r_delayValue_CLK4[5]),
		.ODATAIN(w_DACCLKIQ[3]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK5 (
		.DATAOUT(w_DACCLKIQ_delayed[4]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK5[4:0]),
		.LD(r_delayValue_CLK5[5]),
		.ODATAIN(w_DACCLKIQ[4]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK6 (
		.DATAOUT(w_DACCLKIQ_delayed[5]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK6[4:0]),
		.LD(r_delayValue_CLK6[5]),
		.ODATAIN(w_DACCLKIQ[5]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK7 (
		.DATAOUT(w_DACCLKIQ_delayed[6]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK7[4:0]),
		.LD(r_delayValue_CLK7[5]),
		.ODATAIN(w_DACCLKIQ[6]),
		.REGRST(1'b0)
	);
	ODELAYE2 #(
		.DELAY_SRC("ODATAIN"),			// default
		.HIGH_PERFORMANCE_MODE("TRUE"), // reduced jitter
		.ODELAY_TYPE("VAR_LOAD"), 		// CNTVALUEIN determines the delay, LD = 1 sets a new value
		.SIGNAL_PATTERN("DATA")			// input type: data
	)	ODELAY2_DAC_CLK8 (
		.DATAOUT(w_DACCLKIQ_delayed[7]),
		.C(clk),
		.CE(1'b0),
		.CNTVALUEIN(r_delayValue_CLK8[4:0]),
		.LD(r_delayValue_CLK8[5]),
		.ODATAIN(w_DACCLKIQ[7]),
		.REGRST(1'b0)
	);
	*/
	
	// Danny: Needed for the ODELAY2 initialization


	IDELAYCTRL IDELAYCTRL_instance (
		.RST(1'b0),
		.REFCLK(clk)
	);

	

/*---------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------Modules----*/
/*---------------------------------------------------------------------------------------*/

	// UART Receiver
	uart_rcv rcv(
		.data_recv(w_uartrx),
		.dataRcv(USB_UART_TX),
		.clk(clk),
		.data_rdy(w_dataRdy),
		.rst(r_uartset[7]),
		.uart_cts(USB_UART_CTS)
	);
	
	// UART Transmitter
	uart_trx trx(
		.dataSend(w_datasend_rx),
		.dataToSend(r_uarttx),
		.clk(clk),
		.sendDataFlag(r_uartset[6]),
		.uart_rts(1'b0)		
	);
	
	OBUF UART_Buffer(
	   .I(w_datasend_rx),
	   .O(USB_UART_RX)    );
	
	// CRC8 check (can be deactivated for faster transmission rates)
	crc crc(
		.I_clk(clk),
		.I_newData(r_crcNewData),
		.I_rst(r_crcRst),
		.I_data(r_crcCheckInp),
		.O_crc8(w_crcResult),
		.O_rdy(w_crcRdy)
	);
	
	// SPI Connection to PLL
	realSPI PLL_SPI(
		.I_clk(clk),
		.I_regAdress(r_spiREGADDR),
		.I_newDataFlag(r_realspi[7]),
		.I_data({r_spiTXMSB, r_spiTXLSB}),
		.I_reset(r_realspi[6]),
		.I_MUXout(w_PLL_MISO),
		.I_actMOD(r_spiACTPLL),
		.O_SCK(w_PLL_SCK),
		.O_SDI(w_PLL_MOSI),
		.O_CSB(w_PLL_CSB)
		//.r_state(w_reg)
	);
	
	// SPI Connection to DAC
	realSPI DAC_SPI(
		.I_clk(clk),
		.I_regAdress(r_spiREGADDR),
		.I_newDataFlag(r_realspi[7]),
		.I_data({r_spiTXMSB, r_spiTXLSB}),
		.I_reset(r_realspi[6]),
		.I_MUXout(w_DAC_MISO),
		.I_actMOD(r_spiACTDAC),
		.O_SCK(w_DAC_SCLK),
		.O_SDI(w_DAC_MOSI),
		.O_CSB(w_DAC_CSB)
		//.r_state(w_reg)
	);
	
	
	// NEW (Danny): PLL SYMC Request
	
	pll_sync_rqst SYNCING(
	    .I_clk(clk),
		.I_pllSyncRequest(r_pll_sync[0]),
		.I_PLLSyncPulseShift(r_syncPulseShift),
		.O_PLL_sync(w_PLL_SYNC)
	);
	
	
	clock_10Hz tenhz_mod(
    .clk(clk),
    .ten_hertz(w_10hz_clock)

    );
	
	
	// New (Danny): adjustable clock (1kHz - 100kHz)
	
	clock_1khz_100khz adjustable_clock(
        .clk(clk),
        .divisor({r_dacActiveCore,r_dacWRTConfig}),  //actually only 10-bits needed to represent (1-1000)
        .clk_out(w_adjustable_clock)
    );
	
	// Signal generator
	
	signalgen_DDR signalgen(
		.I_clk(clk),
		.I_adjustable_clk(w_adjustable_clock),
		.O_DAC_I(w_DACData_I),
		.O_DAC_Q(w_DACData_Q),
		.O_SYNC(w_DAC_SYNC),
	
		// .I_speedDiv(r_dacCLOCK[7:0]),
		.I_pause(r_dacSet[6]),
		// .I_activeCore(r_dacActiveCore),
		.I_mode(r_dacMode),

		// .I_wrtNewDataFlag(r_dacWRTConfig[0]),
		// .I_channelIndex(r_dacWRTConfig[4:1]),
		
		.I_IQdataReady(r_dac_Q_msb[7]),


		.I_dataLength({r_dacDataLength_msb[3:0],r_dacDataLength_lsb}),		
		.I_Idata({r_dac_I_msb[3:0],r_dac_I_lsb}),
		.I_Qdata({r_dac_Q_msb[3:0],r_dac_Q_lsb}),
		
		.I_BB_Settings(r_BB_Settings)
		
		);
		
	
	/*
	signalgen signalgen(
		.I_clk(clk),
		.O_DAC_1(w_DACData_1),
		.O_DAC_2(w_DACData_2),
		.O_DAC_3(w_DACData_3),
		.O_DAC_4(w_DACData_4),
		.O_DAC_5(w_DACData_5),
		.O_DAC_6(w_DACData_6),
		.O_DAC_7(w_DACData_7),
		.O_DAC_8(w_DACData_8),
		
		.O_wrtIQ(w_DACWRTIQ),
		.O_clkIQ(w_DACCLKIQ),
		.O_selIQ(w_DACSELIQ),
		.O_resIQ(w_DACRESETIQ),
		
		.O_PLL_sync(w_PLL_SYNC),
		
		.I_speedDiv(r_dacCLOCK[7:0]),
		.I_pause(r_dacSet[6]),
		.I_activeCore(r_dacActiveCore),
		.I_mode(r_dacMode),
		
		// .I_wrtNewDataFlag(r_dacWRTConfig[0]),
		// .I_channelIndex(r_dacWRTConfig[4:1]),
		// .I_dataLength({r_dacDataLength_msb[3:0],r_dacDataLength_lsb}),
		.I_pllSyncRequest(r_pll_sync[0]),
		
		// .I_IQdataReady(r_dac_Q_msb[7]),
		// .I_Idata({r_dac_I_msb[1:0],r_dac_I_lsb}),
		// .I_Qdata({r_dac_Q_msb[1:0],r_dac_Q_lsb}),

		.I_PLLSyncPulseShift(r_syncPulseShift),
		.I_BB_Settings(r_BB_Settings),
		.I_DACData_CycleShift(r_dacSet[0])
	);
	*/
	

/*##############################################################################################*/
/*######################################  Main Programm  #######################################*/
/*##############################################################################################*/
	
	
	always @(posedge clk) begin
	/*--------------------------------------------------------------------------Reset Case-------*/
		if(r_reset) begin 	// when the reset state is initiated by the command over UART from the PC
			// Reset chip and components 
			if(r_resetCounter) begin  // Do, as long as r_resetCounter haven't reached zero. This way a Reset delay is implemented
				r_uartset[7] <= 1'b1; // reset uart receiver
				r_resetCounter <= r_resetCounter - 1;
				
				// Set all LEDs high during reset for debug
				r_ledval <= 8'hFF;
			end
			else begin
				// Reset all register to the initial values
				r_ledval 		<= 8'h00; 
				r_uarttx		<= 8'h00;
				r_uartset		<= 8'b0;
				r_regaddr		<= 8'b0;
				r_dacSet		<= 8'h00;
				r_dac_I_lsb		<= 8'h00;
				r_dac_I_msb		<= 8'h00;
				r_dac_Q_lsb		<= 8'h00;
				r_dac_Q_msb		<= 8'h00;
				r_dacCLOCK		<= 8'h08;
				r_realspi		<= 8'h00;
				r_spiTXMSB		<= 8'h00;
				r_spiTXLSB		<= 8'h00;
				r_spiREGADDR	<= 8'h00;
				r_spiRXMSB		<= 8'h00;
				r_spiRXLSB		<= 8'h00;
				r_dacDataLength_lsb	<= 8'hFF;
				r_dacDataLength_msb	<= 8'hFF;
				r_dacWRTConfig	<= 8'h00;
				r_dacActiveCore	<= 8'hFF;
				r_pll_sync		<= 8'h00;
				r_dacMode		<= 8'h00;
				r_syncPulseShift <= 8'h00;
				r_delayValue_CLK1	<= 8'h00;
				r_delayValue_CLK2	<= 8'h00;
				r_delayValue_CLK3	<= 8'h00;
				r_delayValue_CLK4	<= 8'h00;
				r_delayValue_CLK5	<= 8'h00;
				r_delayValue_CLK6	<= 8'h00;
				r_delayValue_CLK7	<= 8'h00;
				r_delayValue_CLK8	<= 8'h00;
				r_BB_Settings		<= 8'h00;
				r_dacconfig			<= 8'h01;	// New (Danny): Resetb is active low, else zero 
				r_reset <= 0;
			end
		end	
		
		/*-----------------------------------------------------------------------State Machine----*/
		r_uartrxFlag <= w_dataRdy; 	// with every clock cycle read the uart-data-ready 
		r_crcRdyFlag <= w_crcRdy;	// and the crc-ready flag in case something changed (they become 1 when true) 
		
		if(r_pll_sync[0])		// always reset the sync pulse register, to be able to create a new one
			r_pll_sync[0] <= 1'b0;
		if(r_dac_Q_msb[7]) // DAC data ready to save to memory flag should always be reset
			r_dac_Q_msb[7] <= 1'b0;
		if(r_dacSet[0])
			r_dacSet[0] <= 1'b0; // always reset the shift cycle register
		
		// Always reset the delay assign bits, if set to high.
		if(r_delayValue_CLK1[5])
			r_delayValue_CLK1[5] <= 1'b0;
		if(r_delayValue_CLK2[5])
			r_delayValue_CLK2[5] <= 1'b0;
		if(r_delayValue_CLK3[5])
			r_delayValue_CLK3[5] <= 1'b0;
		if(r_delayValue_CLK4[5])
			r_delayValue_CLK4[5] <= 1'b0;
		if(r_delayValue_CLK5[5])
			r_delayValue_CLK5[5] <= 1'b0;
		if(r_delayValue_CLK6[5])
			r_delayValue_CLK6[5] <= 1'b0;
		if(r_delayValue_CLK7[5])
			r_delayValue_CLK7[5] <= 1'b0;
		if(r_delayValue_CLK8[5])
			r_delayValue_CLK8[5] <= 1'b0;			
			
		case(r_state)

			/*--------------------------------------------------------------------IDLE-------------*/
			IDLE: begin
				if((r_uartrxFlag < w_dataRdy) && !r_reset) begin
					case(w_uartrx)
						WRTCODE: 	r_state <= REGADDR;
						READCODE: 	r_state <= IDLE; // not implemented yet
						RSTCODE: 	r_state <= RST;
					endcase
					// Always reset uart receiver!
					r_uartset[7] <= 1;
				end
			end
			
			/*--------------------------------------------------------------------RESET------------*/
			RST: begin
				r_state <= IDLE;
				r_reset <= 1'b1;
				r_resetCounter <= RESETTIME;
			end
			
			/*--------------------------------------------------------------------WRTREGADDR-------*/
			REGADDR: begin
				if((r_uartrxFlag < w_dataRdy) && !r_reset) begin
					r_regaddr <= w_uartrx;
					r_state <= REGVAL;
					r_uartset[7] <= 1;
				end
			end
			
			/*--------------------------------------------------------------------WRTREGVALUE------*/
			REGVAL: begin
				if((r_uartrxFlag < w_dataRdy) && !r_reset) begin
					r_tempRegVal <= w_uartrx;
					//r_state <= CALCCRC; // If CRC is needed uncomment this line and comment the next line
					r_state <= WRTREG; // This omits the CRC check, for faster transmission rates at UART
					r_ledval <= r_tempRegVal;
					r_uartset[7] <= 1;
				end
			end
			
			/*-------------------------------------------------------------------CALCCRC-----------*/
			CALCCRC: begin
				if((r_uartrxFlag < w_dataRdy) && !r_reset) begin
					// Set new data flag high
					r_crcNewData <= 1;
					r_crcCheckInp <= {WRTCODE, r_regaddr, r_tempRegVal, w_uartrx};
					r_ledval <= r_tempRegVal; // this causes the LEDs to show the register values in binary representation
					r_uartset[7] <= 1;
				end
				
				// wait until calculation is done
				if(r_crcRdyFlag < w_crcRdy) begin
					// Check if resulting values are 0 and send the result to the pc
					r_uarttx <= !w_crcResult ? 8'b00010001 : 8'b10111011; // Different codes for positive or negative CRC check.
					r_state <=  !w_crcResult ? WRTREG : IDLE; // when the CRC is correct, just write. Else go back to IDLE.
					r_uartset[6] <= 1'b1; // UART to transmit mode
					r_crcRst <= 1;	// reset CRC
				end
			end
			
			WRTREG: begin
				case(r_regaddr)
					LED: 			r_ledval 		<= r_tempRegVal;
					UARTSET: 		r_uartset[6:0] 	<= r_tempRegVal[6:0];
					DACSET: 		r_dacSet 		<= r_tempRegVal;
					DAC_I_LSB: 		r_dac_I_lsb 	<= r_tempRegVal;
					DAC_I_MSB: 		r_dac_I_msb 	<= r_tempRegVal;
					DAC_Q_LSB: 		r_dac_Q_lsb 	<= r_tempRegVal;
					DAC_Q_MSB: 		r_dac_Q_msb 	<= r_tempRegVal;
					DACCLOCK:		r_dacCLOCK 		<= r_tempRegVal;
					
					REALSPI:		r_realspi		<= r_tempRegVal;
					SPITXMSB:		r_spiTXMSB		<= r_tempRegVal;
					SPITXLSB:		r_spiTXLSB		<= r_tempRegVal;
					SPIREGADDR:		r_spiREGADDR	<= r_tempRegVal;	
					SPIRXMSB:		r_spiRXMSB		<= r_tempRegVal;
					SPIRXLSB:		r_spiRXLSB		<= r_tempRegVal;
					SPIACTPLL:		r_spiACTPLL		<= r_tempRegVal;
					SPIACTDAC:		r_spiACTDAC		<= r_tempRegVal;
					
					DACDATALENGTH_LSB: 	r_dacDataLength_lsb <= r_tempRegVal;
					DACDATALENGTH_MSB: 	r_dacDataLength_msb <= r_tempRegVal;
					DACWRTCONFIG:	r_dacWRTConfig	<= r_tempRegVal;
					DACACTIVECORE: 	r_dacActiveCore <= r_tempRegVal;
					DAC_MODE:		r_dacMode		<= r_tempRegVal;
					DAC_CONFIG:		r_dacconfig		<= r_tempRegVal;
					ODDR_Settings:	r_oddrsettings	<= r_tempRegVal;
					
					PLLSYNC: 		r_pll_sync		<= r_tempRegVal;
					PLLSYNCPULSESHIFT: 		r_syncPulseShift		<= r_tempRegVal;
					
					CLKDELAY_CLK1:		r_delayValue_CLK1	<= r_tempRegVal;
					CLKDELAY_CLK2:		r_delayValue_CLK2	<= r_tempRegVal;
					CLKDELAY_CLK3:		r_delayValue_CLK3	<= r_tempRegVal;
					CLKDELAY_CLK4:		r_delayValue_CLK4	<= r_tempRegVal;
					CLKDELAY_CLK5:		r_delayValue_CLK5	<= r_tempRegVal;
					CLKDELAY_CLK6:		r_delayValue_CLK6	<= r_tempRegVal;
					CLKDELAY_CLK7:		r_delayValue_CLK7	<= r_tempRegVal;
					CLKDELAY_CLK8:		r_delayValue_CLK8	<= r_tempRegVal;
					
					BB_SETTINGS:		r_BB_Settings <= r_tempRegVal;
				endcase
				r_state <= IDLE;
			end
		endcase	
		
		
		
		
		// reset flags in every cycle when they are set
		if(r_uartset[7]) 	r_uartset[7] 	<= 1'b0;
		if(r_uartset[6]) 	r_uartset[6] 	<= 1'b0;
		if(r_crcNewData) 	r_crcNewData 	<= 1'b0;
		if(r_crcRst) 		r_crcRst 		<= 1'b0;
		if(r_realspi[7]) begin 
			//DEBUG
			r_realspi[7]	<= 1'b0;
		end
		
		if(r_realspi[6]) 	r_realspi[6]	<= 1'b0;
	end
	
	
	
	/*----------------------------------------------------------------------------------------*/
	/*-------------------------------------------------------------------------Assignments----*/
	/*----------------------------------------------------------------------------------------*/
	
	assign GPIO_LED = r_ledval;	// Light the LEDs
	
	
	// Assign DAC_CONFIG: Bit0 -> Resetb, Bit1 -> Alarm, Bit2 -> Ex_ENA, Bit3 -> Sleep
	assign 		w_RESETB 		= r_dacconfig[0];
	assign 		w_TXENABLE 	= r_dacconfig[2];
	assign		w_SLEEP		= r_dacconfig[3];
		
	
	//assign w_DAout_0_neg = ~w_DAout_0;
	//assign w_DBout_0_neg = ~w_DBout_0;
	//assign w_DAout_1_neg = ~w_DAout_1;
	//assign w_DBout_1_neg = ~w_DBout_1;
		
		
endmodule
