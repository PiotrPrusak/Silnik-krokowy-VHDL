SetActiveLib -work
comp -include "$dsn\src\Manual.vhd" 
comp -include "$dsn\src\TestBench\manual_TB.vhd" 
asim +access +r TESTBENCH_FOR_manual 
wave 
wave -noreg CLK
wave -noreg CE
wave -noreg CE7SEG
wave -noreg START
wave -noreg AM
wave -noreg NUM1
wave -noreg NUM2
wave -noreg ANODES
wave -noreg CATHODES  	   
wave -noreg CEOUT
run 5500ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\manual_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_manual 
