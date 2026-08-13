###############################################################################
# Design Planning
# Floorplan:
################################################################################

disconnect_net */*IOPAD

## PG RING 

create_pg_ring_pattern ring_pattern -horizontal_layer M9 \
   -horizontal_width {5} -horizontal_spacing {2} \
   -vertical_layer M8 -vertical_width {5} -vertical_spacing {2}

set_pg_strategy core_ring \
   -pattern {{name: ring_pattern} \
   {nets: {VDD VSS}} {offset: {1 1}}} -core

compile_pg -strategies core_ring

create_trunk_pin_to_trunk -nets {VDD VSS} -adjust_to_pin -of_cells {VSS_* VDD_*}
create_trunk_pin_to_trunk -nets {VDD VSS} -adjust_to_pin -of_cells {VSS_* VDD_*} -direction H -layer M9

## PG Stripes M1

create_pg_std_cell_conn_pattern std_pattern_1 -layers {M1}
set_pg_strategy  pg_std_cell -core  -pattern {{pattern: std_pattern_1 }{nets: {VSS VDD}} }
compile_pg -strategies pg_std_cell

## Internal PG mesh

create_pg_mesh_pattern pg_mesh1 -layers { {{horizontal_layer: M9} {width: 0.5} {spacing: 3} {pitch: 5} {trim: true}}  } -via_rule {}
set_pg_strategy  pg_strategy1  -core  -pattern {{pattern: pg_mesh1}{nets: {VSS VDD}} } -extension {{stop: outermost_ring}}
compile_pg -strategies pg_strategy1

create_pg_mesh_pattern pg_mesh2 -layers { {{vertical_layer: M8} {width: 0.5} {spacing: 3} {pitch: 5} {trim: true}}  } -via_rule {}
set_pg_strategy  pg_strategy2  -core  -pattern {{pattern: pg_mesh2}{nets: {VSS VDD}} } -extension {{stop: outermost_ring}}
compile_pg -strategies pg_strategy2