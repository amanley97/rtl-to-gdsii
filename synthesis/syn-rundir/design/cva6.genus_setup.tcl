################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 20.10-p001_1
#   on 03/13/2025 19:30:31
#
# This file can only be run in Genus Common UI mode.
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 20.10-p001_1


# Remove Existing Design
################################################################################
if {[::legacy::find -design design:cva6] ne ""} {
  puts "** A design with the same name is already loaded. It will be removed. **"
  delete_obj design:cva6
}


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
::legacy::set_attribute library {/moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_TT_ccs_211120.lib /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SEQ_RVT_TT_ccs_220123.lib /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_INVBUF_RVT_TT_ccs_220122.lib /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_SS_ccs_211120.lib /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_FF_ccs_211120.lib /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SEQ_RVT_SS_ccs_220123.lib} /


# Design
################################################################################
read_netlist -top cva6 /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.v
read_metric -id current /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.metrics.json

phys::read_script /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.g
puts "\n** Restoration Completed **\n"


# Data Integrity Check
################################################################################
# program version
if {"[string_representation [::legacy::get_attribute program_version /]]" != "20.10-p001_1"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden program_version: 20.10-p001_1  current program_version: [string_representation [::legacy::get_attribute program_version /]]"
}
# license
if {"[string_representation [::legacy::get_attribute startup_license /]]" != "Genus_Synthesis"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-91] "golden license: Genus_Synthesis  current license: [string_representation [::legacy::get_attribute startup_license /]]"
}
# slack
set _slk_ [::legacy::get_attribute slack design:cva6]
if {[regexp {^-?[0-9.]+$} $_slk_]} {
  set _slk_ [format %.1f $_slk_]
}
if {$_slk_ != "-1460.9"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden slack: -1460.9,  current slack: $_slk_"
}
unset _slk_
# multi-mode slack
# tns
set _tns_ [::legacy::get_attribute tns design:cva6]
if {[regexp {^-?[0-9.]+$} $_tns_]} {
  set _tns_ [format %.0f $_tns_]
}
if {$_tns_ != "20619123"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden tns: 20619123,  current tns: $_tns_"
}
unset _tns_
# cell area
set _cell_area_ [::legacy::get_attribute cell_area design:cva6]
if {[regexp {^-?[0-9.]+$} $_cell_area_]} {
  set _cell_area_ [format %.0f $_cell_area_]
}
if {$_cell_area_ != "28679"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden cell area: 28679,  current cell area: $_cell_area_"
}
unset _cell_area_
# net area
set _net_area_ [::legacy::get_attribute net_area design:cva6]
if {[regexp {^-?[0-9.]+$} $_net_area_]} {
  set _net_area_ [format %.0f $_net_area_]
}
if {$_net_area_ != "0"} {
   mesg_send [::legacy::find -message /messages/PHYS/PHYS-92] "golden net area: 0,  current net area: $_net_area_"
}
unset _net_area_
