vlib test
vmap work test
vlog mixColumns_InvmixColumns.sv -lint 
vlog tb.sv -lint

vsim work.tb
vsim -voptargs=+acc work.tb

run -all