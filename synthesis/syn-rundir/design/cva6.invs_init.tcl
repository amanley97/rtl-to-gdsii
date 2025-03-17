################################################################################
#
# Init setup file
# Created by Genus(TM) Synthesis Solution on 03/13/2025 19:30:29
#
################################################################################

      if { ![is_common_ui_mode] } {
        error "This script must be loaded into an 'innovus -stylus' session."
      }
    


read_mmmc /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.mmmc.tcl

read_netlist /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.v

init_design
