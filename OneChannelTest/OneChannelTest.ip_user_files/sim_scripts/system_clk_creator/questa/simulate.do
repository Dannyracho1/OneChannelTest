onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib system_clk_creator_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {system_clk_creator.udo}

run 1000ns

quit -force
