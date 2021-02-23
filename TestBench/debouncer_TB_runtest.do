SetActiveLib -work
comp -include "$dsn\src\Debouncer.vhd" 
comp -include "$dsn\src\TestBench\debouncer_TB.vhd" 
asim +access +r TESTBENCH_FOR_debouncer 
wave 
wave -noreg CLK
wave -noreg START
wave -noreg STARTO
run 500ns
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\debouncer_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_debouncer 
