module MUX4_1(sel, HiIn, LoIn, ALUIn, shiftIn, dataOut);

  input  [1:0]  sel;
  input  [31:0] HiIn, LoIn, ALUIn, shiftIn;
  output [31:0] dataOut;
  
  assign dataOut = (sel == 2'b00) ? HiIn    :
                   (sel == 2'b01) ? LoIn    :
                   (sel == 2'b10) ? ALUIn   :
                   (sel == 2'b11) ? shiftIn : 32'bx;

endmodule