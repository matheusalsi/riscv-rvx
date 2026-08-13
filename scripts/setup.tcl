# Caminhos e nomes do projeto.
set SCRIPT_DIR   [file dirname [file normalize [info script]]]
set PROJECT_ROOT [file normalize [file join $SCRIPT_DIR ..]]

set SOURCE_DIR  [file join $PROJECT_ROOT source]
set REPORT_ROOT [file join $PROJECT_ROOT reports]
set OUTPUT_ROOT [file join $PROJECT_ROOT output]
set FC_DIR      [file join $PROJECT_ROOT fc]

set TOP_MODULE top_pad_rvx
set DESIGN     rvx

# Tecnologia SAED32.
set PDK_PATH  /pdk/synopsys/saed32/SAED32_EDK
set TECH_FILE [file join $PDK_PATH tech tf saed32nm_1p9m.tf]
set TLU_MAP   [file join $PDK_PATH tech starrc saed32nm_tf_itf_tluplus.map]
set TLU_MAX   [file join $PDK_PATH tech starrc max saed32nm_1p9m_Cmax.tluplus]
set TLU_MIN   [file join $PDK_PATH tech starrc min saed32nm_1p9m_Cmin.tluplus]

# Fusion Libraries geradas nos labs anteriores.
set LIB_ROOT [file join $PROJECT_ROOT 01_Lab_pads]
set REFERENCE_LIBRARY [list \
    [file join $LIB_ROOT saed32rvt_c] \
    [file join $LIB_ROOT saed32rvt_pg_c] \
    [file join $LIB_ROOT saed32rvt_dlvl_v] \
    [file join $LIB_ROOT saed32rvt_ulvl_v] \
    [file join $LIB_ROOT saed32io_wb_5v]]

# Falha cedo se algum caminho essencial estiver incorreto.
foreach REQUIRED_PATH [concat \
    [list $SOURCE_DIR $PDK_PATH $TECH_FILE $TLU_MAP $TLU_MAX $TLU_MIN $LIB_ROOT] \
    $REFERENCE_LIBRARY] {
    if {![file exists $REQUIRED_PATH]} {
        error "Caminho nao encontrado: $REQUIRED_PATH"
    }
}

file mkdir $REPORT_ROOT $OUTPUT_ROOT $FC_DIR
puts "SETUP CARREGADO: $PROJECT_ROOT"