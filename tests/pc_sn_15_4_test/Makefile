# Makefile for Cocotb test of pc_sn_15_4
# Place this Makefile in the tests/sn_test/sn_15_4_test/ directory

# Top-level Verilog module
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = ../../parallel_counters/sn_based/15-sorter.v ../../parallel_counters/sn_based/pc_sn_15_4.v

# The VPI library for your simulator
# SIM = icarus
SIM = verilator
# SIM = questa
# SIM = modelsim
# SIM = riviera

# Python test module (local to this directory)
MODULE = test_pc_sn_15_4 # The test file we just created

# Testcase (if specific testcase is needed, otherwise all tests in MODULE are run)
# TESTCASE = 

# Top-level entity name
TOPLEVEL = pc_sn_15_4 # The module name in pc_sn_15_4.v

# Add current directory to PYTHONPATH for cocotb to find the local test module
export PYTHONPATH := $(shell pwd):$(PYTHONPATH)

# Include the cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim 