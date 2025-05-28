# Makefile for Cocotb test of pc_sn_7_3 (SN-based parallel counter)
# Place this Makefile in the tests/pc_sn_based_test/ directory

# Top-level Verilog module
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = \
    ../../parallel_counters/sn_based/7-sorter.v \
    ../../parallel_counters/sn_based/pc_sn_7_3.v

# The VPI library for your simulator
# SIM = icarus
SIM = verilator
# SIM = questa
# SIM = modelsim
# SIM = riviera

# Python test module (local to this directory)
MODULE = test_pc_sn_7_3

# Testcase (if specific testcase is needed, otherwise all tests in MODULE are run)
# TESTCASE = 

# Top-level entity name
TOPLEVEL = pc_sn_7_3

# Add current directory to PYTHONPATH for cocotb to find the local test module
export PYTHONPATH := $(shell pwd):$(PYTHONPATH)

# Include the cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim 