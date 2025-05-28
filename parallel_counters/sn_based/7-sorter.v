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
    wire min2, max2;
    wire min3, max3;
    //first level
    two_sorter s0(in0,in2,out0,max0);
    two_sorter s1(in1,in3,min1,out3);
    //second level
    two_sorter s2(max0,min1,out1,out2);
endmodule 


module seven_sorter(
    //input in0,
    input in1,
    input in2,
    input in3,
    input in4,
    input in5,
    input in6,
    input in7,
    //output out0,
    output out1,
    output out2,
    output out3,
    output out4,
    output out5,
    output out6,
    output out7
);
    //8 input even-odd sorting will cost 19 2-sorter
    //7 input is simply delete 1 input from 8 input even-odd sorting
    wire o0,o1,o2,o3,o4,o5,o6,o7;
    wire temp1,temp2,temp3,temp4,temp5,temp6;
    // //seven sorter is simply delete 1 input from 8-sorter
    wire out0;
    wire in0;
    four_sorter s0(in0,in1,in2,in3,o0,o1,o2,o3);
    four_sorter s1(in4,in5,in6,in7,o4,o5,o6,o7);
    // use even-odd merge
    merger_2_2 m0(o0,o2,o4,o6,out0,temp1,temp2,temp3);
    merger_2_2 m1(o1,o3,o5,o7,temp4,temp5,temp6,out7);
    // sort the rest
    two_sorter s2(temp1,temp4,out1,out2);
    two_sorter s3(temp2,temp5,out3,out4);
    two_sorter s4(temp3,temp6,out5,out6);

endmodule

// //seven sorter is simply delete 1 input from 8-sorter
// module seven_sorter(
//     input in0,
//     input in1,
//     input in2,
//     input in3,
//     input in4,
//     input in5,
//     input in6,
//     output out0,
//     output out1,
//     output out2,
//     output out3,
//     output out4,
//     output out5,
//     output out6
// );
//     eight_sorter s0(in0,in1,in2,in3,in4,in5,in6,in7,out0,out1,out2,out3,out4,out5,out6);
// endmodule