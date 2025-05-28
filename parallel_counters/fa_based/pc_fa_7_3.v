// (7;3)counter via FA - Refactored
module pc_fa_7_3(
    input logic [6:0] d,
    output logic [2:0] count_out
);

    wire s1, c1; // Outputs of fa0
    wire s2, c2; // Outputs of fa1
    wire c3;     // Carry from fa2

    full_adder fa0(
        .a(d[0]), .b(d[1]), .cin(d[2]),
        .sum(s1), .cout(c1)
    );

    full_adder fa1(
        .a(d[3]), .b(d[4]), .cin(d[5]),
        .sum(s2), .cout(c2)
    );

    full_adder fa2(
        .a(s1), .b(s2), .cin(d[6]),
        .sum(count_out[0]), .cout(c3)
    );

    full_adder fa3(
        .a(c1), .b(c2), .cin(c3),
        .sum(count_out[1]), .cout(count_out[2])
    );

endmodule 