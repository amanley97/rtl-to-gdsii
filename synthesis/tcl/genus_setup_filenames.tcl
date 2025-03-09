# Copyright 2021 Thales DIS design services SAS
#
# Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
#
# You may obtain a copy of the License at https://solderpad.org/licenses/
#
# Original Author: Jean-Roch COULON - Thales
#

#
# Modified by Alex Manley for use with Cadence GENUS
#

puts "RM-Info: Running script [info script]\n"

#################################################################################
# Genus Reference Methodology Filenames Setup
# Script: genus_setup_filenames.tcl
#################################################################################

set INPUTS_DIR ${DESIGN_NAME}_${TARGET}/inputs/
set REPORTS_DIR ${DESIGN_NAME}_${TARGET}/${PERIOD}/reports/
set OUTPUTS_DIR ${DESIGN_NAME}_${TARGET}/${PERIOD}/outputs/
set RESULTS_DIR  ${DESIGN_NAME}_${TARGET}/${PERIOD}/netlist/

set SCENARIO mode_norm_ws0_wc_125

file mkdir ${INPUTS_DIR}
file mkdir ${REPORTS_DIR}
file mkdir ${OUTPUTS_DIR}
file mkdir ${RESULTS_DIR}

###############
# Input Files #
###############

set GENUS_SDC_INPUT_FILE                                 ${INPUTS_DIR}/${DESIGN_NAME}.sdc
set GENUS_CONSTRAINTS_INPUT_FILE                         ${INPUTS_DIR}/${DESIGN_NAME}.constraints.tcl

###########
# Reports #
###########

set GENUS_CHECK_LIBRARY_REPORT                           ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_check_library.rpt

set GENUS_CONSISTENCY_CHECK_ENV_FILE                     ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}.synthesize.env
set GENUS_CHECK_DESIGN_REPORT                            ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}.check_design.rpt
set GENUS_ANALYZE_DATAPATH_EXTRACTION_REPORT             ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}.analyze_datapath_extraction.rpt

set GENUS_FINAL_QOR_REPORT                               ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_qor.rpt
set GENUS_FINAL_TIMING_REPORT                            ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_timing.rpt
set GENUS_FINAL_AREA_REPORT                              ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_area.rpt
set GENUS_FINAL_POWER_REPORT                             ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_power.rpt
set GENUS_FINAL_CLOCK_GATING_REPORT                      ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_clock_gating.rpt
set GENUS_FINAL_SELF_GATING_REPORT                       ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_self_gating.rpt
set GENUS_THRESHOLD_VOLTAGE_GROUP_REPORT                 ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_threshold.voltage.group.rpt
set GENUS_INSTANTIATE_CLOCK_GATES_REPORT                 ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_instatiate_clock_gates.rpt
set GENUS_FINAL_POWER_REPORT                             ${REPORTS_DIR}/${DESIGN_NAME}_${TECH}_synth_power.rpt

################
# Output Files #
################

set GENUS_AUTOREAD_RTL_SCRIPT                            ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}.autoread_rtl.tcl
set GENUS_ELABORATED_DESIGN_MAPPED_OUTPUT_FILE           ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}.elab.mapped.v
set GENUS_SYNTHESIZED_NETLIST_OUTPUT_FILE                ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}.synth.mapped.v
set GENUS_FINAL_VERILOG_OUTPUT_FILE                      ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.v
set GENUS_FINAL_SDC_OUTPUT_FILE                          ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.${SCENARIO}.sdc
set GENUS_FINAL_SPEF_OUTPUT_FILE                         ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.${SCENARIO}.spef
set GENUS_FINAL_FSDB_OUTPUT_FILE                         ${OUTPUTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.fsdb
set GENUS_FINAL_VCD_OUTPUT_FILE                          ${OUTPUTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.vcd
set GENUS_FINAL_SDF_OUTPUT_FILE                          ${RESULTS_DIR}/${DESIGN_NAME}_${TARGET}_${TECH}_synth.${SCENARIO}.sdf

puts "RM-Info: Completed script [info script]\n"
