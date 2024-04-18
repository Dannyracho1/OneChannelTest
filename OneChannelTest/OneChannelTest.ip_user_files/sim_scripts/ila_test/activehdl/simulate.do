transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_test  -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.ila_test xil_defaultlib.glbl

do {ila_test.udo}

run

endsim

quit -force
