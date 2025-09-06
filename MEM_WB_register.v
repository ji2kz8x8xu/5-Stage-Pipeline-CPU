module MEM_WB_register(clk, rst, jumpIn, regWriteIn, memToRegIn, RDIn, resultIn, WNIn, PCIn, jalIn,  

jumpOut, regWriteOut, memToRegOut, RDOut, resultOut, WNOut, PCOut, jalOut);

  input        clk, rst, jumpIn, regWriteIn, memToRegIn, jalIn;
  input [31:0] RDIn, resultIn, PCIn;
  input [4:0]  WNIn;


  output reg        jumpOut, regWriteOut, memToRegOut, jalOut;  
  output reg [31:0] RDOut,resultOut, PCOut;
  output reg [4:0]  WNOut;


  always @(posedge clk) begin
    if (rst) begin
      jumpOut     <= 1'b0;
      regWriteOut <= 1'b0;
      memToRegOut <= 1'b0;
      RDOut       <= 32'b0;
      resultOut   <= 32'b0;
      WNOut       <= 5'b0;
	  PCOut       <= 32'b0;
	  jalOut      <= 1'b0;
    end else begin
      jumpOut     <= jumpIn;
      regWriteOut <= regWriteIn;
      memToRegOut <= memToRegIn;
      RDOut       <= RDIn;
      resultOut   <= resultIn;
      WNOut       <= WNIn;
	  PCOut       <= PCIn;
	  jalOut      <= jalIn;
    end
  end

endmodule