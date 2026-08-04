# read in design
# do not put testbench in the list below
set_svf $PRE_LAYOUT_DIR/${DESIGN}.svf
set_app_var hdlin_enable_hier_map true
set verilogout_show_unconnected_pins true

#Tell DC to not optimize any ff that had constant value of 0 or 1
#set compile_seqmap_propagate_constants false

#Tell DC to not optimize any sequential elements
#even if they are redundant or unused
#set_app_var hdlin_preserve_sequential all

#read_file -format sverilog $SOURCE_PATH -autoread -recursive -top top
#read_file -top ${TOP_MODULE_NAME} -format sverilog ${TC_SOURCE_PATH}/TOP_PAD.v

# System verilog
# set sv_files [glob -nocomplain -directory $SOURCE_PATH *.sv]
# if {[llength $sv_files] == 0} {
#     error "No .sv files found in $SOURCE_PATH"
# }
# puts "=== Analyzing [llength $sv_files] files SystemVerilog"
# analyze -format sverilog -library WORK $sv_files
# elaborate $TOP_MODULE_NAME

# Verilog
set v_files [split [exec find $SOURCE_PATH -name "*.v"] "\n"]

if {[llength $v_files] > 0} {
    analyze -format verilog -vcs "+incdir+${SOURCE_PATH}" $v_files
} else {
    puts "ERROR: No .v files found in $SOURCE_PATH"
}

echo $v_files

elaborate $TOP_MODULE_NAME
set_verification_top

# build gtech design
current_design $TOP_MODULE_NAME
link
uniquify

# DFT spec
#create_port -direction in  test_si
#create_port -direction out test_so
#create_port -direction in  test_se

#set_scan_configuration -chain_count 1

#set_dft_signal -view spec -type ScanDataIn  -port test_si
#set_dft_signal -view spec -type ScanDataOut -port test_so
#set_dft_signal -view spec -type ScanEnable  -port test_se

# check design
check_design > $REPORT_DIR/dc_check_design.rpt

write -f ddc -hier -out  $PRE_LAYOUT_DIR/${DESIGN}_unmapped.ddc


