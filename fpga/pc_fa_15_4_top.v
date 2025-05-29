// Top-level module for FPGA deployment of pc_fa_15_4 parallel counter (FA-based)
// Target: Nexys A7-100T FPGA board
// Maps 15-bit input to switches SW[14:0] and 4-bit output to LEDs LD[3:0]

module pc_fa_15_4_top(
    // Input from switches SW[14:0]
    input [14:0] d,
    
    // Output to LEDs LD[3:0] - shows binary count of 1's in input
    output [3:0] count_out
    
    // Optional: Uncomment if you need clock
    // input clk,
    // input rst_n
);

    // Instantiate the FA-based parallel counter module
    pc_fa_15_4 counter_inst (
        .d(d),                  // 15-bit input from switches
        .count_out(count_out)   // 4-bit output to LEDs
    );

    // Optional: Add input/output buffering or synchronization if needed
    // For pure combinational logic like pc_fa_15_4, this is sufficient

endmodule

// Note: Make sure to include all required Verilog files in your Vivado project:
// 1. pc_fa_15_4_top.v (this file)
// 2. ../parallel_counters/fa_based/pc_fa_15_4.v
// 3. ../parallel_counters/fa_based/pc_fa_7_3.v
// 4. ../parallel_counters/common/full_adder.v 