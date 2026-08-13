################################################################################
#
# Design name:  top_pad_rvx
#
# Created by fc write_sdc on Thu Aug 13 16:18:35 2026
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: functional
# Corner: corner_ss
# Scenario: functional_ss

# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 14; \
#   /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 16
create_clock -name RVX_CLK -period 30 -waveform {0 15} [get_ports {clock}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 24
group_path -name INREG -from [get_ports {reset_n uart_rx miso gpio[7] gpio[6] \
    gpio[5] gpio[4] gpio[3] gpio[2] gpio[1] gpio[0] i2c_sda i2c_scl}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 25
group_path -name REGOUT -to [get_ports {uart_tx sclk mosi cs gpio[7] gpio[6] \
    gpio[5] gpio[4] gpio[3] gpio[2] gpio[1] gpio[0] i2c_sda i2c_scl}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 26
group_path -name FEEDTHROUGH -from [get_ports {reset_n uart_rx miso gpio[7] \
    gpio[6] gpio[5] gpio[4] gpio[3] gpio[2] gpio[1] gpio[0] i2c_sda i2c_scl}] \
    -to [get_ports {uart_tx sclk mosi cs gpio[7] gpio[6] gpio[5] gpio[4] \
    gpio[3] gpio[2] gpio[1] gpio[0] i2c_sda i2c_scl}]
set_load -pin_load 10 [get_ports {uart_tx}]
set_load -pin_load 10 [get_ports {sclk}]
set_load -pin_load 10 [get_ports {mosi}]
set_load -pin_load 10 [get_ports {cs}]
set_load -pin_load 10 [get_ports {gpio[7]}]
set_load -pin_load 10 [get_ports {gpio[6]}]
set_load -pin_load 10 [get_ports {gpio[5]}]
set_load -pin_load 10 [get_ports {gpio[4]}]
set_load -pin_load 10 [get_ports {gpio[3]}]
set_load -pin_load 10 [get_ports {gpio[2]}]
set_load -pin_load 10 [get_ports {gpio[1]}]
set_load -pin_load 10 [get_ports {gpio[0]}]
set_load -pin_load 10 [get_ports {i2c_sda}]
set_load -pin_load 10 [get_ports {i2c_scl}]
set_operating_conditions -library \
    saed32rvt_ss0p95v125c.db:saed32rvt_ss0p95v125c -analysis_type \
    on_chip_variation ss0p95v125c
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/mcmm.tcl, line 10
set_voltage 0.95 -object_list {VDD}
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/mcmm.tcl, line 11
set_voltage 0 -object_list {VSS}
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/mcmm.tcl, line 12
set_voltage 2.25 -object_list {VDDIO}
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/mcmm.tcl, line 13
set_voltage 0 -object_list {VSSIO}
# Warning: Libcell power domain derates are skipped!

# -origin user
set_clock_latency 1 [get_clocks {RVX_CLK}]
# Set latency for io paths.
set_clock_uncertainty -setup 1 [get_clocks {RVX_CLK}]
set_clock_transition 0.2 [get_clocks {RVX_CLK}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {reset_n}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {uart_rx}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {miso}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[7]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[6]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[5]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[4]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[3]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[2]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[1]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {gpio[0]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {i2c_sda}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 21
set_input_transition 0.2 [get_ports {i2c_scl}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {reset_n}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {uart_rx}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {uart_tx}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {sclk}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {mosi}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {miso}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {cs}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[7]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[7]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[6]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[6]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[5]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[5]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[4]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[4]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[3]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[3]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[2]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[2]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[1]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[1]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[0]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {gpio[0]}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {i2c_sda}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {i2c_sda}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 19
set_input_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {i2c_scl}]
# /home/inf01185/matheus.almeida/ci-expert/6-riscv-rvx/scripts/constraints.tcl, \
#   line 20
set_output_delay -clock [get_clocks {RVX_CLK}] -max 0.1 [get_ports {i2c_scl}]
