# Copyright 2021 Thales DIS design services SAS
#
# Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
# You may obtain a copy of the License at https://solderpad.org/licenses/
#
# Original Author: Jean-Roch COULON - Thales
#

#
# Modified by Alex Manley for use with Cadence GENUS
#

# Variables common to all reference methodology scripts
set PERIOD                        [getenv PERIOD];
set DESIGN_NAME                   [getenv DESIGN_NAME];  # The name of the top-level design
set TARGET                        [getenv TARGET];
set TECH                          [getenv TECH_NAME];
set techno                        [getenv TECH_NAME];
set FOUNDRY_PATH                  [getenv FOUNDRY_PATH];
set TARGET_LIBRARY_FILES          [getenv TARGET_LIBRARY_FILES];
set INPUT_DELAY                   [getenv INPUT_DELAY];
set OUTPUT_DELAY                  [getenv OUTPUT_DELAY];
set LOCAL_LIB_PATH                [getenv LOCAL_LIB_PATH];

set ADDITIONAL_LINK_LIB_FILES     "";  # Extra link logical libraries not included in TARGET_LIBRARY_FILES

# Remove unnecessary messages
suppress_message LINK-17
suppress_message MWLIBP-300
suppress_message MWLIBP-301
suppress_message MWLIBP-319
suppress_message MWLIBP-324
suppress_message MWLIBP-311
suppress_message MWLIBP-032
suppress_message UCN-1
suppress_message UID-282

set ADDITIONAL_SEARCH_PATH "${FOUNDRY_PATH}/cadence ${FOUNDRY_PATH}";
set_app_var search_path ". ${ADDITIONAL_SEARCH_PATH} $search_path"

if {$program_name == "genus"}  {
  set_app_var target_library ${TARGET_LIBRARY_FILES}
  set_app_var synthetic_library dw_foundation.sldb
  set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"
}

source -echo -verbose scripts/genus_setup_filenames.tcl

# The following setting removes new variable info messages from the end of the log file
set_app_var sh_new_variable_message false

if {$program_name == "genus"}  {

  #################################################################################
  # Genus Setup Variables
  #################################################################################

  # Enable multicore optimization for better runtime
  set_host_options -max_cpus 8

  # Define a central cache for analyzed libraries to save runtime and disk space
  set_app_var alib_library_analysis_path .

  # Define naming rules
  define_name_rules verilog \
    -target_bus_naming_style "%s[%d]" \
    -allowed "a-z0-9_" \
    -first_restricted "0-9_" \
    -replacement_char "_" \
    -equal_ports_nets -inout_ports_equal_nets \
    -collapse_name_space -case_insensitive -special verilog \
    -add_dummy_nets \
    -dummy_net_prefix "synp_unconn_%d"

  # Eliminate tri-state nets and assign primitives in the output netlist
  set_app_var verilogout_no_tri true

  # Preserve FFs with no load used as spares
  set_app_var hdlin_preserve_sequential ff+loop_variables

  ### Power optimization settings
  set_app_var power_remove_redundant_clock_gates true
  set_app_var power_cg_reconfig_stages true
  set_app_var compile_clock_gating_through_hierarchy true
  set_app_var power_cg_designware true
  set_app_var power_cg_derive_related_clock true
  set_app_var do_operand_isolation true
  set_app_var power_low_power_placement true
  set_app_var power_opto_extra_high_dynamic_power_effort true

  ### Module naming style
  set_app_var template_parameter_style "%s"
  set_app_var template_naming_style "%s"
}
