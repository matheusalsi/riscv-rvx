# top design
set TOP_MODULE_NAME "top_pad_rvx"
set DESIGN          "rvx"

# dirs
set PRJ_ROOT        $PRJ_ROOT_SETUP
set FLOW_ROOT       $FLOW_ROOT_SETUP

set SOURCE_DIR  	"$FLOW_ROOT/inp_data/source"           
set REPORT_DIR  	"$FLOW_ROOT/out_data/reports/pnr"   
set PRE_LAYOUT_DIR	"$FLOW_ROOT/out_data/pre_layout"    
set POST_LAYOUT_DIR	"$FLOW_ROOT/out_data/post_layout"   

set SYN_TECH_DIR	 $SYN_TECH_DIR_SETUP                
set STD_CELL_LIB_DIR $STD_LIB_PATH_SETUP                
set IO_CELL_LIB_DIR	 $IO_LIB_PATH_SETUP                 

set PRE_LAYOUT_VER_NETLIST  "$PRE_LAYOUT_DIR/${DESIGN}.v"   
set PRE_LAYOUT_DDC_NETLIST  "$PRE_LAYOUT_DIR/${DESIGN}.ddc" 
set SDC_FILE                "$PRE_LAYOUT_DIR/${DESIGN}.sdc" 

set POST_LAYOUT_VER_NETLIST "$POST_LAYOUT_DIR/${DESIGN}_final.v"   
set SPEF_FILE               "$POST_LAYOUT_DIR/${DESIGN}_final.spef"
set SDF_FILE                "$POST_LAYOUT_DIR/${DESIGN}_final.sdf" 

# set ANTENNA_RULE_FILE    "./scripts/antenna_rules.tcl"

# NDM reference (stdcell only, no PADs for now) 
set NDM_SC_LIB   "$STD_CELL_LIB_DIR/ndm/saed32rvt_base_frame_timing.ndm"
set NDM_IO_LIB   "$FLOW_ROOT/_lc/libs/saed32io_wb_5v"
#set NDM_IO_LIB   "$FLOW_ROOT/_lc/libs/saed32io_wb_5v/saed32_io_wb_all.ndm"

# tech
set TECH_FILE    "$SYN_TECH_DIR/tf/saed32nm_1p9m.tf"

# parasitics paths (consumed AFTER lib is open, in the flow script) 
set TLUP_MAP  "$SYN_TECH_DIR/starrc/saed32nm_tf_itf_tluplus.map"
set TLUP_MAX  "$SYN_TECH_DIR/starrc/max/saed32nm_1p9m_Cmax.tluplus"
set TLUP_MIN  "$SYN_TECH_DIR/starrc/min/saed32nm_1p9m_Cmin.tluplus"

# --- power/ground nets (core + IO ring) ---
set PWR_NET    "VDD"
set GND_NET    "VSS"
set IOPWR_NET  "VDDIO"
set IOGND_NET  "VSSIO"

# fillers / antenna (stdcell)
set METAL_FILLER "SHFILL128_RVT SHFILL64_RVT SHFILL3_RVT SHFILL2_RVT SHFILL1_RVT"
set FILLER       "SHFILL1_RVT"
set ANTENNA_CELL "ANTENNA_RVT"
set PAD_FILLER   "FILLER50 FILLER40 FILLER35 FILLER20 FILLER15 FILLER10 FILLER5 FILLER1 FILLER01"

set STD_CELL_LIB_GDS "$STD_CELL_LIB_DIR/gds/saed32nm_rvt_oa.gds"
set IO_CELL_LIB_GDS  "$IO_CELL_LIB_DIR/gds/saed32_stdio_fc.gds"

