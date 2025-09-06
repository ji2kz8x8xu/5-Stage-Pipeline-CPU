module ALU1Bit(A, B, Cin, Binvert, Less, Op, Cout, Set, Result);
  input A, B, Cin, Binvert, Less;
  input [2:0] Op;
  
  output Cout, Set, Result;
  
  parameter AND = 3'b000;
  parameter OR  = 3'b001;
  parameter ADD = 3'b010;
  parameter SUB = 3'b110;
  parameter SLT = 3'b111;
  
  // and or
  wire andResult, orResult;
  and(andResult, A, B);
  or(orResult, A, B);

  // 如果是減法先取餘樹
  wire B0;
  xor(B0, B, Binvert);
  
  // add
  wire sumResult, cResult;
  FA1Bit FA(.A(A), .B(B0), .Cin(Cin), .Cout(Cout), .S(sumResult));
  
  // 記錄目前這一位的減法結果
  assign Set = sumResult;
  
  // 傳入的 Less 直接輸出
  assign LessResult = Less;
  
  // 選擇輸出
  assign Result = (Op == AND) ? andResult :
                  (Op == OR)  ? orResult  :
                  (Op == ADD) ? sumResult :
                  (Op == SUB) ? sumResult :
                  (Op == SLT) ? LessResult : 1'bx;
  
endmodule