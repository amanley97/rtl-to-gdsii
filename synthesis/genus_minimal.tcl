# Get environment variables
set PROJECT_ROOT		  [getenv PROJECT_ROOT]
set CVA6_REPO_DIR	    	  ${PROJECT_ROOT}/../cva6
set TARGET_CFG 			  [getenv TARGET]
set HPDCACHE_DIR		  ${CVA6_REPO_DIR}/core/cache_subsystem/hpdcache/

set PERIOD                        [getenv PERIOD]
set DESIGN_NAME                   [getenv DESIGN_NAME]
set TARGET                        [getenv TARGET]
set TECH                          [getenv TECH_NAME]
set FOUNDRY_PATH                  [getenv FOUNDRY_PATH]
set TARGET_LIBRARY_FILES          [getenv TARGET_LIBRARY_FILES]
set INPUT_DELAY                   [getenv INPUT_DELAY]
set OUTPUT_DELAY                  [getenv OUTPUT_DELAY]
set LOCAL_LIB_PATH                [getenv LOCAL_LIB_PATH]

# Define standard cell libraries
set_db library "${TARGET_LIBRARY_FILES}"

# Read RTL files
read_hdl -sv -f $PROJECT_ROOT/Flist.cva6_synth
elaborate $DESIGN_NAME

# Set timing constraints
create_clock -name main_clk -period $PERIOD [get_ports clk_i]
set_input_delay -clock main_clk -max $INPUT_DELAY [all_inputs]
set_output_delay -clock main_clk -max $OUTPUT_DELAY [all_outputs]

# Synthesize the design
syn_generic $DESIGN_NAME
syn_map $DESIGN_NAME

# Write out Verilog netlist (mapped for Innovus)
write_netlist ${DESIGN_NAME} > ${PROJECT_ROOT}/${DESIGN_NAME}_synth.v

# Generate a synthesis database for Innovus
write_design -base_name ${PROJECT_ROOT}/${DESIGN_NAME} -innovus -hierarchical ${DESIGN_NAME}

# Export timing constraints
write_sdc ${DESIGN_NAME} > ${PROJECT_ROOT}/${DESIGN_NAME}.sdc

report_timing > ${PROJECT_ROOT}/${DESIGN_NAME}_timing.rpt
report_area > ${PROJECT_ROOT}/${DESIGN_NAME}_area.rpt
report_power > ${PROJECT_ROOT}/${DESIGN_NAME}_power.rpt
