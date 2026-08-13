# Carrega o UPF e conecta as redes aos pinos PG do design.
set UPF_FILE [file join $SCRIPT_DIR power.upf]
if {![file exists $UPF_FILE]} {
    error "UPF nao encontrado: $UPF_FILE"
}

load_upf $UPF_FILE

foreach SUPPLY {VDD VSS VDDIO VSSIO} {
    set PINS [get_pins -quiet -hierarchical */$SUPPLY]
    if {[sizeof_collection $PINS] == 0} {
        error "Nenhum pino $SUPPLY encontrado"
    }
    connect_supply_net $SUPPLY -ports $PINS
}

set SUPPLY_PORTS [get_ports -quiet {VDD VSS VDDIO VSSIO}]
set SIGNAL_PORTS [remove_from_collection [get_ports *] $SUPPLY_PORTS]
set_related_supply_net \
    -object_list $SIGNAL_PORTS \
    -power VDDIO \
    -ground VSSIO

commit_upf

redirect -tee -file [file join $REPORT_ROOT check_mv_design.rpt] {
    check_mv_design
}

puts "INTENCAO DE POTENCIA CARREGADA"