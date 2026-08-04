########################################
# FLOORPLAN v2 — top_pad_rvx (ICC2, Modelo A)
########################################
file mkdir $REPORT_DIR

# ------------------------------------------------------------------------------
# 1. Inicializa floorplan — die fixo 1950x1950, core_offset = 300 (pad) + 50
# ------------------------------------------------------------------------------
initialize_floorplan -boundary {{0 0} {1950 1950}} -core_offset 350

# ------------------------------------------------------------------------------
# 2. Posiciona os pads no anel (cria io_ring + place_io, espaçamento fixo)
# ------------------------------------------------------------------------------
source ../scripts/auto_iopad.tcl

# ------------------------------------------------------------------------------
# 3. Fecha o anel com IO fillers (R90 necessário p/ bordas verticais no SAED32)
# ------------------------------------------------------------------------------
set_attribute [get_lib_cells saed32io_wb_5v/FILLER*] reference_orientation R90
create_io_filler_cells -reference_cells $PAD_FILLER

check_io_placement -overlap all
check_io_placement -gap

# ------------------------------------------------------------------------------
# 4. PG lógico — liga nets VDD/VSS/VDDIO/VSSIO aos pinos
# ------------------------------------------------------------------------------
connect_pg_net -automatic

