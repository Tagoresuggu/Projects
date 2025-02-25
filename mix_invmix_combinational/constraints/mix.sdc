#create_clock -name "CLK" -period 0.500 -waveform {0.0 0.250} clk

#set_clock_uncertainty -setup 0.07 CLK
#set_clock_uncertainty -hold 0.01 CLK
#set_clock_transition 0.100 CLK
#set_clock_latency 0.100 CLK

#set_input_delay 0.25 [ get_ports [all_inputs] ] -clock [ get_clock CLK ]
#set_output_delay 0.25 [get_ports [all_outputs] ] -clock [ get_clock  CLK ]

set_max_delay 0.54 -from [all_inputs] -to [all_outputs]

set_drive 0.00001 [all_inputs]
set_input_transition 0.1 [all_inputs]

set_load 0.5 [all_outputs]

group_path -name INPUTS -from [get_ports -filter "direction == in"]
group_path -name OUTPUTS -to [get_ports -filter "direction == out"]
