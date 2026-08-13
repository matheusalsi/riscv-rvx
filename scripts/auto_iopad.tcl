# Ordem dos pads: left sobe, top vai para a direita,
# right desce e bottom vai para a esquerda.
array set SIDE_PADS {
    left {
        IOVDD_0 IOVSS_0 PAD_CLK PAD_RSTN VSS_0 VDD_0 PAD_URX PAD_UTX
    }
    top {
        PAD_SCLK PAD_MOSI VSS_1 VDD_1 PAD_MISO PAD_CS IOVSS_1 IOVDD_1
    }
    right {
        IOVDD_2 IOVSS_2 PAD_SDA PAD_SCL VDD_2 VSS_2
        PAD_GPIO_0 PAD_GPIO_1 PAD_GPIO_2 PAD_GPIO_3
    }
    bottom {
        PAD_GPIO_7 PAD_GPIO_6 VDD_3 VSS_3
        PAD_GPIO_5 PAD_GPIO_4 IOVSS_3 IOVDD_3
    }
}

create_io_ring -name io_ring

# Reserva 300 um para cada corner e 140 um para fillers.
set AVAILABLE [expr {$DIE_WIDTH - 2 * (300 + 140)}]
set PAD_WIDTH 40

foreach SIDE {left top right bottom} {
    set PADS $SIDE_PADS($SIDE)
    set N [llength $PADS]
    set GAP [expr {int(round(double($AVAILABLE - $N * $PAD_WIDTH) / ($N - 1)))}]

    set CONSTRAINT [list [lindex $PADS 0]]
    foreach PAD [lrange $PADS 1 end] {
        lappend CONSTRAINT $GAP $PAD
    }

    set_signal_io_constraints \
        -io_guide_object io_ring.$SIDE \
        -constraint $CONSTRAINT
}

place_io

set PAD_FILLERS {
    FILLER50 FILLER40 FILLER35 FILLER20 FILLER15
    FILLER10 FILLER5 FILLER1 FILLER01
}

set_attribute \
    [get_lib_cells -quiet saed32io_wb_5v/FILLER*] \
    reference_orientation R90

create_io_filler_cells \
    -reference_cells $PAD_FILLERS \
    -overlap_cells $PAD_FILLERS

connect_pg_net -automatic

redirect -tee -file [file join $REPORT_ROOT check_io_placement.rpt] {
    check_io_placement -overlap all
    check_io_placement -gap
    check_io_placement -signal_constraints
}

write_io_constraints \
    -filename [file join $REPORT_ROOT io_constraints_generated.tcl]

puts "ANEL DE I/O CRIADO"