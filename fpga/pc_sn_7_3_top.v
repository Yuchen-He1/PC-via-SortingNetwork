// Top-level module for FPGA deployment of pc_sn_7_3 parallel counter
// Target: Nexys A7-100T FPGA board
// Maps 7-bit input to switches SW[6:0] and 3-bit output to LEDs LD[2:0]

module pc_sn_7_3_top(
    // Input from switches SW[6:0]
    input [6:0] in,
    
    // Output to LEDs LD[2:0] - shows binary count of 1's in input
    output [2:0] out
    
    // Optional: Uncomment if you need clock
    // input clk,
    // input rst_n
);

    // Instantiate the parallel counter module
    pc_sn_7_3 counter_inst (
        .in(in),    // 7-bit input from switches
        .out(out)   // 3-bit output to LEDs
    );

    // Optional: Add input/output buffering or synchronization if needed
    // For pure combinational logic like pc_sn_7_3, this is sufficient

endmodule

// Note: Make sure to include all required Verilog files in your Vivado project:
// 1. pc_sn_7_3_top.v (this file)
// 2. ../parallel_counters/sn_based/pc_sn_7_3.v
// 3. ../parallel_counters/sn_based/7-sorter.v 