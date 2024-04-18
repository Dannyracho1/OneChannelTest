vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../../OneChannelTest.gen/sources_1/ip/ila_test/hdl/verilog" \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -64 -93  \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../OneChannelTest.gen/sources_1/ip/ila_test/hdl/verilog" \
"../../../../OneChannelTest.gen/sources_1/ip/ila_test/sim/ila_test.v" \


vlog -work xil_defaultlib \
"glbl.v"

