vlib test
vmap work test
vlog mixed_column_block.sv -lint 
vlog test_bench_mixed_column_block.sv -lint

vsim work.test_bench_mixed_column_block
vsim -voptargs=+acc work.test_bench_mixed_column_block

run -all

