module MUX2_1(sel, a, b, out);

  input sel;
  input a, b;
  
  output out;
  
  assign out = sel ? a : b;

endmodule