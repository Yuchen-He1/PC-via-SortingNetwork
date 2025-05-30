// Single-stage 7-Sorter for 1-bit inputs/outputs
module sorter7_1bit (
  input  wire [6:0] In,   // In[0]..In[6]
  output wire [6:0] Out   // Out[0]..Out[6]
);

  //—— 1) Generate all pairwise comparisons ge[i][j] = (In[i] >= In[j]) ——//
  //    Only need N*(N−1)/2 comparisons, others filled by anti-symmetric complement
  wire ge [0:6][0:6];
  genvar i, j;
  generate
    for (i = 0; i < 7; i = i + 1) begin : GEN_GE_I
      for (j = 0; j < 7; j = j + 1) begin : GEN_GE_J
        if (i > j) begin
          assign ge[i][j] = (In[i] >= In[j]);
        end else if (i < j) begin
          assign ge[i][j] = ~ge[j][i];
        end else begin
          assign ge[i][j] = 1'b0; // Self-comparison not counted
        end
      end
    end
  endgenerate

  //—— 2) For each input i, sum ge[i][0..6] to get rank count cnt[i] (0..6) ——//
  wire [2:0] cnt [0:6];
  generate
    for (i = 0; i < 7; i = i + 1) begin : GEN_COUNT
      assign cnt[i] = ge[i][0] + ge[i][1]
                    + ge[i][2] + ge[i][3]
                    + ge[i][4] + ge[i][5]
                    + ge[i][6];
    end
  endgenerate

  //—— 3) Route corresponding input to output port based on cnt value ——//
  //    Out[k]=1 if and only if some input In[i]==1 and cnt[i]==k
  generate
    for (i = 0; i < 7; i = i + 1) begin : GEN_OUTPUT
      assign Out[i] =
           ((cnt[0] == i) && In[0])
         || ((cnt[1] == i) && In[1])
         || ((cnt[2] == i) && In[2])
         || ((cnt[3] == i) && In[3])
         || ((cnt[4] == i) && In[4])
         || ((cnt[5] == i) && In[5])
         || ((cnt[6] == i) && In[6]);
    end
  endgenerate

endmodule
