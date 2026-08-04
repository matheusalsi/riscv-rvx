# ==============================================================================
# auto_iopad.tcl  --  Pad placement on the I/O ring (ICC2, Model A)
# Deterministic spacing (ported from the Malaysia auto_iopad).
# Power/corner pads come from RTL (top_pad_rvx); here we only place them.
# ==============================================================================

# ------------------------------------------------------------------------------
# 0. Geometric parameters (measured from the SAED32 library)
# ------------------------------------------------------------------------------
set die_width        1950
set corner_pad_size  300      ;# SAED32 CORNER size (300x300)
set corner_clearance 140      ;# design clearance after the corner
set pad_width        40       ;# SAED32 pad width (measured)

set exclusion_zone   [expr {$corner_pad_size + $corner_clearance}]
set available_space  [expr {$die_width - (2 * $exclusion_zone)}]
puts "Info: exclusion_zone=$exclusion_zone  available_space=$available_space"

# ------------------------------------------------------------------------------
# 1. Pad order per edge
#    ICC2 direction: left(up) top(->) right(down) bottom(<-)
# ------------------------------------------------------------------------------
set side_pads(left) {
    IOVDD_0 IOVSS_0 PAD_CLK PAD_RSTN VSS_0 VDD_0 PAD_URX PAD_UTX
}
set side_pads(top) {
    PAD_SCLK PAD_MOSI VSS_1 VDD_1 PAD_MISO PAD_CS IOVSS_1 IOVDD_1
}
set side_pads(right) {
    IOVDD_2 IOVSS_2 PAD_SDA PAD_SCL VDD_2 VSS_2 PAD_GPIO_0 PAD_GPIO_1 PAD_GPIO_2 PAD_GPIO_3
}
set side_pads(bottom) {
    PAD_GPIO_7 PAD_GPIO_6 VDD_3 VSS_3 PAD_GPIO_5 PAD_GPIO_4 IOVSS_3 IOVDD_3
}

# ------------------------------------------------------------------------------
# 2. Create the I/O ring (idempotent)
# ------------------------------------------------------------------------------
puts "Info: Creating I/O ring..."
if {[sizeof_collection [get_io_rings -quiet io_ring]] > 0} {
    remove_io_rings io_ring
}
create_io_ring -name io_ring

# ------------------------------------------------------------------------------
# 3. Fixed spacing per edge (uniform, deterministic gap)
# ------------------------------------------------------------------------------
foreach side {left top right bottom} {
    set pads     $side_pads($side)
    set num_pads [llength $pads]

    # Uniform gap = free space / number of intervals between pads
    set total_pad_width [expr {$num_pads * $pad_width}]
    set gap_space       [expr {$available_space - $total_pad_width}]
    if {$num_pads > 1} {
        set gap [expr {int(round(double($gap_space) / ($num_pads - 1)))}]
    } else {
        set gap 0
    }

    if {$gap_space < 0} {
        puts "WARNING: Edge $side overflows the available space (pads=$total_pad_width > $available_space)"
    }
    puts "Info: Edge $side -> $num_pads pads, gap=$gap um"

    # Build constraint: pad1 gap pad2 gap pad3 ...
    set c [list]
    set first 1
    foreach p $pads {
        if {$first} {
            lappend c $p
            set first 0
        } else {
            lappend c $gap $p
        }
    }
    set_signal_io_constraints -io_guide_object "io_ring.$side" -constraint $c
}

# ------------------------------------------------------------------------------
# 4. Place the pads on the ring
# ------------------------------------------------------------------------------
puts "Info: Running place_io..."
place_io

# ------------------------------------------------------------------------------
# 5. Ring checks
# ------------------------------------------------------------------------------
check_io_placement -overlap all
check_io_placement -signal_constraints

puts "Info: Pad placement completed."