# Makefile for Cocotb test of pc_fa_7_3
# Place this Makefile in the tests/fa_based/ directory

# Top-level Verilog module
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = ../../parallel_counters/fa_based/pc_fa_7_3.v ../../parallel_counters/common/full_adder.v
# The VPI library for your simulator
# SIM = icarus
SIM = verilator
# SIM = questa
# SIM = modelsim
# SIM = riviera

# Python test module (local to this directory)
MODULE = test_pc_fa_7_3

# Testcase (if specific testcase is needed, otherwise all tests in MODULE are run)
# TESTCASE = 

# Top-level entity name
TOPLEVEL = pc_fa_7_3

# Add current directory to PYTHONPATH for cocotb to find the local test module
export PYTHONPATH := $(shell pwd):$(PYTHONPATH)

# Include the cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim 