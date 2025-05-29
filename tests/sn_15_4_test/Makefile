# Makefile for Cocotb test of fifteen_sorter
# Place this Makefile in the tests/sn_test/sn_15_4_test/ directory

# Top-level Verilog module
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = ../../parallel_counters/sn_based/15-sorter.v # This file contains fifteen_sorter

# The VPI library for your simulator
# SIM = icarus
SIM = verilator
# SIM = questa
# SIM = modelsim
# SIM = riviera

# Python test module (local to this directory)
MODULE = test_fifteen_sorter # The test file we just created

# Testcase (if specific testcase is needed, otherwise all tests in MODULE are run)
# TESTCASE = 

# Top-level entity name
TOPLEVEL = fifteen_sorter # The module name in 15-sorter.v

# Add current directory to PYTHONPATH for cocotb to find the local test module
export PYTHONPATH := $(shell pwd):$(PYTHONPATH)

# Include the cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim 