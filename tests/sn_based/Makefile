# Makefile for Cocotb test of seven_sorter
# Place this Makefile in the tests/sn_based/ directory

# Top-level Verilog module
TOPLEVEL_LANG = verilog
VERILOG_SOURCES =../../parallel_counters/sn_based/7-sorter.v # This file now contains seven_sorter

# The VPI library for your simulator
# SIM = icarus
SIM = verilator
# SIM =questa
# SIM = modelsim
# SIM = riviera

# Python test module (local to this directory)
MODULE = test_seven_sorter # Will create this test file next

# Testcase (if specific testcase is needed, otherwise all tests in MODULE are run)
# TESTCASE = 

# Top-level entity name
TOPLEVEL = seven_sorter # Changed from eight_sorter

# Add current directory to PYTHONPATH for cocotb to find the local test module
export PYTHONPATH := $(shell pwd):$(PYTHONPATH)

# Include the cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim 