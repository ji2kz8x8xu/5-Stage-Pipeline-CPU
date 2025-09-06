/*
module HiLo(clk, DivAns, HiOut, LoOut, reset);
  input        clk ;
  input        reset ;
  input [63:0] DivAns;
  
  output reg [31:0] HiOut;
  output reg [31:0] LoOut;
  
  always@(posedge clk) begin
    if (reset) begin
      HiOut <= 32'b0;
      LoOut <= 32'b0;
    end else begin
      HiOut <= DivAns[63:32];
      LoOut <= DivAns[31:0];
    end
  end
endmodule
*/
module HiLo(clk, DivAns, HiOut, LoOut, reset);
  input        clk ;
  input        reset ;
  input [63:0] DivAns;
  
  output reg [31:0] HiOut;
  output reg [31:0] LoOut;
  
  always@(posedge clk) begin
    if (reset) begin
      HiOut <= 32'b0;
      LoOut <= 32'b0;
    end else begin
      HiOut <= DivAns[63:32];
      LoOut <= DivAns[31:0];
    end
  end
  endmodule