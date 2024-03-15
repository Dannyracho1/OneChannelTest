-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
-- Date        : Fri Mar 15 16:13:37 2024
-- Host        : eddard.hfe.rwth-aachen.de running 64-bit Rocky Linux release 8.8 (Green Obsidian)
-- Command     : write_vhdl -force -mode synth_stub
--               /home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.gen/sources_1/ip/system_clk_creator/system_clk_creator_stub.vhdl
-- Design      : system_clk_creator
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1761-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_clk_creator is
  Port ( 
    CLK_OUT1 : out STD_LOGIC;
    CLK_IN1 : in STD_LOGIC
  );

end system_clk_creator;

architecture stub of system_clk_creator is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK_OUT1,CLK_IN1";
begin
end;
