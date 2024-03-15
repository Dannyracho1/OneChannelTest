// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
// Date        : Fri Mar 15 16:13:37 2024
// Host        : eddard.hfe.rwth-aachen.de running 64-bit Rocky Linux release 8.8 (Green Obsidian)
// Command     : write_verilog -force -mode synth_stub
//               /home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.gen/sources_1/ip/system_clk_creator/system_clk_creator_stub.v
// Design      : system_clk_creator
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module system_clk_creator(CLK_OUT1, CLK_IN1)
/* synthesis syn_black_box black_box_pad_pin="CLK_IN1" */
/* synthesis syn_force_seq_prim="CLK_OUT1" */;
  output CLK_OUT1 /* synthesis syn_isclock = 1 */;
  input CLK_IN1;
endmodule
