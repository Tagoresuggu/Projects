# Cadence Genus(TM) Synthesis Solution, Version 23.10-p004_1, built Feb  1 2024 13:43:46

# Date: Sat Jan 25 11:23:57 2025
# Host: mo.ece.pdx.edu (x86_64 w/Linux 3.10.0-1160.119.1.el7.x86_64) (1core*32cpus*32physical cpus*Intel Xeon Processor (Cascadelake) 16384KB)
# OS:   CentOS Linux release 7.9.2009 (Core)

set top_design adder_64bit
source ../scripts/genus-adder_64bit.tcl
report_timing
report_timing -unconstrained
report_timing -constrained
report_timing -unconstrained
check_timing
