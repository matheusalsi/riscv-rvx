# Restricoes funcionais: 30 ns = 33,33 MHz.
set CLOCK_PERIOD 30.0
set CLK_PORT [get_ports -quiet clock]

if {[sizeof_collection $CLK_PORT] != 1} {
    error "Porta clock nao encontrada"
}

set DATA_IN  [remove_from_collection [all_inputs] $CLK_PORT]
set DATA_OUT [all_outputs]

# Setup: atrasos maximos no scenario lento.
current_scenario functional_ss
create_clock -name RVX_CLK -period $CLOCK_PERIOD $CLK_PORT
set_clock_uncertainty -setup 1.0 [get_clocks RVX_CLK]
set_clock_latency 1.0 [get_clocks RVX_CLK]
set_clock_transition 0.2 [get_clocks RVX_CLK]

set_input_delay  -max 0.1 -clock [get_clocks RVX_CLK] $DATA_IN
set_output_delay -max 0.1 -clock [get_clocks RVX_CLK] $DATA_OUT
set_input_transition 0.2 $DATA_IN
set_load 10.0 $DATA_OUT

group_path -name INREG       -from $DATA_IN
group_path -name REGOUT      -to $DATA_OUT
group_path -name FEEDTHROUGH -from $DATA_IN -to $DATA_OUT

# Hold: atrasos minimos devem ser aplicados com functional_ff ativo.
current_scenario functional_ff
set_input_delay  -min 0.1 -clock [get_clocks RVX_CLK] $DATA_IN
set_output_delay -min 0.1 -clock [get_clocks RVX_CLK] $DATA_OUT

current_scenario functional_ss
puts "RESTRICOES CARREGADAS: RVX_CLK = $CLOCK_PERIOD ns"