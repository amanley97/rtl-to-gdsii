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

PROJECT_ROOT	     ?= $(shell pwd)
SINGULARITY	     ?= False
DESIGN_NAME          ?= cva6
PERIOD               ?= 17
FOUNDRY_PATH         ?= $(PROJECT_ROOT)/../tech/asap7
LOCAL_LIB_PATH       ?= $(FOUNDRY_PATH)/../extracted_libs

# Only necessary asap7 libraries
SYNTH_LIBS := \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_SIMPLE_RVT_TT_ccs_211120.lib \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_SEQ_RVT_TT_ccs_220123.lib \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_INVBUF_RVT_TT_ccs_220122.lib \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_SIMPLE_RVT_SS_ccs_211120.lib \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_SIMPLE_RVT_FF_ccs_211120.lib \
    $(LOCAL_LIB_PATH)/asap7sc7p5t_SEQ_RVT_SS_ccs_220123.lib

TARGET_LIBRARY_FILES  = "$(SYNTH_LIBS)"
INPUT_DELAY          ?= 0.46
OUTPUT_DELAY         ?= 0.11
NAND2_AREA           ?= 1120
TARGET               ?= cv32a65x

EXPORT_LIST=SNPSLMD_QUEUE=TRUE TECH_NAME=$(TECH_NAME) DESIGN_NAME=$(DESIGN_NAME) TARGET=$(TARGET) TERM=vt100 PERIOD=$(PERIOD) FOUNDRY_PATH=$(FOUNDRY_PATH) LOCAL_LIB_PATH=$(LOCAL_LIB_PATH) TARGET_LIBRARY_FILES=$(TARGET_LIBRARY_FILES) INPUT_DELAY=$(INPUT_DELAY) OUTPUT_DELAY=$(OUTPUT_DELAY)

SINGULARITY_EXPORTS := \
    SINGULARITYENV_TECH_NAME=$(TECH_NAME) \
    SINGULARITYENV_DESIGN_NAME=$(DESIGN_NAME) \
    SINGULARITYENV_TARGET=$(TARGET) \
    SINGULARITYENV_TERM=vt100 \
    SINGULARITYENV_PERIOD=$(PERIOD) \
    SINGULARITYENV_FOUNDRY_PATH=$(FOUNDRY_PATH) \
    SINGULARITYENV_LOCAL_LIB_PATH=$(LOCAL_LIB_PATH) \
    SINGULARITYENV_TARGET_LIBRARY_FILES=$(TARGET_LIBRARY_FILES) \
    SINGULARITYENV_INPUT_DELAY=$(INPUT_DELAY) \
    SINGULARITYENV_OUTPUT_DELAY=$(OUTPUT_DELAY) \
    SINGULARITYENV_NAND2_AREA=$(NAND2_AREA)

# Create Flist with proper compilation order for synthesis
pre_cva6_synth:
	@echo "Filtering Flist.cva6 for synthesis..."
	grep "{\w*}" ../cva6/core/Flist.cva6 | \
		grep -v "instr_tracer" | \
		grep -v "incdir" | \
		grep -v "hpdcache.Flist" | \
		grep -v "fpga-support" > Flist.cva6_synth

	grep "{\w*}" ../cva6/core/cache_subsystem/hpdcache/rtl/hpdcache.Flist | \
		grep -v "incdir" >> Flist.cva6_synth

	grep "hpdcache_pkg.sv" Flist.cva6_synth > hpdcache_pkg.tmp
	grep "_pkg.sv" Flist.cva6_synth | grep -v "hpdcache_pkg.sv" > packages.tmp
	grep -v "hpdcache_pkg.sv" Flist.cva6_synth | grep -v "HPDCACHE_TARGET_CFG" | grep -v "_pkg.sv" > rtl.tmp

	cat packages.tmp > Flist.cva6_synth
	cat hpdcache_pkg.tmp >> Flist.cva6_synth
	cat rtl.tmp >> Flist.cva6_synth

# CVA6 Synthesis using Genus
cva6_synth:
	@echo "Synthesizing CVA6 with Genus..."
	@echo "Period=$(PERIOD)"
	@if [ "$(SINGULARITY)" = "True" ]; then \
		echo "Mode: Singularity..."; \
		$(SINGULARITY_EXPORTS) genus -f $(PROJECT_ROOT)/tcl/genus_minimal.tcl -log synthesis_batch.log; \
	else \
		echo "Running locally..."; \
		export $(EXPORT_LIST); genus -f $(PROJECT_ROOT)/tcl/genus_synth.tcl -log synthesis_batch.log; \
	fi
	python ../cva6/pd/synth/scripts/gate_analysis.py '$(DESIGN_NAME)_$(TARGET)/$(PERIOD)/reports/$(DESIGN_NAME)_$(TECH_NAME)_synth_area.rpt' $(NAND2_AREA)
	mv $(DESIGN_NAME)_synth.v $(DESIGN_NAME)_$(TARGET)_synth.v
	mv $(DESIGN_NAME)_synth.v.sdf $(DESIGN_NAME)_$(TARGET)_synth.v.sdf
	sed -i 's/cva6_ /cva6 /g' $(DESIGN_NAME)_$(TARGET)_synth.v
	echo $(NAND2_AREA) > $(DESIGN_NAME)_$(TARGET)/nand2area.txt

# Run the Genus Synthesis Flow for cv32a65x
rm_synth: pre_cva6_synth
	@echo "Running Genus synthesis for CVA6 target $(TARGET)..."
	@echo $(PERIOD)
	cp Flist.cva6_synth ../../cva6/$(SYNTH_FLOW_NAME)/synth/
	CVA6_REPO_DIR=$(CVA6_REPO_DIR) make -C ../../cva6/$(SYNTH_FLOW_NAME)/synth/ platform_synth_topo
	sed -i -n -e '/module hpdcache_sram_wbyteenable_1rw_00000007_00000040_00000080/,/endmodule/!p' $(DESIGN_NAME)_$(TARGET)_synth.v
	sed -i -n -e '/module hpdcache_sram_1rw_00000006_0000001c_00000040/,/endmodule/!p' $(DESIGN_NAME)_$(TARGET)_synth.v
	echo $(NAND2_AREA) > $(DESIGN_NAME)_$(TARGET)/nand2area.txt

# Read Synthesized CVA6 Design in Genus GUI
cva6_read:
	@export $(EXPORT_LIST); genus -f tcl/cva6_read.tcl -gui

# Cleanup temporary files and synthesis output
clean:
	@rm -rf work alib* *_LIB *log *svf netlist reports ${DESIGN_NAME}_${TARGET}
