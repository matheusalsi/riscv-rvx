# Sintese logica limitada ao initial_map.
set_ungroup * false
current_scenario functional_ss

compile_fusion 

save_block -as entrega2_initial_map
save_lib

puts "SINTESE CONCLUIDA: entrega2_initial_map"
puts "Placement, CTS e routing nao foram executados."