# Fluxo completo da Entrega 3: RTL ate route_opt.
set SCRIPT_DIR [file dirname [file normalize [info script]]]

foreach SCRIPT {
    setup.tcl 
    tech_setup.tcl 
    read_rtl.tcl 
    power_setup.tcl
    mcmm.tcl 
    floorplan.tcl 
    auto_iopad.tcl
} {
    source -echo [file join $SCRIPT_DIR $SCRIPT]
}

proc salvar_checkpoint {NOME} {
    save_block -as $NOME
    save_lib
}

source ../scripts/reports.tcl

# Floorplan.
salvar_checkpoint entrega2_floorplan
