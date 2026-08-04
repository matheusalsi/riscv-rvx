# Design Constraints
set CLK_PORT             clock
set CLOCK_PERIOD         30
set CLOCK_UNCERTAINTY_SETUP 1
set CLOCK_LATENCY        1
set CLOCK_TRANSITION     0.2
set INPUT_DELAY          0.1
set OUTPUT_DELAY         0.1
set OUTPUT_LOAD          10
set INPUT_TRANSITION     0.2

# BestCase & WorstCase Library Setup - SAED32
set OC_MAX     ss0p75v125c
set OC_MAX_LIB saed32rvt_ss0p75v125c
set OC_MIN     ff0p95v25c
set OC_MIN_LIB saed32rvt_ff0p95v25c

# Apply Constraints
set ALL_IN_BUT_CLK  [remove_from_collection [all_inputs]  [get_ports $CLK_PORT]]
set ALL_OUT         [all_outputs]

create_clock -period $CLOCK_PERIOD -name MY_CLK [get_ports $CLK_PORT]
set_clock_uncertainty -setup $CLOCK_UNCERTAINTY_SETUP [get_clocks MY_CLK]
set_clock_latency    $CLOCK_LATENCY   [get_clocks MY_CLK]
set_clock_transition $CLOCK_TRANSITION [get_clocks MY_CLK]

set_input_delay  $INPUT_DELAY  -clock MY_CLK $ALL_IN_BUT_CLK
set_output_delay $OUTPUT_DELAY -clock MY_CLK $ALL_OUT

set_load             $OUTPUT_LOAD  $ALL_OUT
set_input_transition $INPUT_TRANSITION $ALL_IN_BUT_CLK

# for pad cells
set_dont_touch [get_cells PAD_*]
set_dont_touch [get_cells CORNER*]
set_dont_touch [get_cells {VDD_* VSS_* IOVDD_* IOVSS_*}]

# Operating conditions
set_operating_conditions \
    -max $OC_MAX -max_lib $OC_MAX_LIB \
    -min $OC_MIN -min_lib $OC_MIN_LIB
