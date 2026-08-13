# Leitura e elaboracao do RTL sintetizavel.
set_app_var hdlin_enable_hier_map true
set_app_var verilogout_show_unconnected_pins true

# A pasta utils nao entra porque contem modelo de simulacao.
set RTL_FILES [list]
foreach RTL_DIR [list \
    [file join $SOURCE_DIR core] \
    [file join $SOURCE_DIR interconnect] \
    [file join $SOURCE_DIR memory] \
    [file join $SOURCE_DIR peripherals] \
    $SOURCE_DIR] {
    set RTL_FILES [concat $RTL_FILES \
        [glob -nocomplain -directory $RTL_DIR *.v]]
}
set RTL_FILES [lsort -unique $RTL_FILES]

if {[llength $RTL_FILES] == 0} {
    error "Nenhum RTL encontrado em $SOURCE_DIR"
}

analyze \
    -format verilog \
    -vcs "+incdir+$SOURCE_DIR" \
    $RTL_FILES

elaborate $TOP_MODULE
set_top_module $TOP_MODULE

set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8 MRDL}] routing_direction vertical
set_ignored_layers -max_routing_layer M9

redirect -tee -file [file join $REPORT_ROOT read_rtl_ref_libs.rpt] {
    report_ref_libs
}
redirect -tee -file [file join $REPORT_ROOT read_rtl_mismatch.rpt] {
    report_design_mismatch -verbose
}

save_lib
puts "RTL CARREGADO: $TOP_MODULE"