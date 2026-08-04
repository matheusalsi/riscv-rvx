# proj paths
set SCRIPT_DIR     [file dirname [file normalize [info script]]]
set PRJ_ROOT_SETUP [file dirname [file dirname $SCRIPT_DIR]]
set FLOW_ROOT_SETUP [file dirname $SCRIPT_DIR]

# library dir & path
set PDK_PATH_SETUP            "/pdk/synopsys/saed32/SAED32_EDK"
set IO_LIB_PATH_SETUP	      "$PDK_PATH_SETUP/lib/io_std"
set STD_LIB_PATH_SETUP        "$PDK_PATH_SETUP/lib/stdcell_rvt"
set STD_VERILOG_PATH_SETUP    "$PDK_PATH_SETUP/lib/stdcell_rvt/verilog/saed32nm.v"

set SYN_TECH_DIR_SETUP        "$PDK_PATH_SETUP/tech"
