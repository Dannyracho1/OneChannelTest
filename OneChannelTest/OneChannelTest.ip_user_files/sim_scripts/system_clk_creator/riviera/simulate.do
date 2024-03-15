transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+system_clk_creator  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.system_clk_creator xil_defaultlib.glbl

do {system_clk_creator.udo}

run 1000ns

endsim

quit -force
