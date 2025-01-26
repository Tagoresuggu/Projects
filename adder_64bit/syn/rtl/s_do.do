vlog serial_adder.sv
vlog test_tb.sv
vsim work.tb
vsim  -voptargs=+acc work.tb
add wave sim:/tb/dut.*
add wave sim:/tb/*
run -all