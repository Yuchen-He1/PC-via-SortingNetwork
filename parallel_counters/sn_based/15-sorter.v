module two_sorter(
    input in0,
    input in1,
    output min,
    output max
);
    assign min = in0&in1;
    assign max = in0|in1;
endmodule

module four_sorter(
    input in0,
    input in1,
    input in2,
    input in3,
    output out0,
    output out1,
    output out2,
    output out3
);
    wire min0, max0;
    wire min1, max1;
    wire max2;
    wire min3;

    //first level
    two_sorter s0(in0, in1, min0, max0);
    two_sorter s1(in2, in3, min1, max1);
    //second level
    two_sorter s2(min0,min1,out0,max2);
    two_sorter s3(max0,max1,min3,out3);
    //third level
    two_sorter s4(min3,max2,out1,out2);
endmodule

module merger_2_2(
    input in0,
    input in1,
    input in2,
    input in3,
    output out0,
    output out1,
    output out2,
    output out3
);
    wire max0;
    wire min1;
    
    //first level
    two_sorter s0(in0,in2,out0,max0);
    two_sorter s1(in1,in3,min1,out3);
    //second level
    two_sorter s2(max0,min1,out1,out2);
endmodule 

module eight_sorter(
    input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    output out0,
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    output out6,
    output out7
);
    wire o0,o1,o2,o3,o4,o5,o6,o7;
    wire temp1,temp2,temp3,temp4,temp5,temp6;
    
    four_sorter s0(in0,in1,in2,in3,o0,o1,o2,o3);
    four_sorter s1(in4,in5,in6,in7,o4,o5,o6,o7);
    
    // even-odd merge
    merger_2_2 m0(o0,o2,o4,o6,out0,temp1,temp2,temp3);
    merger_2_2 m1(o1,o3,o5,o7,temp4,temp5,temp6,out7);
    
    // sort the rest
    two_sorter s2(temp1,temp4,out1,out2);
    two_sorter s3(temp2,temp5,out3,out4);
    two_sorter s4(temp3,temp6,out5,out6);
endmodule

// Merger for 4+4 sorted sequences using odd-even merge
module merger_4_4(
    input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    output out0,
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    output out6,
    output out7
);
    wire temp1,temp2,temp3,temp4,temp5,temp6;
    
    // even-odd merge
    merger_2_2 m0(in0,in2,in4,in6,out0,temp1,temp2,temp3);
    merger_2_2 m1(in1,in3,in5,in7,temp4,temp5,temp6,out7);
    
    // sort the rest
    two_sorter s0(temp1,temp4,out1,out2);
    two_sorter s1(temp2,temp5,out3,out4);
    two_sorter s2(temp3,temp6,out5,out6);
endmodule

// Merger for 8+8 sorted sequences using recursive odd-even merge
module merger_8_8(
    input in0, in1, in2, in3, in4, in5, in6, in7,
    input in8, in9, in10, in11, in12, in13, in14, in15,
    output out0, out1, out2, out3, out4, out5, out6, out7,
    output out8, out9, out10, out11, out12, out13, out14, out15
);
    wire temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
    wire temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
    
    // First level: merge even and odd positioned elements separately
    merger_4_4 m0(in0,in2,in4,in6,in8,in10,in12,in14,out0,temp1,temp3,temp5,temp7,temp9,temp11,temp13);
    merger_4_4 m1(in1,in3,in5,in7,in9,in11,in13,in15,temp0,temp2,temp4,temp6,temp8,temp10,temp12,out15);
    
    // Second level: merge the intermediate results
    two_sorter s0(temp0,temp1,out1,out2);
    two_sorter s1(temp2,temp3,out3,out4);
    two_sorter s2(temp4,temp5,out5,out6);
    two_sorter s3(temp6,temp7,out7,out8);
    two_sorter s4(temp8,temp9,out9,out10);
    two_sorter s5(temp10,temp11,out11,out12);
    two_sorter s6(temp12,temp13,out13,out14);
endmodule

module fifteen_sorter(
    //input in0,  // tied to 0
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    input in8,
    input in9,
    input in10,
    input in11,
    input in12,
    input in13,
    input in14,
    input in15,
    //output out0,  // will always be 0
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    output out6,
    output out7,
    output out8,
    output out9,
    output out10,
    output out11,
    output out12,
    output out13,
    output out14,
    output out15
);
    // 16 input sorting network adapted for 15 inputs
    // 15 sorter is simply delete 1 input from 16-sorter
    wire o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15;
    wire out0;
    wire in0 = 1'b0;  // tie unused input to 0
    
    // First level: sort two groups of 8
    eight_sorter s0(in0,in1,in2,in3,in4,in5,in6,in7,o0,o1,o2,o3,o4,o5,o6,o7);
    eight_sorter s1(in8,in9,in10,in11,in12,in13,in14,in15,o8,o9,o10,o11,o12,o13,o14,o15);
    
    // Second level: merge the two sorted groups using complete 8x8 merger
    merger_8_8 m0(o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,
                  out0,out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,out15);
endmodule