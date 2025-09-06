module ID_EX_register(clk, rst, PCIn, jumpIn, regWriteIn, memToRegIn, jalIn, memReadIn, memWriteIn, branchIn, signalToMuxIn, ALUOpIn, ALUSrcIn, regDstIn, RD1In, RD2In, immeExtendIn, rtIn, rdIn,

PCOut, jumpOut, regWriteOut, memToRegOut, jalOut, memReadOut, memWriteOut, branchOut, signalToMuxOut, ALUOpOut, ALUSrcOut, regDstOut, RD1Out, RD2Out, immeExtendOut, rtOut, rdOut);

  input clk, rst, jumpIn, regWriteIn, memToRegIn, memReadIn, memWriteIn, branchIn, ALUSrcIn, regDstIn, jalIn;
  input [31:0] PCIn, RD1In, RD2In, immeExtendIn;
  input [1:0] ALUOpIn, signalToMuxIn;
  input [4:0] rtIn, rdIn;

  output reg jumpOut, regWriteOut, memToRegOut, jalOut, memReadOut, memWriteOut, branchOut, ALUSrcOut, regDstOut;
  output reg [1:0]   ALUOpOut, signalToMuxOut;
  output reg [31:0]  PCOut, RD1Out, RD2Out, immeExtendOut;
  output reg [4:0]   rtOut, rdOut;

  always @(posedge clk) begin
   if (rst) begin
      PCOut         <= 32'b0;
      jumpOut       <= 1'b0;
      regWriteOut   <= 1'b0;
      memToRegOut   <= 1'b0;
	  jalOut        <= 1'b0;
      memReadOut    <= 1'b0;
      memWriteOut   <= 1'b0;
      branchOut     <= 1'b0;
      signalToMuxOut <= 2'b00;
      ALUOpOut      <= 2'b00;
      ALUSrcOut     <= 1'b0;
      regDstOut     <= 1'b0;
      RD1Out        <= 32'b0;
      RD2Out        <= 32'b0;
      immeExtendOut <= 32'b0;
      rtOut         <= 5'b0;
      rdOut         <= 5'b0;
    end else begin
      PCOut         <= PCIn;
      jumpOut       <= jumpIn;
      regWriteOut   <= regWriteIn;
      memToRegOut   <= memToRegIn;
	  jalOut        <= jalIn;
      memReadOut    <= memReadIn;
      memWriteOut   <= memWriteIn;
      branchOut     <= branchIn;
      signalToMuxOut<= signalToMuxIn;
      ALUOpOut      <= ALUOpIn;
      ALUSrcOut     <= ALUSrcIn;
      regDstOut     <= regDstIn;
      RD1Out        <= RD1In;
      RD2Out        <= RD2In;
      immeExtendOut <= immeExtendIn;
      rtOut         <= rtIn;
      rdOut         <= rdIn;
    end
  end

endmodule