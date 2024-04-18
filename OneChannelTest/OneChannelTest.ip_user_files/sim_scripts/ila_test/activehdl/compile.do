transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xpm
vlib activehdl/xil_defaultlib

vmap xpm activehdl/xpm
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xpm  -sv2k12 "+incdir+../../../../OneChannelTest.gen/sources_1/ip/ila_test/hdl/verilog" -l xpm -l xil_defaultlib \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -  \
"/software/Xilinx/Vitis_2023.2/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../OneChannelTest.gen/sources_1/ip/ila_test/hdl/verilog" -l xpm -l xil_defaultlib \
"../../../../OneChannelTest.gen/sources_1/ip/ila_test/sim/ila_test.v" \


vlog -work xil_defaultlib \
"glbl.v"

