# Fluxo completo da Entrega 3: RTL ate route_opt.
set SCRIPT_DIR [file dirname [file normalize [info script]]]

foreach SCRIPT {
    setup.tcl tech_setup.tcl read_rtl.tcl power_setup.tcl
    mcmm.tcl floorplan.tcl auto_iopad.tcl
} {
    source -echo [file join $SCRIPT_DIR $SCRIPT]
}

proc salvar_checkpoint {NOME} {
    save_block -as $NOME
    save_lib
}

proc reportar {ARQUIVO COMANDO} {
    global REPORT_ROOT
    redirect -tee -file [file join $REPORT_ROOT $ARQUIVO] $COMANDO
}

# Floorplan.
salvar_checkpoint entrega2_floorplan

# Celulas e regras de roteamento do CTS.
set CTS_CELLS [get_lib_cells -quiet {
    */NBUFF*RVT */INVX*_RVT */CG*RVT */AOINV* */*DFF*
}]

if {[sizeof_collection $CTS_CELLS] == 0} {
    error "Nenhuma celula valida para CTS foi encontrada."
}

set_dont_touch $CTS_CELLS false
suppress_message ATTR-12
set_lib_cell_purpose -exclude cts [get_lib_cells]
set_lib_cell_purpose -include cts $CTS_CELLS
unsuppress_message ATTR-12

create_routing_rule cts_w2_s2_vlg \
    -default_reference_rule \
    -widths {M1 0.10 M2 0.11 M3 0.11 M4 0.11 M5 0.11} \
    -spacings {M2 0.16 M3 0.45 M4 0.45 M5 1.10} \
    -taper_distance 0.4 \
    -driver_taper_distance 0.4 \
    -cuts {{VIA1 {V1LG 1}} {VIA2 {V2LG 1}} {VIA3 {V3LG 1}} \
           {VIA4 {V4LG 1}} {VIA5 {V5LG 1}}}

create_routing_rule cts_w1_s2 \
    -default_reference_rule \
    -spacings {M2 0.16 M3 0.45 M4 0.45 M5 1.10}

set_clock_routing_rules -rules cts_w2_s2_vlg \
    -min_routing_layer M4 -max_routing_layer M5
set_clock_routing_rules -net_type sink -rules cts_w1_s2 \
    -min_routing_layer M1 -max_routing_layer M5

foreach_in_collection SCENARIO [all_scenarios] {
    current_scenario $SCENARIO
    set_driving_cell -lib_cell NBUFFX16_RVT [get_ports clock]
}

# Sintese fisica e placement.
current_scenario functional_ss
set_ungroup * false
compile_fusion
salvar_checkpoint entrega3_placement
reportar check_legality_placement.rpt {check_legality}

# Power ring, rails e mesh.
connect_pg_net -automatic

create_pg_ring_pattern ring_principal \
    -horizontal_layer M9 -horizontal_width {1.0} -horizontal_spacing {0.5} \
    -vertical_layer M8 -vertical_width {1.0} -vertical_spacing {0.5}
set_pg_strategy estrategia_ring -core \
    -pattern {{name: ring_principal} {nets: {VDD VSS}} {offset: {0.5 0.5}}}
compile_pg -strategies estrategia_ring

create_pg_std_cell_conn_pattern rails_standard_cells -layers {M1}
set_pg_strategy estrategia_rails -core \
    -pattern {{pattern: rails_standard_cells} {nets: {VSS VDD}}}
compile_pg -strategies estrategia_rails

create_pg_mesh_pattern mesh_horizontal \
    -layers {{{horizontal_layer: M9} {width: 0.5} {spacing: 3.0} \
              {pitch: 5.0} {trim: true}}} -via_rule {}
set_pg_strategy estrategia_mesh_horizontal -core \
    -pattern {{pattern: mesh_horizontal} {nets: {VSS VDD}}} \
    -extension {{stop: outermost_ring}}
compile_pg -strategies estrategia_mesh_horizontal

create_pg_mesh_pattern mesh_vertical \
    -layers {{{vertical_layer: M8} {width: 0.5} {spacing: 3.0} \
              {pitch: 5.0} {trim: true}}} -via_rule {}
set_pg_strategy estrategia_mesh_vertical -core \
    -pattern {{pattern: mesh_vertical} {nets: {VSS VDD}}} \
    -extension {{stop: outermost_ring}}
compile_pg -strategies estrategia_mesh_vertical

connect_pg_net -automatic
reportar check_pg_drc.rpt {check_pg_drc}

# CTS e routing.
clock_opt
salvar_checkpoint entrega3_cts

route_auto
salvar_checkpoint entrega3_route_auto

route_opt
salvar_checkpoint entrega3_route_opt

# Reports finais obrigatorios e verificacoes principais.
current_scenario functional_ss
reportar timing_setup_ss.rpt {report_timing -delay_type max -max_paths 10}
reportar power.rpt {report_power}
reportar area.rpt {report_area}
reportar clock_qor.rpt {report_clock_qor}
reportar constraints_violators.rpt {report_constraints -all_violators}
reportar qor.rpt {report_qor}
reportar utilization.rpt {report_utilization}
reportar pvt_final.rpt {report_pvt}

current_scenario functional_ff
reportar timing_hold_ff.rpt {report_timing -delay_type min -max_paths 10}

reportar check_timing.rpt {
    current_scenario functional_ss
    check_timing
    current_scenario functional_ff
    check_timing
}

reportar check_io_placement_final.rpt {
    check_io_placement -overlap all
    check_io_placement -gap
    check_io_placement -signal_constraints
}

current_scenario functional_ss
save_lib

puts "FLUXO DA ENTREGA 3 CONCLUIDO ATE ROUTE_OPT"
puts "Checkpoint final: entrega3_route_opt"
puts "Reports: $REPORT_ROOT"