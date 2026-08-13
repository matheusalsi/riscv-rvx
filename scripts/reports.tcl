# Reports e arquivos da Entrega 2.
set NETLIST_FILE [file join $OUTPUT_ROOT rvx_mapped.v]
set SDC_FILE     [file join $OUTPUT_ROOT rvx_entrega2.sdc]

current_scenario functional_ss
write_verilog $NETLIST_FILE
write_sdc -output $SDC_FILE

redirect -tee -file [file join $REPORT_ROOT area.rpt] {
    report_area
}
redirect -tee -file [file join $REPORT_ROOT utilization.rpt] {
    report_utilization
}
redirect -tee -file [file join $REPORT_ROOT qor.rpt] {
    report_qor
}

current_scenario functional_ss
redirect -tee -file [file join $REPORT_ROOT timing_setup_ss.rpt] {
    report_timing -delay_type max -max_paths 10
}
redirect -tee -file [file join $REPORT_ROOT constraints_violators.rpt] {
    report_constraints -all_violators
}

current_scenario functional_ff
redirect -tee -file [file join $REPORT_ROOT timing_hold_ff.rpt] {
    report_timing -delay_type min -max_paths 10
}

redirect -tee -file [file join $REPORT_ROOT check_timing.rpt] {
    current_scenario functional_ss
    check_timing
    current_scenario functional_ff
    check_timing
}

redirect -tee -file [file join $REPORT_ROOT check_io_placement_final.rpt] {
    check_io_placement -overlap all
    check_io_placement -gap
    check_io_placement -signal_constraints
}

redirect -tee -file [file join $REPORT_ROOT mcmm.rpt] {
    report_modes
    report_corners
    report_scenarios
}

redirect -tee -file [file join $REPORT_ROOT pvt.rpt] {
    report_pvt
}

current_scenario functional_ss
puts "RELATORIOS GERADOS: $REPORT_ROOT"
puts "NETLIST GERADA: $NETLIST_FILE"
puts "SDC GERADO: $SDC_FILE"