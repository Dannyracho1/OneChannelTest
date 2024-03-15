// High precesion for the 200MHz
`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
/// Company: RWTH Aachen - Lehrstuhl für Hoechstfrequenztechnik
// Engineer: Danny Racho
// 
// Create Date: 03/10/2024 06:52:31 PM
// Design Name: 
// Module Name: main_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_tb();


reg SYSCLK_P;
reg SYSCLK_N;

// LEDs on the VC707_FPGA Board itself
wire 	[7:0] GPIO_LED;		// LED0..7

// PC Control
reg 		USB_UART_TX;		// Data from the PC
wire 		USB_UART_RX;		// Data to the PC
wire 		USB_UART_CTS;		// Indicates the UART IC, if it can accepted data from the PC	

// Signals to DAC on PCB

wire [11:0]	DACData1_P;			// DAC data from CH1 positive
wire [11:0]	DACData1_N;			// DAC data from CH1 negative
wire [11:0]	DACData2_P;			// ...
wire [11:0]	DACData2_N;			// ...
wire [11:0]	DACData3_P;			// ...
wire [11:0]	DACData3_N;			// ...
wire [11:0]	DACData4_P;			// ...
wire [11:0]	DACData4_N;			// ...
wire [11:0]	DACData5_P;			// ...
wire [11:0]	DACData5_N;			// ...
wire [11:0]	DACData6_P;			// ...
wire [11:0]	DACData6_N;			// ...
wire [11:0]	DACData7_P;			// ...
wire [11:0]	DACData7_N;			// ...
wire [11:0]	DACData8_P;			// ...
wire [11:0]	DACData8_N;			// ...

// DAC Global Clocks (critical: low-jitter prefered)

wire [7:0] 	DACCLK_P;			// DAC Clocks positive
wire [7:0] 	DACCLK_N;			// DAC Clocks negative

// DAC Data Clocks (less critical than DACCLK_P/N)

wire [7:0] 	DATACLK_P;			// DAC DATA Clock  positive
wire [7:0] 	DATACLK_N;			// DAC DATA Clock negative

// DAC SYNC Signal

wire SYNC_P;
wire SYNC_N;

// PLL SPI Signals
wire			PLL_MOSI;
reg			    PLL_MISO;
wire			PLL_SCK;
wire [7:0]	    PLL_CSB; // 8 Latch-Pins for 8 PLLs

// PLL SPI Signals
wire			DAC_MOSI;
reg			    DAC_MISO;
wire			DAC_SCLK;

wire [7:0]  	DAC_CSB; // 8 Latch-Pins for 8 DACs

// DAC_CONFIG Pins: Bit0 -> Resetb, Bit1 -> Alarm, Bit2 -> Ex_ENA, Bit3 -> Sleep
reg 			ALARM;		// Not set yet
wire 			RESETB;
wire			TXENABLE;
wire 			SLEEP;

wire 			PLL_SYNC; // When used, PLL readback through SPI_MISO isn't available

main DUT (

    // Systemclock 200MHz - will be connected to a buffer with single ended output "clk"
    .SYSCLK_P(SYSCLK_P),
    .SYSCLK_N(SYSCLK_N),

    // LEDs on the VC707_FPGA Board itself
    .GPIO_LED(GPIO_LED),

    // PC Control
    .USB_UART_RX(USB_UART_RX),
    .USB_UART_TX(USB_UART_TX),
    .USB_UART_CTS(USB_UART_CTS),	

    // Signals to DAC on PCB

    .DACData1_P(DACData1_P),
    .DACData1_N(DACData1_N),
    .DACData2_P(DACData2_P),
    .DACData2_N(DACData2_N),
    .DACData3_P(DACData3_P),
    .DACData3_N(DACData3_N),
    .DACData4_P(DACData4_P),
    .DACData4_N(DACData4_N),
    .DACData5_P(DACData5_P),
    .DACData5_N(DACData5_N),
    .DACData6_P(DACData6_P),
    .DACData6_N(DACData6_N),
    .DACData7_P(DACData7_P),
    .DACData7_N(DACData7_N),
    .DACData8_P(DACData8_P),
    .DACData8_N(DACData8_N),

    .DACCLK_P(DACCLK_P),
    .DACCLK_N(DACCLK_N),

    .DATACLK_P(DATACLK_P),
    .DATACLK_N(DATACLK_N),

    .SYNC_P(SYNC_P),
    .SYNC_N(SYNC_N),

    .PLL_MOSI(PLL_MOSI),
    .PLL_MISO(PLL_MISO),
    .PLL_SCK(PLL_SCK),
    .PLL_CSB(PLL_CSB),

    .DAC_MOSI(DAC_MOSI),
    .DAC_MISO(DAC_MISO),
    .DAC_SCLK(DAC_SCLK),

    .DAC_CSB(DAC_CSB),

    .ALARM(ALARM),
    .RESETB(RESETB),
    .TXENABLE(TXENABLE),
    .SLEEP(SLEEP),

    .PLL_SYNC(PLL_SYNC)
);


// 200 MHz master clock
reg w_clk;

reg [15:0]  divisor = 16'd10;    // 10kHz clock divider
wire        w_adjustable_clock;


clock_1khz_100khz adj_10khz_tb(
    .clk(w_clk),
    .divisor(divisor),
    .clk_out(w_adjustable_clock)
);


wire [11:0] O_DAC_I;
wire [11:0] O_DAC_Q;

reg         I_pause;
reg [7:0]   I_mode;
reg [11:0]  I_dataLength;
reg [11:0]  I_Idata;
reg [11:0]  I_Qdata;


reg [7:0]   I_BB_Settings;
reg         I_IQdataReady;



signalgen_DDR signal_tb(
    .I_clk(w_clk),			   // Main clk 200MHz
    .I_adjustable_clk(w_adjustable_clock),  // Trying to slow down data rate

    .O_DAC_I(O_DAC_I),		// DAC Data Output CHA --> 12-bits
    .O_DAC_Q(O_DAC_Q),		// DAC Data Output CHB --> 12-bits

    .I_pause(I_pause),

    .I_mode(I_mode),
    .I_dataLength(I_dataLength),
    .I_Idata(I_Idata),
    .I_Qdata(I_Qdata),

    // Data are ready to be written to RAM
    .I_IQdataReady(I_IQdataReady),	
    .I_BB_Settings(I_BB_Settings)
);


always
    begin
        w_clk = 1'b0;
        forever
        begin
            // single-ended clock
            #2.5 w_clk  = ~w_clk;
            // differential clock
            SYSCLK_P    =  w_clk;
            SYSCLK_N    = ~w_clk;
        end
    end




initial
    begin
        // Set I_pause, I_mode, I_dataLength, I_Idata, I_Qdata, I_BB_Settings, I_IQdataReady
        #100 I_pause        = 1'b0; // Stop the Convertion if I_pause is set
        I_mode = 8'd0;  // FSM 0 is default (MATLAB: pause stream)
        I_dataLength[11:0]  =   12'd1;
        I_Idata[11:0]       =   12'b00_0000_0001;   // random I data --> 1
        I_Qdata[11:0]       =   12'b00_0000_0010;   // random Q data --> 2
        I_BB_Settings[7:0]  =   8'd0;               // No settings here
        I_IQdataReady       =   1'b0;               // Data not ready
		// ready_flag			=	1'b0;				// Ready flag (to be tested)
		divisor = 100; // 100 kHz

    end
/*
initial
    begin
        // Set I_pause, I_mode, I_dataLength, I_Idata, I_Qdata, I_BB_Settings, I_IQdataReady
        #100 I_pause        = 1'b0; // Stop the Convertion if I_pause is set
        I_mode = 8'd0;  // FSM 0 is default (MATLAB: pause stream)
        I_dataLength[11:0]  =   12'd1;
        I_Idata[11:0]       =   12'b10_1111_0000;   // random I data
        I_Qdata[11:0]       =   12'b10_1111_0000;   // random Q data
        I_BB_Settings[7:0]  =   8'd0;               // No settings here
        I_IQdataReady       =   1'b0;               // Data not ready
    end
*/
/*
initial
    begin
        #1000 I_mode  = 8'd2; // FSM 2 is SET_IQ_DATA (MATLAB: Overwrite memory)
        I_IQdataReady = 1'b1; // Data ready

        #100000000 $stop;
    end
*/


initial
    begin
        #10000 
		I_mode  = 8'b0000_0010;	// FSM 2 is SET_IQ_DATA (MATLAB: Overwrite memory)
        I_IQdataReady = 1'b1;	// Data ready


		// Just increment by 1 and add new entries to RAM memory
		#10000
		I_IQdataReady = 1'b1;	// Data ready
		I_Idata[11:0]       =   12'b00_0000_0010;	// I data --> 2
		I_Qdata[11:0]       =   12'b00_0000_0011;	// Q data --> 3
		I_dataLength = I_dataLength + 12'd1;
		
		#1000
		I_IQdataReady = 1'b0;	// Data NOT ready
		
		#10000
		I_IQdataReady = 1'b1;	// Data ready
		I_Idata[11:0]       =   12'b00_0000_0011;	// I data --> 3
		I_Qdata[11:0]       =   12'b00_0000_0100;	// Q data --> 4
		I_dataLength = I_dataLength + 12'd1;
		
		#1000
		I_IQdataReady = 1'b0;	// Data NOT ready
		
		#10000
		I_IQdataReady = 1'b1;	// Data ready
		I_Idata[11:0]       =   12'b00_0000_0100;	// I data --> 4
		I_Qdata[11:0]       =   12'b00_0000_0101;	// Q data --> 5
		I_dataLength = I_dataLength + 12'd1;
		
		#1000
		I_IQdataReady = 1'b0;	// Data NOT ready
		
		
		// Check if memory still gets written in another mode
		#10000
		I_mode  = 8'd0;	// FSM 0 is default
		I_IQdataReady = 1'b1;	// Data ready
		I_Idata[11:0]       =   12'b00_1000_0000;	// I data --> NOT IN THE SAME SEQ
		I_Qdata[11:0]       =   12'b00_1000_0000;	// Q data --> NOT IN THE SAME SEQ
		I_dataLength = I_dataLength + 12'd1;		// Check what happens to length
		
		// Check if memory still gets written in IQData Not Ready!
		#10000
		I_mode  = 8'd2;	// Back to FSM 2 SET_IQ_DATA (Overwrite RAM)
		I_IQdataReady = 1'b0;	// Data not ready
		I_Idata[11:0]       =   12'b00_1111_0000;	// I data --> NOT IN THE SAME SEQ
		I_Qdata[11:0]       =   12'b00_1111_0000;	// Q data --> NOT IN THE SAME SEQ
		I_dataLength = I_dataLength + 12'd1;		// Check what happens to length
		
		
		
		
		#10000 I_mode = 8'd1;	// FSM 1 is NORMAL_OUTPUT (MATLAB: Stream)
		
		// DATA SHOULD LOOP HERE
		// LENGTH ACCORDING TO I_dataLength
		


        #1000000 $stop;
    end
    

endmodule
