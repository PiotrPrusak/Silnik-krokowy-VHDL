SetActiveLib -work
comp -include "$dsn\compile\Top.vhd" 
comp -include "$dsn\src\TestBench\top_TB.vhd" 
asim +access +r TESTBENCH_FOR_top 
wave 
wave -noreg AM
wave -noreg CE
wave -noreg CLK
wave -noreg DIR
wave -noreg RESET
wave -noreg START
wave -noreg DIV
wave -noreg NUM1
wave -noreg NUM2
wave -noreg ANODES
wave -noreg CATHODES
wave -noreg O		
run 6000ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\top_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_top 
