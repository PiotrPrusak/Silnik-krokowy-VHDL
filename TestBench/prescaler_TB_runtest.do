SetActiveLib -work
comp -include "$dsn\src\Prescaler.vhd" 
comp -include "$dsn\src\TestBench\prescaler_TB.vhd" 
asim +access +r TESTBENCH_FOR_prescaler 
wave 
wave -noreg CLK
wave -noreg CE
wave -noreg DIV
wave -noreg CEO
wave -noreg CEO7SEG
run 1.00 us
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\prescaler_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_prescaler 
