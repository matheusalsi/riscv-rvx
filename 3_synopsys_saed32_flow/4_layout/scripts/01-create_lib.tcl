create_lib ${TOP_MODULE_NAME}.dlib \
    -technology $TECH_FILE \
    -ref_libs [concat $NDM_SC_LIB $NDM_IO_LIB]

read_parasitic_tech -layermap $TLUP_MAP -tlup $TLUP_MAX -name maxTLU
read_parasitic_tech -layermap $TLUP_MAP -tlup $TLUP_MIN -name minTLU

read_verilog $PRE_LAYOUT_VER_NETLIST -top $TOP_MODULE_NAME
link_block

set_parasitic_parameters -late_spec maxTLU -early_spec minTLU

read_sdc $SDC_FILE
save_block -as ${TOP_MODULE_NAME}_initial
