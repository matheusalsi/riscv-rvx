# Biblioteca de trabalho e modelos parasiticos.
set DESIGN_LIB [file join $FC_DIR ${DESIGN}.dlib]

if {[file exists $DESIGN_LIB]} {
    error "A biblioteca ja existe: $DESIGN_LIB"
}

create_lib \
    -technology $TECH_FILE \
    -ref_libs $REFERENCE_LIBRARY \
    $DESIGN_LIB

read_parasitic_tech \
    -layermap $TLU_MAP \
    -tlup $TLU_MAX \
    -name maxTLU

read_parasitic_tech \
    -layermap $TLU_MAP \
    -tlup $TLU_MIN \
    -name minTLU

set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true

puts "TECNOLOGIA CARREGADA: $DESIGN_LIB"