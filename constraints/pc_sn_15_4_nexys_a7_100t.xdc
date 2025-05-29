## Nexys A7-100T Constraint File for pc_sn_15_4 Parallel Counter
## This file maps the 15-bit input to switches and 4-bit output to LEDs

## Clock signal (100MHz on Nexys A7-100T)
## Uncomment if you need a clock for your design
# set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
# create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Input mapping: 15-bit input 'in[14:0]' mapped to switches SW[14:0]
## Nexys A7-100T has 16 switches (SW[15:0]), we use the lower 15
set_property PACKAGE_PIN J15 [get_ports {in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[0]}]
set_property PACKAGE_PIN L16 [get_ports {in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[1]}]
set_property PACKAGE_PIN M13 [get_ports {in[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[2]}]
set_property PACKAGE_PIN R15 [get_ports {in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[3]}]
set_property PACKAGE_PIN R17 [get_ports {in[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[4]}]
set_property PACKAGE_PIN T18 [get_ports {in[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[5]}]
set_property PACKAGE_PIN U18 [get_ports {in[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[6]}]
set_property PACKAGE_PIN R13 [get_ports {in[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[7]}]
set_property PACKAGE_PIN T8 [get_ports {in[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[8]}]
set_property PACKAGE_PIN U8 [get_ports {in[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[9]}]
set_property PACKAGE_PIN R16 [get_ports {in[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[10]}]
set_property PACKAGE_PIN T13 [get_ports {in[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[11]}]
set_property PACKAGE_PIN H6 [get_ports {in[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[12]}]
set_property PACKAGE_PIN U12 [get_ports {in[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[13]}]
set_property PACKAGE_PIN U11 [get_ports {in[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {in[14]}]

## Output mapping: 4-bit output 'out[3:0]' mapped to LEDs LD[3:0]
## These LEDs will show the binary count of '1's in the input (0-15)
set_property PACKAGE_PIN H17 [get_ports {out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[0]}]
set_property PACKAGE_PIN K15 [get_ports {out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[1]}]
set_property PACKAGE_PIN J13 [get_ports {out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[2]}]
set_property PACKAGE_PIN N14 [get_ports {out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[3]}]

## Optional: Additional LEDs to show input pattern for debugging
## Uncomment these lines if you want to see some of the input pattern on LEDs 4-15
# set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { in[0] }]  # LD4 = in[0]
# set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { in[1] }]  # LD5 = in[1]
# set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { in[2] }]  # LD6 = in[2]
# set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { in[3] }]  # LD7 = in[3]
# set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { in[4] }]  # LD8 = in[4]
# set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { in[5] }]  # LD9 = in[5]
# set_property -dict { PACKAGE_PIN U14 IOSTANDARD LVCMOS33 } [get_ports { in[6] }]  # LD10 = in[6]
# set_property -dict { PACKAGE_PIN T16 IOSTANDARD LVCMOS33 } [get_ports { in[7] }]  # LD11 = in[7]
# set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { in[8] }]  # LD12 = in[8]
# set_property -dict { PACKAGE_PIN V14 IOSTANDARD LVCMOS33 } [get_ports { in[9] }]  # LD13 = in[9]
# set_property -dict { PACKAGE_PIN V12 IOSTANDARD LVCMOS33 } [get_ports { in[10] }] # LD14 = in[10]
# set_property -dict { PACKAGE_PIN V11 IOSTANDARD LVCMOS33 } [get_ports { in[11] }] # LD15 = in[11]

## Usage Instructions:
## 1. Set switches SW[14:0] to any 15-bit binary pattern
## 2. LEDs LD[3:0] will display the count of 1's in binary
## 3. For example: if you set SW[4:0] = 11111 (5 ones), LED display will be 0101 (binary 5)
## 4. Maximum count is 15 (binary 1111) when all switches are up

## Configuration options
## Disable DCI cascade to improve timing
set_property DCI_CASCADE {32 34} [get_iobanks 32]

## Bitstream generation options
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design] 

#create_clock -name COMB_CLK -period 1000 [get_ports *] 