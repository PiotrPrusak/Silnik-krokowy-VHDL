SetActiveLib -work
comp -include "$dsn\src\Silnik.vhd" 
comp -include "$dsn\src\TestBench\silnik_TB.vhd" 
asim +access +r TESTBENCH_FOR_silnik 
wave 
wave -noreg CLK
wave -noreg CE	 
wave -noreg RESET
wave -noreg DIR
wave -noreg O 
run 1500ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\silnik_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_silnik 
