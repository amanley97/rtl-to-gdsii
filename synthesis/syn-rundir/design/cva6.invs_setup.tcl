################################################################################
#
# Innovus setup file
# Created by Genus(TM) Synthesis Solution 20.10-p001_1
#   on 03/13/2025 19:30:29
#
################################################################################
#
# Genus(TM) Synthesis Solution setup file
# This file can only be run in Innovus Common UI mode.
#
################################################################################

      regexp {\d\d} [get_db program_version] major_version
      if { $major_version < 19 } {
        error "Innovus version must be 19 or higher."
      }
    

      set _t0 [clock seconds]
      puts [format  {%%%s Begin Genus to Innovus Setup (%s)} \# [clock format $_t0 -format {%m/%d %H:%M:%S}]]
    
set_db read_physical_allow_multiple_port_pin_without_must_join true
set_db must_join_all_ports true
set_db timing_cap_unit 1ff
set_db timing_time_unit 1ps


# Design Import
################################################################################
## Reading FlowKit settings file
source /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.flowkit_settings.tcl

source /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.invs_init.tcl

# Reading metrics file
################################################################################
read_metric -id current /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.metrics.json

## Reading common preserve file for dont_touch and dont_use preserve settings
source -quiet /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.preserve.tcl



# Mode Setup
################################################################################
source /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.mode


# MSV Setup
################################################################################

# Reading write_name_mapping file
################################################################################

      if { [is_attribute -obj_type port original_name] &&
           [is_attribute -obj_type pin original_name] &&
           [is_attribute -obj_type pin is_phase_inverted]} {
        source /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.wnm_attrs.tcl
      }
    
eval_legacy {set edi_pe::pegConsiderMacroLayersUnblocked 1}
eval_legacy {set edi_pe::pegPreRouteWireWidthBasedDensityCalModel 1}

      set _t1 [clock seconds]
      puts [format  {%%%s End Genus to Innovus Setup (%s, real=%s)} \# [clock format $_t1 -format {%m/%d %H:%M:%S}] [clock format [expr {28800 + $_t1 - $_t0}] -format {%H:%M:%S}]]
    
