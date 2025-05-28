# FPGA 部署指南 - Nexys A7-100T

这个文件夹包含将并行计数器部署到 Nexys A7-100T FPGA 开发板的文件。提供了两种实现方式：排序网络版本（SN-based）和全加器版本（FA-based）。

## 📁 文件说明

### 排序网络版本 (SN-based)
- `pc_sn_7_3_top.v` - SN-based FPGA 顶层模块
- `../constraints/nexys_a7_100t.xdc` - SN-based 约束文件
- `README.md` - 主说明文件

### 全加器版本 (FA-based)
- `pc_fa_7_3_top.v` - FA-based FPGA 顶层模块  
- `../constraints/pc_fa_7_3_nexys_a7_100t.xdc` - FA-based 约束文件
- `README_FA_based.md` - FA-based 详细说明

## 🎯 选择合适的版本

| 特性 | SN-based 版本 | FA-based 版本 |
|------|---------------|---------------|
| **实现方式** | 排序网络 + 计数逻辑 | 全加器树结构 |
| **复杂度** | 更高（先排序后计数） | 更直接（直接加法） |
| **理解难度** | 需要理解排序网络 | 经典加法器设计 |
| **性能** | 可能更多逻辑层 | 通常更好的时序 |
| **推荐用途** | 学习排序网络概念 | 传统设计和产品应用 |

## 🔌 引脚映射

### 输入 (开关)
- `in[0]` ← SW0 (开关0)
- `in[1]` ← SW1 (开关1)  
- `in[2]` ← SW2 (开关2)
- `in[3]` ← SW3 (开关3)
- `in[4]` ← SW4 (开关4)
- `in[5]` ← SW5 (开关5)
- `in[6]` ← SW6 (开关6)

### 输出 (LED)
- `out[0]` → LD0 (LED0 - 最低位)
- `out[1]` → LD1 (LED1 - 中间位)
- `out[2]` → LD2 (LED2 - 最高位)

## 🚀 Vivado 部署步骤

### 1. 创建新项目
```
File → New Project → Next
Project Name: pc_sn_7_3_fpga
Project Location: 选择你的工作目录
Project Type: RTL Project
```

### 2. 添加源文件
在 Vivado 中添加以下文件：
```
- fpga/pc_sn_7_3_top.v (顶层模块)
- parallel_counters/sn_based/pc_sn_7_3.v
- parallel_counters/sn_based/7-sorter.v
```

### 3. 添加约束文件
```
添加 constraints/nexys_a7_100t.xdc
```

### 4. 选择目标器件
```
Parts: xc7a100tcsg324-1 (Nexys A7-100T)
```

### 5. 设置顶层模块
```
设置 pc_sn_7_3_top 为顶层模块
```

### 6. 综合和实现
```
Run Synthesis → Run Implementation → Generate Bitstream
```

### 7. 编程 FPGA
```
Open Hardware Manager → Connect to board → Program Device
```

## 🧪 测试方法

1. **基本测试**：
   - 将所有开关设为下位 (0000000) → LED应显示 000 (0个1)
   - 将SW0设为上位 (0000001) → LED应显示 001 (1个1)
   - 将SW0和SW1设为上位 (0000011) → LED应显示 010 (2个1)

2. **全面测试**：
   - 尝试不同的开关组合
   - 验证LED显示的二进制数等于开关中1的个数

## 📊 示例

| 开关状态 (SW6-SW0) | 1的个数 | LED输出 (LD2-LD0) |
|-------------------|--------|-------------------|
| 0000000          | 0      | 000               |
| 0000001          | 1      | 001               |
| 0000011          | 2      | 010               |
| 0000111          | 3      | 011               |
| 0001111          | 4      | 100               |
| 0011111          | 5      | 101               |
| 0111111          | 6      | 110               |
| 1111111          | 7      | 111               |

## ⚠️ 注意事项

1. 确保所有依赖的 Verilog 文件都添加到项目中
2. 约束文件中的端口名必须与顶层模块的端口名完全匹配
3. 如果需要调试，可以取消注释约束文件中的附加LED映射部分
4. 这是纯组合逻辑，不需要时钟信号

## 🔧 故障排除

- **综合错误**: 检查所有 Verilog 文件是否正确添加
- **实现错误**: 检查约束文件中的引脚分配
- **功能错误**: 使用仿真验证设计逻辑
- **时序错误**: 对于纯组合逻辑这应该不是问题 