onerror {quit -f}
vlib work
vlog -work work ComputadorIAS.vo
vlog -work work ComputadorIAS.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.ControlUnit_vlg_vec_tst
vcd file -direction ComputadorIAS.msim.vcd
vcd add -internal ControlUnit_vlg_vec_tst/*
vcd add -internal ControlUnit_vlg_vec_tst/i1/*
add wave /*
run -all
