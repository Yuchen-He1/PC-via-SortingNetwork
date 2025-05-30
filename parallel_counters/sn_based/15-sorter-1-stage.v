module sorter15_1bit (
  input  wire [14:0] In,   // In[0]..In[14]
  output wire [14:0] Out   // Out[0]..Out[14]
);

  // 1. Generate all pairwise comparison signals (N*(N-1)/2 = 105 comparators)
  wire  ge [0:14][0:14];
  genvar i, j;
  generate
    for (i = 0; i < 15; i = i + 1) begin : GEN_GE_I
      for (j = 0; j < 15; j = j + 1) begin : GEN_GE_J
        if (i > j) begin
          // Only compute upper triangular matrix (i > j)
          assign ge[i][j] = (In[i] >= In[j]);
        end else if (i < j) begin
          // Lower triangle takes anti-symmetric values from upper triangle
          assign ge[i][j] = ~ge[j][i];
        end else begin
          // Diagonal not used
          assign ge[i][j] = 1'b0;
        end
      end
    end
  endgenerate

  // 2. Calculate rank count for each input (cnt[i] = number of inputs this input >= other inputs)
  wire [3:0] cnt [0:14];  // 4-bit counter (0-14)
  generate
    for (i = 0; i < 15; i = i + 1) begin : GEN_COUNT
      // Sum comparison results for each row (excluding diagonal)
      assign cnt[i] = 
          ge[i][ 0] + ge[i][ 1] + ge[i][ 2] + ge[i][ 3] + ge[i][ 4]
        + ge[i][ 5] + ge[i][ 6] + ge[i][ 7] + ge[i][ 8] + ge[i][ 9]
        + ge[i][10] + ge[i][11] + ge[i][12] + ge[i][13] + ge[i][14];
    end
  endgenerate

  // 3. Route inputs to corresponding output ports
  generate
    for (i = 0; i < 15; i = i + 1) begin : GEN_OUTPUT
      // Output port i value = OR of all inputs In[j] where cnt[j]==i
      assign Out[i] = 
           ((cnt[ 0] == i) & In[ 0])
        || ((cnt[ 1] == i) & In[ 1])
        || ((cnt[ 2] == i) & In[ 2])
        || ((cnt[ 3] == i) & In[ 3])
        || ((cnt[ 4] == i) & In[ 4])
        || ((cnt[ 5] == i) & In[ 5])
        || ((cnt[ 6] == i) & In[ 6])
        || ((cnt[ 7] == i) & In[ 7])
        || ((cnt[ 8] == i) & In[ 8])
        || ((cnt[ 9] == i) & In[ 9])
        || ((cnt[10] == i) & In[10])
        || ((cnt[11] == i) & In[11])
        || ((cnt[12] == i) & In[12])
        || ((cnt[13] == i) & In[13])
        || ((cnt[14] == i) & In[14]);
    end
  endgenerate

endmodule