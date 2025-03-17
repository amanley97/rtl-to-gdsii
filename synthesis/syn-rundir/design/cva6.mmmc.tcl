#################################################################################
#
# Created by Genus(TM) Synthesis Solution 20.10-p001_1 on Thu Mar 13 19:28:39 UTC 2025
#
#################################################################################

## library_sets
create_library_set -name default_emulate_libset_max \
    -timing { /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_TT_ccs_211120.lib \
              /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SEQ_RVT_TT_ccs_220123.lib \
              /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_INVBUF_RVT_TT_ccs_220122.lib \
              /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_SS_ccs_211120.lib \
              /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SIMPLE_RVT_FF_ccs_211120.lib \
              /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/../tech/asap7/../extracted_libs/asap7sc7p5t_SEQ_RVT_SS_ccs_220123.lib }

## opcond
create_opcond -name default_emulate_opcond \
    -process 1.0 \
    -voltage 0.699999 \
    -temperature 25.0

## timing_condition
create_timing_condition -name default_emulate_timing_cond_max \
    -opcond default_emulate_opcond \
    -library_sets { default_emulate_libset_max }

## rc_corner
create_rc_corner -name default_emulate_rc_corner \
    -temperature 25.0 \
    -pre_route_res 1.0 \
    -pre_route_cap 1.0 \
    -pre_route_clock_res 0.0 \
    -pre_route_clock_cap 0.0 \
    -post_route_res {1.0 1.0 1.0} \
    -post_route_cap {1.0 1.0 1.0} \
    -post_route_cross_cap {1.0 1.0 1.0} \
    -post_route_clock_res {1.0 1.0 1.0} \
    -post_route_clock_cap {1.0 1.0 1.0}

## delay_corner
create_delay_corner -name default_emulate_delay_corner \
    -early_timing_condition { default_emulate_timing_cond_max } \
    -late_timing_condition { default_emulate_timing_cond_max } \
    -early_rc_corner default_emulate_rc_corner \
    -late_rc_corner default_emulate_rc_corner

## constraint_mode
create_constraint_mode -name default_emulate_constraint_mode \
    -sdc_files { /moosefs/scratch/a599m019/rtl-to-gdsii/synthesis/cva6.default_emulate_constraint_mode.sdc }

## analysis_view
create_analysis_view -name default_emulate_view \
    -constraint_mode default_emulate_constraint_mode \
    -delay_corner default_emulate_delay_corner

## set_analysis_view
set_analysis_view -setup { default_emulate_view } \
                  -hold { default_emulate_view }
