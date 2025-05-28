# FPGA Deployment Guide - Nexys A7-100T

This folder contains files for deploying parallel counters to the Nexys A7-100T FPGA development board. Two implementation approaches are provided: Sorting Network-based (SN-based) and Full Adder-based (FA-based).

## 📁 File Structure

### Sorting Network Version (SN-based)
- `pc_sn_7_3_top.v` - SN-based FPGA top-level module
- `../constraints/nexys_a7_100t.xdc` - SN-based constraint file
- `README.md` - Main documentation file

### Full Adder Version (FA-based)
- `pc_fa_7_3_top.v` - FA-based FPGA top-level module  
- `../constraints/pc_fa_7_3_nexys_a7_100t.xdc` - FA-based constraint file
- `README_FA_based.md` - FA-based detailed documentation

## 🎯 Choosing the Right Version

| Feature | SN-based Version | FA-based Version |
|---------|------------------|------------------|
| **Implementation** | Sorting network + counting logic | Full adder tree structure |
| **Complexity** | Higher (sort then count) | More direct (direct addition) |
| **Learning Curve** | Requires understanding sorting networks | Classic adder design |
| **Performance** | May have more logic levels | Usually better timing |
| **Recommended Use** | Learning sorting network concepts | Traditional design and production |

## 🔌 Pin Mapping

### Input (Switches)
- `in[0]` ← SW0 (Switch 0)
- `in[1]` ← SW1 (Switch 1)  
- `in[2]` ← SW2 (Switch 2)
- `in[3]` ← SW3 (Switch 3)
- `in[4]` ← SW4 (Switch 4)
- `in[5]` ← SW5 (Switch 5)
- `in[6]` ← SW6 (Switch 6)

### Output (LEDs)
- `out[0]` → LD0 (LED 0 - LSB)
- `out[1]` → LD1 (LED 1 - Middle bit)
- `out[2]` → LD2 (LED 2 - MSB)

## 🚀 Vivado Deployment Steps

### 1. Create New Project
```
File → New Project → Next
Project Name: pc_sn_7_3_fpga
Project Location: Choose your working directory
Project Type: RTL Project
```

### 2. Add Source Files
Add the following files in Vivado:
```
- fpga/pc_sn_7_3_top.v (Top-level module)
- parallel_counters/sn_based/pc_sn_7_3.v
- parallel_counters/sn_based/7-sorter.v
```

### 3. Add Constraint File
```
Add constraints/nexys_a7_100t.xdc
```

### 4. Select Target Device
```
Parts: xc7a100tcsg324-1 (Nexys A7-100T)
```

### 5. Set Top Module
```
Set pc_sn_7_3_top as top module
```

### 6. Synthesis and Implementation
```
Run Synthesis → Run Implementation → Generate Bitstream
```

### 7. Program FPGA
```
Open Hardware Manager → Connect to board → Program Device
```

## 🧪 Testing Methods

1. **Basic Test**：
   - Set all switches down (0000000) → LEDs should show 000 (0 ones)
   - Set SW0 up (0000001) → LEDs should show 001 (1 one)
   - Set SW0 and SW1 up (0000011) → LEDs should show 010 (2 ones)

2. **Comprehensive Test**：
   - Try different switch combinations
   - Verify LED display shows binary count equal to number of 1's in switches

## 📊 Examples

| Switch State (SW6-SW0) | Number of 1's | LED Output (LD2-LD0) |
|------------------------|---------------|----------------------|
| 0000000               | 0             | 000                  |
| 0000001               | 1             | 001                  |
| 0000011               | 2             | 010                  |
| 0000111               | 3             | 011                  |
| 0001111               | 4             | 100                  |
| 0011111               | 5             | 101                  |
| 0111111               | 6             | 110                  |
| 1111111               | 7             | 111                  |

## ⚠️ Important Notes

1. Ensure all dependent Verilog files are added to the project
2. Port names in constraint file must exactly match top module port names
3. For debugging, uncomment additional LED mapping sections in constraint file
4. This is pure combinational logic, no clock signal needed

## 🔧 Troubleshooting

- **Synthesis Error**: Check if all Verilog files are properly added
- **Implementation Error**: Check pin assignments in constraint file
- **Functional Error**: Use simulation to verify design logic
- **Timing Error**: Should not be an issue for pure combinational logic 