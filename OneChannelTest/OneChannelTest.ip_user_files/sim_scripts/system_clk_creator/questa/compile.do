vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../ipstatic" \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93  \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../ipstatic" \
"../../../../OneChannelTest.gen/sources_1/ip/system_clk_creator/system_clk_creator_clk_wiz.v" \
"../../../../OneChannelTest.gen/sources_1/ip/system_clk_creator/system_clk_creator.v" \

vlog -work xil_defaultlib \
"glbl.v"

