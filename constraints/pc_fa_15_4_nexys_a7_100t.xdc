## Nexys A7-100T Constraint File for pc_fa_15_4 Parallel Counter (FA-based)
## This file maps the 15-bit input to switches and 4-bit output to LEDs

## Clock signal (100MHz on Nexys A7-100T)
## Uncomment if you need a clock for your design
# set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
# create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Input mapping: 15-bit input 'd[14:0]' mapped to switches SW[14:0]
## Nexys A7-100T has 16 switches (SW[15:0]), we use the lower 15
set_property PACKAGE_PIN J15 [get_ports {d[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[0]}]
set_property PACKAGE_PIN L16 [get_ports {d[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[1]}]
set_property PACKAGE_PIN M13 [get_ports {d[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[2]}]
set_property PACKAGE_PIN R15 [get_ports {d[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[3]}]
set_property PACKAGE_PIN R17 [get_ports {d[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[4]}]
set_property PACKAGE_PIN T18 [get_ports {d[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[5]}]
set_property PACKAGE_PIN U18 [get_ports {d[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[6]}]
set_property PACKAGE_PIN R13 [get_ports {d[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[7]}]
set_property PACKAGE_PIN T8 [get_ports {d[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[8]}]
set_property PACKAGE_PIN U8 [get_ports {d[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[9]}]
set_property PACKAGE_PIN R16 [get_ports {d[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[10]}]
set_property PACKAGE_PIN T13 [get_ports {d[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[11]}]
set_property PACKAGE_PIN H6 [get_ports {d[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[12]}]
set_property PACKAGE_PIN U12 [get_ports {d[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[13]}]
set_property PACKAGE_PIN U11 [get_ports {d[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {d[14]}]

## Output mapping: 4-bit output 'count_out[3:0]' mapped to LEDs LD[3:0]
## These LEDs will show the binary count of '1's in the input (0-15)
set_property PACKAGE_PIN H17 [get_ports {count_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[0]}]
set_property PACKAGE_PIN K15 [get_ports {count_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[1]}]
set_property PACKAGE_PIN J13 [get_ports {count_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[2]}]
set_property PACKAGE_PIN N14 [get_ports {count_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {count_out[3]}]

## Optional: Additional LEDs to show input pattern for debugging
## Uncomment these lines if you want to see some of the input pattern on LEDs 4-15
# set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { d[0] }]  # LD4 = d[0]
# set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { d[1] }]  # LD5 = d[1]
# set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { d[2] }]  # LD6 = d[2]
# set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { d[3] }]  # LD7 = d[3]
# set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { d[4] }]  # LD8 = d[4]
# set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { d[5] }]  # LD9 = d[5]
# set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports { d[6] }]  # LD10 = d[6]
# set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { d[7] }]  # LD11 = d[7]
# set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { d[8] }]  # LD12 = d[8]
# set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { d[9] }]  # LD13 = d[9]
# set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { d[10] }] # LD14 = d[10]
# set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { d[11] }] # LD15 = d[11]

## Usage Instructions:
## 1. Set switches SW[14:0] to any 15-bit binary pattern
## 2. LEDs LD[3:0] will display the count of 1's in binary
## 3. For example: if you set SW[4:0] = 11111 (5 ones), LED display will be 0101 (binary 5)
## 4. Maximum count is 15 (binary 1111) when all switches are up

## Bitstream generation options
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design] 