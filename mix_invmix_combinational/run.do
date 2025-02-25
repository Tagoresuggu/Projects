vlib test
vmap work test
vlog mixColumns_InvmixColumns.sv -lint 
vlog mixColumns_InvmixColumns_tb.sv -lint

vsim work.mixColumns_InvmixColumns_tb
vsim -voptargs=+acc work.mixColumns_InvmixColumns_tb

run -all