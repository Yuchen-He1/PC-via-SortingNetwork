# FPGA Deployment Guide - FA-based Parallel Counter (Nexys A7-100T)

This folder contains files for deploying the `pc_fa_7_3` full adder-based parallel counter to the Nexys A7-100T FPGA development board.

## 📁 File Structure

- `pc_fa_7_3_top.v` - FA-based parallel counter FPGA top-level module
- `../constraints/pc_fa_7_3_nexys_a7_100t.xdc` - Constraint file (pin mapping)
- `README_FA_based_EN.md` - This documentation file

## 🔌 Pin Mapping

### Input (Switches)
- `d[0]` ← SW0 (Switch 0)
- `d[1]` ← SW1 (Switch 1)  
- `d[2]` ← SW2 (Switch 2)
- `d[3]` ← SW3 (Switch 3)
- `d[4]` ← SW4 (Switch 4)
- `d[5]` ← SW5 (Switch 5)
- `d[6]` ← SW6 (Switch 6)

### Output (LEDs)
- `count_out[0]` → LD0 (LED 0 - LSB)
- `count_out[1]` → LD1 (LED 1 - Middle bit)
- `count_out[2]` → LD2 (LED 2 - MSB)

## 🏗️ Design Architecture

The FA-based parallel counter is built using Full Adders:
- **fa0**: Processes d[2:0] (first 3 bits)
- **fa1**: Processes d[5:3] (middle 3 bits)  
- **fa2**: Combines sums from fa0, fa1 with d[6]
- **fa3**: Combines all carries to produce final output

## 🚀 Vivado Deployment Steps

### 1. Create New Project
```
File → New Project → Next
Project Name: pc_fa_7_3_fpga
Project Location: Choose your working directory
Project Type: RTL Project
```

### 2. Add Source Files
Add the following files in Vivado:
```
- fpga/pc_fa_7_3_top.v (FA-based top-level module)
- parallel_counters/fa_based/pc_fa_7_3.v
- parallel_counters/common/full_adder.v
```

### 3. Add Constraint File
```
Add constraints/pc_fa_7_3_nexys_a7_100t.xdc
```

### 4. Select Target Device
```
Parts: xc7a100tcsg324-1 (Nexys A7-100T)
```

### 5. Set Top Module
```
Set pc_fa_7_3_top as top module
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

### Basic Functionality Tests
1. **Zero Input Test**：
   - All switches down (0000000) → LEDs show 000 (0 ones)

2. **Single Input Tests**：
   - SW0 up (0000001) → LEDs show 001 (1 one)
   - SW1 up (0000010) → LEDs show 001 (1 one)

3. **Multiple Input Tests**：
   - SW0,SW1 up (0000011) → LEDs show 010 (2 ones)
   - SW0,SW1,SW2 up (0000111) → LEDs show 011 (3 ones)

### Full Adder Cascade Verification
4. **Cascade Tests**：
   - Test individual full adder operations:
   - fa0: d[2:0] = 111 → should produce sum=1, carry=1
   - fa1: d[5:3] = 111 → should produce sum=1, carry=1  
   - fa2: combines two sums with d[6]
   - fa3: combines all carries

## 📊 Test Examples

| Switch State (SW6-SW0) | Decimal | Number of 1's | LED Output (LD2-LD0) | Description |
|------------------------|---------|---------------|----------------------|-------------|
| 0000000               | 0       | 0             | 000                  | All zeros   |
| 0000001               | 1       | 1             | 001                  | Single bit  |
| 0000011               | 3       | 2             | 010                  | Two bits    |
| 0000111               | 7       | 3             | 011                  | Three bits  |
| 0001111               | 15      | 4             | 100                  | Four bits   |
| 0011111               | 31      | 5             | 101                  | Five bits   |
| 0111111               | 63      | 6             | 110                  | Six bits    |
| 1111111               | 127     | 7             | 111                  | All ones    |
| 1010101               | 85      | 4             | 100                  | Alternating |

## 🔍 Differences from SN-based Version

| Feature | FA-based | SN-based |
|---------|----------|----------|
| **Basic Unit** | Full Adder | Sorting network + 2-sorter |
| **Hierarchy** | 4 cascaded full adders | Sorter + counter logic |
| **Port Names** | `d[6:0]`, `count_out[2:0]` | `in[6:0]`, `out[2:0]` |
| **Dependencies** | `full_adder.v` | `7-sorter.v` |
| **Complexity** | Relatively simple, direct counting | More complex, sort then count |

## ⚠️ Important Notes

1. **Port Matching**: FA-based version uses `d` and `count_out` port names
2. **Dependencies**: Ensure `full_adder.v` is included, not sorting network files
3. **Constraint File**: Use the dedicated `pc_fa_7_3_nexys_a7_100t.xdc`
4. **Functional Verification**: Both versions have identical functionality but different implementations

## 🔧 Troubleshooting

- **Synthesis Error**: Check if `full_adder.v` file is included
- **Port Error**: Confirm port names in constraint file match top module
- **Functional Error**: Compare FA-based and SN-based version outputs
- **Timing Issues**: FA-based version should have better timing characteristics

## 🏆 Performance Comparison

Advantages of FA-based parallel counter:
- **More Direct Implementation**: Uses classic full adder tree structure
- **Better Timing**: Fewer logic levels
- **Easier to Understand**: Traditional adder cascade approach
- **Resource Efficiency**: May use fewer LUT resources

## 🎓 Educational Value

The FA-based approach is excellent for:
- **Learning Digital Design**: Classic adder-based counting
- **Understanding Carry Propagation**: Clear visualization of carry chains
- **FPGA Resource Optimization**: Demonstrates efficient LUT usage
- **Timing Analysis**: Simpler critical path analysis

## 🔄 Design Verification

Both implementations (FA-based and SN-based) provide identical functionality:
- **Input**: 7-bit vector representing data to count
- **Output**: 3-bit binary count of 1's in input
- **Operation**: Pure combinational logic, no clock required
- **Range**: Correctly handles 0 to 7 ones in input

The choice between implementations depends on:
- **Learning objectives** (understanding different design paradigms)
- **Performance requirements** (timing vs. area trade-offs)
- **Design methodology preferences** (arithmetic vs. sorting approaches) 