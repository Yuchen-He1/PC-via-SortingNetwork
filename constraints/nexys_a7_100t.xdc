## Nexys A7-100T Constraint File for pc_sn_7_3 Parallel Counter
## This file maps the 7-bit input to switches and 3-bit output to LEDs

## Clock signal (100MHz on Nexys A7-100T)
## Uncomment if you need a clock for your design
# set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
# create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

## Input mapping: 7-bit input 'in[6:0]' mapped to switches SW[6:0]
## Nexys A7-100T has 16 switches (SW[15:0]), we use the lower 7
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

## Output mapping: 3-bit output 'out[2:0]' mapped to LEDs LD[2:0]
## These LEDs will show the binary count of '1's in the input
set_property PACKAGE_PIN H17 [get_ports {out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[0]}]
set_property PACKAGE_PIN K15 [get_ports {out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[1]}]
set_property PACKAGE_PIN J13 [get_ports {out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[2]}]

## Optional: Additional LEDs to show input pattern for debugging
## Uncomment these lines if you want to see the input pattern on LEDs 3-9
# set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { in[0] }]  # LD3 = in[0]
# set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { in[1] }]  # LD4 = in[1]
# set_property -dict { PACKAGE_PIN V17 IOSTANDARD LVCMOS33 } [get_ports { in[2] }]  # LD5 = in[2]
# set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { in[3] }]  # LD6 = in[3]
# set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { in[4] }]  # LD7 = in[4]
# set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { in[5] }]  # LD8 = in[5]
# set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { in[6] }]  # LD9 = in[6]

## Additional LEDs available for other purposes (LD10-LD15)
## Nexys A7-100T has 16 LEDs total: LD0-LD15

## Configuration options
## Disable DCI cascade to improve timing
set_property DCI_CASCADE {32 34} [get_iobanks 32]

## Bitstream generation options
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design] 

#create_clock -name COMB_CLK -period 1000 [get_ports *]