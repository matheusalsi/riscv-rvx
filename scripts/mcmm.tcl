# MCMM: SS para setup e FF para hold.
create_mode functional

create_corner corner_ss
current_corner corner_ss

set_operating_conditions ss0p95v125c
set_process_number 0.99 -corner corner_ss

set_voltage 0.95 -object_list VDD   -corner corner_ss
set_voltage 0.00 -object_list VSS   -corner corner_ss
set_voltage 2.25 -object_list VDDIO -corner corner_ss
set_voltage 0.00 -object_list VSSIO -corner corner_ss
set_temperature 125 -corner corner_ss

set_parasitic_parameters \
    -corner corner_ss \
    -early_spec maxTLU \
    -late_spec maxTLU

create_corner corner_ff
current_corner corner_ff

set_operating_conditions ff1p16vn40c
set_process_number 1.01 -corner corner_ff

set_voltage 1.16 -object_list VDD   -corner corner_ff
set_voltage 0.00 -object_list VSS   -corner corner_ff
set_voltage 2.75 -object_list VDDIO -corner corner_ff
set_voltage 0.00 -object_list VSSIO -corner corner_ff
set_temperature -40 -corner corner_ff

set_parasitic_parameters \
    -corner corner_ff \
    -early_spec minTLU \
    -late_spec minTLU

create_scenario \
    -name functional_ss \
    -mode functional \
    -corner corner_ss

create_scenario \
    -name functional_ff \
    -mode functional \
    -corner corner_ff

set_scenario_status functional_ss \
    -setup true \
    -hold false \
    -leakage_power true \
    -dynamic_power true

set_scenario_status functional_ff \
    -setup false \
    -hold true \
    -leakage_power true \
    -dynamic_power true

# Os dois scenarios compartilham o modo functional. As constraints sao
# carregadas uma unica vez e passam a valer para ambos.
current_scenario functional_ss
source -echo [file join $SCRIPT_DIR constraints.tcl]

report_modes
report_corners
report_scenarios

redirect -tee -file [file join $REPORT_ROOT pvt.rpt] {
    report_pvt
}

current_scenario functional_ss
