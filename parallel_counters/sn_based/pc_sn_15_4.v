module pc_sn_15_4(
    input [14:0] in,
    output [3:0] out
);

    wire [14:0] sorted_sequence;
    fifteen_sorter s0(
        .in1(in[0]), .in2(in[1]), .in3(in[2]), .in4(in[3]), .in5(in[4]),
        .in6(in[5]), .in7(in[6]), .in8(in[7]), .in9(in[8]), .in10(in[9]),
        .in11(in[10]), .in12(in[11]), .in13(in[12]), .in14(in[13]), .in15(in[14]),
        .out1(sorted_sequence[0]), .out2(sorted_sequence[1]), .out3(sorted_sequence[2]),
        .out4(sorted_sequence[3]), .out5(sorted_sequence[4]), .out6(sorted_sequence[5]),
        .out7(sorted_sequence[6]), .out8(sorted_sequence[7]), .out9(sorted_sequence[8]),
        .out10(sorted_sequence[9]), .out11(sorted_sequence[10]), .out12(sorted_sequence[11]),
        .out13(sorted_sequence[12]), .out14(sorted_sequence[13]), .out15(sorted_sequence[14])
    );
    
    // Assemble counter array - XOR adjacent bits to detect transitions
    wire [13:0] counter_array;
    assign counter_array[0] = sorted_sequence[14] ^ sorted_sequence[13];
    assign counter_array[1] = sorted_sequence[13] ^ sorted_sequence[12];
    assign counter_array[2] = sorted_sequence[12] ^ sorted_sequence[11];
    assign counter_array[3] = sorted_sequence[11] ^ sorted_sequence[10];
    assign counter_array[4] = sorted_sequence[10] ^ sorted_sequence[9];
    assign counter_array[5] = sorted_sequence[9] ^ sorted_sequence[8];
    assign counter_array[6] = sorted_sequence[8] ^ sorted_sequence[7];
    assign counter_array[7] = sorted_sequence[7] ^ sorted_sequence[6];
    assign counter_array[8] = sorted_sequence[6] ^ sorted_sequence[5];
    assign counter_array[9] = sorted_sequence[5] ^ sorted_sequence[4];
    assign counter_array[10] = sorted_sequence[4] ^ sorted_sequence[3];
    assign counter_array[11] = sorted_sequence[3] ^ sorted_sequence[2];
    assign counter_array[12] = sorted_sequence[2] ^ sorted_sequence[1];
    assign counter_array[13] = sorted_sequence[1] ^ sorted_sequence[0];
    
    // Output AND for the case when all lower bits are 1
    wire output_and;
    assign output_and = sorted_sequence[1] & sorted_sequence[0];
    
    // Binary encoding of the count using the counter array
    // Following the pattern from pc_sn_7_3.v but extended for 4 bits
    // Each counter_array[i] indicates a transition from 0 to 1 at position (14-i)
    
    // out[0] represents bit 0 of the binary count (LSB) - 1,3,5,7,9,11,13,15 
    assign out[0] = counter_array[12] | counter_array[10] | counter_array[8] | counter_array[6] | 
                    counter_array[4] | counter_array[2] | counter_array[0] | output_and;
    
    // out[1] represents bit 1 of the binary count - counts 2,3,6,7,10,11,14,15
    assign out[1] = counter_array[13] | counter_array[10] | counter_array[9] | counter_array[6] |
                    counter_array[5] | counter_array[2] | counter_array[1] | output_and;
    
    // out[2] represents bit 2 of the binary count - counts 4,5,6,7,12,13,14,15
    assign out[2] = counter_array[13] | counter_array[12] | counter_array[11] | counter_array[6] |
                    counter_array[5] | counter_array[4] | counter_array[3] | output_and;
    
    // out[3] represents bit 3 of the binary count (MSB) - counts 8,9,10,11,12,13,14,15
    assign out[3] = counter_array[13] | counter_array[12] | counter_array[11] | counter_array[10] |
                    counter_array[9] | counter_array[8] | counter_array[7] | output_and;

endmodule 