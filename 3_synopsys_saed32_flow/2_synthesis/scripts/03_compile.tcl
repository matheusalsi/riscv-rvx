# optimize design
set_fix_hold [all_clocks]
set_fix_multiple_port_nets -all -buffer_constants
set verilogout_no_tri true

# set_dont_touch [get_cells -hier -filter "is_hierarchical==false && \
#     (ref_name=~*I1025* || ref_name=~*CORNER* || ref_name=~*VDD* || \
#      ref_name=~*VSS* || ref_name=~*IOVDD* || ref_name=~*IOVSS*)"]

#compile_ultra -no_autoungroup -scan
compile_ultra -no_autoungroup

# DFT I
#create_test_protocol -infer_clock -infer_asynch
#dft_drc
#preview_dft
#insert_dft

# reports post compile
report_timing                     > $REPORT_DIR/2_post_compile_timing.rpt
report_qor                        > $REPORT_DIR/2_post_compile_qor.rpt
report_constraints -all_violators > $REPORT_DIR/2_post_compile_constraints.rpt
report_power       -verbose       > $REPORT_DIR/2_post_compile_power.rpt
check_design                      > $REPORT_DIR/2_post_compile_check_design.rpt

# Opt
#compile_ultra -scan -incremental
compile_ultra -incremental

# DFT II
#dft_drc                                        > $REPORT_DIR/DFT_drc.rpt
#report_scan_path -view existing_dft -chain all > $REPORT_DIR/DFT_report_scan_path.rpt
#report_constraints -all_violators              > $REPORT_DIR/DFT_report_constraints.rpt
#write_scan_def -output                           $PRE_LAYOUT_DIR/$DESIGN.scandeff

# Reports post inc
report_timing                     > $REPORT_DIR/3_inc_compile_timing.rpt
report_qor                        > $REPORT_DIR/3_inc_compile_qor.rpt
report_constraints -all_violators > $REPORT_DIR/3_inc_compile_constraints.rpt
report_power       -verbose       > $REPORT_DIR/3_inc_compile_power.rpt
check_design                      > $REPORT_DIR/3_inc_compile_check_design.rpt

# Datapath analysis
analyze_datapath_extraction       > $REPORT_DIR/3_inc_compile_datapath_extraction.rpt

report_port                       > $REPORT_DIR/3_report_port.rpt

######################################################
## Outputs
######################################################
change_names -rule verilog -hier

write_sdc  $PRE_LAYOUT_DIR/$DESIGN.sdc
write_file -format ddc     -hier -out $PRE_LAYOUT_DIR/$DESIGN.ddc
write_file -format verilog -hier -out $PRE_LAYOUT_DIR/$DESIGN.v

#write_test_protocol -output $PRE_LAYOUT_DIR/$DESIGN.spf
