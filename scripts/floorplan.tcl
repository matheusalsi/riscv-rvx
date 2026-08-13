# Die 1950 x 1950 um; core 1250 x 1250 um.
set DIE_WIDTH   1950
set DIE_HEIGHT  1950
set CORE_OFFSET 350

# Preserva as 38 instancias que formam o anel de I/O.
set SIGNAL_PADS [get_cells -quiet PAD_*]
set CORNERS     [get_cells -quiet CORNER*]
set POWER_PADS  [get_cells -quiet {VDD_* VSS_* IOVDD_* IOVSS_*}]

if {[sizeof_collection $SIGNAL_PADS] != 18 ||
    [sizeof_collection $CORNERS] != 4 ||
    [sizeof_collection $POWER_PADS] != 16} {
    error "Quantidade inesperada de pads ou corners"
}

set_dont_touch $SIGNAL_PADS
set_dont_touch $CORNERS
set_dont_touch $POWER_PADS

initialize_floorplan \
    -boundary [list [list 0 0] [list $DIE_WIDTH $DIE_HEIGHT]] \
    -core_offset $CORE_OFFSET

set_block_pin_constraints \
    -self \
    -allowed_layers {M3 M4 M5 M6}

puts "FLOORPLAN CRIADO: die 1950 x 1950 um; core 1250 x 1250 um"