vlib work
vlog Intel8088Pins.sv +acc -lint -source
vlog MemoryIO.sv +acc -lint -source
#vlog Intel8088_assertions.sv +acc -lint -source
vlog top.sv +acc -lint -source
vlog 8088if.svp +acc -lint -source

vsim -c top
add wave -r *
run -all



