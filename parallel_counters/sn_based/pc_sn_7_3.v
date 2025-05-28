module pc_sn_7_3(
    input [6:0] in,
    output [2:0] out
);

    wire [6:0] sorted_sequence;
    seven_sorter s0(in[0],in[1],in[2],in[3],in[4],in[5],in[6],
    sorted_sequence[0],sorted_sequence[1],sorted_sequence[2],sorted_sequence[3],sorted_sequence[4],sorted_sequence[5],sorted_sequence[6]);
    //aseemble counter array
    wire [5:0] counter_array;
    assign counter_array[0] = sorted_sequence[6] ^ sorted_sequence[5];
    assign counter_array[1] = sorted_sequence[5] ^ sorted_sequence[4];
    assign counter_array[2] = sorted_sequence[4] ^ sorted_sequence[3];
    assign counter_array[3] = sorted_sequence[3] ^ sorted_sequence[2];
    assign counter_array[4] = sorted_sequence[2] ^ sorted_sequence[1];
    assign counter_array[5] = sorted_sequence[1] ^ sorted_sequence[0];
    wire output_and;
    assign output_and = sorted_sequence[1] & sorted_sequence[0];
    assign out[0] = counter_array[0] | counter_array[2] | counter_array[4] | output_and;
    assign out[1] = counter_array[1] | counter_array[2] | counter_array[5] | output_and;
    assign out[2] = counter_array[3] | counter_array[4] | counter_array[5] | output_and;
endmodule