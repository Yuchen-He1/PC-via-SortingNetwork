module pc_fa_15_4(
    input  [14:0] d,
    output  [3:0] count_out
);

    wire [2:0] output1; // Outputs of pc_fa_7_3_1
    wire [2:0] output2; // Outputs of pc_fa_7_3_2
    wire c1, c2; // Carry wires
    
    pc_fa_7_3 pc_7_3_1(.d(d[6:0]), .count_out(output1[2:0]));
    pc_fa_7_3 pc_7_3_2(.d(d[13:7]), .count_out(output2[2:0]));
    
    full_adder fa0(.a(d[14]), .b(output2[0]), .cin(output1[0]), .sum(count_out[0]), .cout(c1));
    full_adder fa1(.a(c1), .b(output2[1]), .cin(output1[1]), .sum(count_out[1]), .cout(c2));
    full_adder fa2(.a(c2), .b(output2[2]), .cin(output1[2]), .sum(count_out[2]), .cout(count_out[3]));

endmodule

