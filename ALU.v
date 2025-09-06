module ALU(dataA, dataB, Signal, dataOut, zero);
  input  [31:0] dataA;
  input  [31:0] dataB;
  input  [2:0]  Signal;
  output [31:0] dataOut;
  output zero;

  
  wire Binvert, Cin;
  wire [30:0] Cout;

  parameter AND = 3'b000;
  parameter OR  = 3'b001;
  parameter ADD = 3'b010;
  parameter SUB = 3'b110;
  parameter SLT = 3'b111;

  // MSB 的 Set
  wire set_MSB;
  
  assign Binvert = (Signal == SUB) | (Signal == SLT) ? 1'b1 : 1'b0;
  assign Cin = (Signal == SUB) | (Signal == SLT) ? 1'b1 : 1'b0;
  
  ALU1Bit bit0(.A(dataA[0]), .B(dataB[0]), .Cin(Cin), .Binvert(Binvert), .Less(set_MSB), .Op(Signal), .Cout(Cout[0]), .Set(), .Result(dataOut[0]));
  ALU1Bit bit1(.A(dataA[1]), .B(dataB[1]), .Cin(Cout[0]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[1]), .Set(), .Result(dataOut[1]));
  ALU1Bit bit2(.A(dataA[2]), .B(dataB[2]), .Cin(Cout[1]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[2]), .Set(), .Result(dataOut[2]));
  ALU1Bit bit3(.A(dataA[3]), .B(dataB[3]), .Cin(Cout[2]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[3]), .Set(), .Result(dataOut[3]));
  ALU1Bit bit4(.A(dataA[4]), .B(dataB[4]), .Cin(Cout[3]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[4]), .Set(), .Result(dataOut[4]));
  ALU1Bit bit5(.A(dataA[5]), .B(dataB[5]), .Cin(Cout[4]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[5]), .Set(), .Result(dataOut[5]));
  ALU1Bit bit6(.A(dataA[6]), .B(dataB[6]), .Cin(Cout[5]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[6]), .Set(), .Result(dataOut[6]));
  ALU1Bit bit7(.A(dataA[7]), .B(dataB[7]), .Cin(Cout[6]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[7]), .Set(), .Result(dataOut[7]));
  ALU1Bit bit8(.A(dataA[8]), .B(dataB[8]), .Cin(Cout[7]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[8]), .Set(), .Result(dataOut[8]));
  ALU1Bit bit9(.A(dataA[9]), .B(dataB[9]), .Cin(Cout[8]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[9]), .Set(), .Result(dataOut[9]));
  ALU1Bit bit10(.A(dataA[10]), .B(dataB[10]), .Cin(Cout[9]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[10]), .Set(), .Result(dataOut[10]));
  ALU1Bit bit11(.A(dataA[11]), .B(dataB[11]), .Cin(Cout[10]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[11]), .Set(), .Result(dataOut[11]));
  ALU1Bit bit12(.A(dataA[12]), .B(dataB[12]), .Cin(Cout[11]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[12]), .Set(), .Result(dataOut[12]));
  ALU1Bit bit13(.A(dataA[13]), .B(dataB[13]), .Cin(Cout[12]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[13]), .Set(), .Result(dataOut[13]));
  ALU1Bit bit14(.A(dataA[14]), .B(dataB[14]), .Cin(Cout[13]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[14]), .Set(), .Result(dataOut[14]));
  ALU1Bit bit15(.A(dataA[15]), .B(dataB[15]), .Cin(Cout[14]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[15]), .Set(), .Result(dataOut[15]));
  ALU1Bit bit16(.A(dataA[16]), .B(dataB[16]), .Cin(Cout[15]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[16]), .Set(), .Result(dataOut[16]));
  ALU1Bit bit17(.A(dataA[17]), .B(dataB[17]), .Cin(Cout[16]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[17]), .Set(), .Result(dataOut[17]));
  ALU1Bit bit18(.A(dataA[18]), .B(dataB[18]), .Cin(Cout[17]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[18]), .Set(), .Result(dataOut[18]));
  ALU1Bit bit19(.A(dataA[19]), .B(dataB[19]), .Cin(Cout[18]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[19]), .Set(), .Result(dataOut[19]));
  ALU1Bit bit20(.A(dataA[20]), .B(dataB[20]), .Cin(Cout[19]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[20]), .Set(), .Result(dataOut[20]));
  ALU1Bit bit21(.A(dataA[21]), .B(dataB[21]), .Cin(Cout[20]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[21]), .Set(), .Result(dataOut[21]));
  ALU1Bit bit22(.A(dataA[22]), .B(dataB[22]), .Cin(Cout[21]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[22]), .Set(), .Result(dataOut[22]));
  ALU1Bit bit23(.A(dataA[23]), .B(dataB[23]), .Cin(Cout[22]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[23]), .Set(), .Result(dataOut[23]));
  ALU1Bit bit24(.A(dataA[24]), .B(dataB[24]), .Cin(Cout[23]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[24]), .Set(), .Result(dataOut[24]));
  ALU1Bit bit25(.A(dataA[25]), .B(dataB[25]), .Cin(Cout[24]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[25]), .Set(), .Result(dataOut[25]));
  ALU1Bit bit26(.A(dataA[26]), .B(dataB[26]), .Cin(Cout[25]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[26]), .Set(), .Result(dataOut[26]));
  ALU1Bit bit27(.A(dataA[27]), .B(dataB[27]), .Cin(Cout[26]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[27]), .Set(), .Result(dataOut[27]));
  ALU1Bit bit28(.A(dataA[28]), .B(dataB[28]), .Cin(Cout[27]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[28]), .Set(), .Result(dataOut[28]));
  ALU1Bit bit29(.A(dataA[29]), .B(dataB[29]), .Cin(Cout[28]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[29]), .Set(), .Result(dataOut[29]));
  ALU1Bit bit30(.A(dataA[30]), .B(dataB[30]), .Cin(Cout[29]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(Cout[30]), .Set(), .Result(dataOut[30]));
  ALU1Bit bit31(.A(dataA[31]), .B(dataB[31]), .Cin(Cout[30]), .Binvert(Binvert), .Less(1'b0), .Op(Signal), .Cout(), .Set(set_MSB), .Result(dataOut[31]));

  assign zero = (dataOut == 32'b0);
  
endmodule