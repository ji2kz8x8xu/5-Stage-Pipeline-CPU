
module FA1Bit(A, B, Cin, Cout, S);

  input A, B, Cin;
  output Cout, S;
  
  wire w1, w2, w3, w4;
  
  xor(w1, A, B);
  xor(S, w1, Cin);
  
  or(w2, A, B);
  and(w3, w2, Cin);
  and(w4, A, B);
  or(Cout, w3, w4);

endmodule