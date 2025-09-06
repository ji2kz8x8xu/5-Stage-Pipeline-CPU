module EX_MEM_register(clk, rst, resultIn, PCIn, jumpIn, regWriteIn, memToRegIn, memReadIn, memWriteIn, branchIn, zeroIn, RD2In, WNIn, jalIn, OR_PCIn, 

resultOut, PCOut, jumpOut, regWriteOut, memToRegOut, memReadOut, memWriteOut, branchOut, zeroOut, RD2Out, WNOut, jalOut, OR_PCOut);

  input clk, rst;

  input [31:0] resultIn, PCIn, RD2In, OR_PCIn;
  input jumpIn, regWriteIn, memToRegIn, memReadIn, memWriteIn, branchIn, zeroIn, jalIn;
  input [4:0] WNIn;

  output reg  [31:0] resultOut, PCOut, RD2Out, OR_PCOut;
  output reg jumpOut, regWriteOut, memToRegOut, memReadOut, memWriteOut, branchOut, zeroOut, jalOut;
  output reg [4:0] WNOut;

  
  always @(posedge clk) begin
    if (rst) begin
      resultOut   <= 32'b0;
      PCOut       <= 32'b0;
      jumpOut     <= 1'b0;
      regWriteOut <= 1'b0;
      memToRegOut <= 1'b0;
      memReadOut  <= 1'b0;
      memWriteOut <= 1'b0;
      branchOut   <= 1'b0;
      zeroOut     <= 1'b0;
      RD2Out      <= 32'b0;
      WNOut       <= 4'b0;
	  jalOut      <= 1'b0;
	  OR_PCOut    <= 32'b0;
    end else begin
      resultOut   <= resultIn;
      PCOut       <= PCIn;
      jumpOut     <= jumpIn;
      regWriteOut <= regWriteIn;
      memToRegOut <= memToRegIn;
      memReadOut  <= memReadIn;
      memWriteOut <= memWriteIn;
      branchOut   <= branchIn;
      zeroOut     <= zeroIn;
      RD2Out      <= RD2In;
      WNOut       <= WNIn;
	  jalOut      <= jalIn;
	  OR_PCOut    <= OR_PCIn;
    end
  end

endmodule