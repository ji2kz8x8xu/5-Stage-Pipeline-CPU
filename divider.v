module divider(clk, dataA, dataB, Signal, dataOut, reset);
  input              clk;
  input              reset;
  input      [5:0]   Signal;
  input      [31:0]  dataA;
  input      [31:0]  dataB;
  output reg [63:0]  dataOut;

  reg [63:0] div_reg, rem_reg;
  reg [31:0] quo_reg;
  reg        start;
  reg [5:0]  counter;
  reg        end_div;

  parameter DIVU = 6'b011011;
  parameter OUT  = 6'b111111;
  parameter PAUSE = 6'b000000;

  always @(posedge clk) begin
    if (reset) begin
      div_reg  <= 64'd0;
      rem_reg  <= 64'd0;
      quo_reg  <= 32'd0;
      start    <= 1'b1;
      dataOut  <= 64'd0;
      counter  <= 5'd0;
      end_div  <= 1'b0;

    end else if (Signal == DIVU && end_div == 1'b0) begin
      
      if (start) begin
        div_reg <= {dataB, 32'd0};  // div_reg <= {dataB, 32'd0}; div_reg <= {1'd0, dataB, 31'd0}
        rem_reg <= {32'd0, dataA};
        quo_reg <= 32'd0;
        start   <= 1'b0;
        counter <= 5'd0;
        end_div <= 1'b0;
      end else begin

        if (rem_reg >= div_reg) begin
          rem_reg <= rem_reg - div_reg;
          quo_reg <= {quo_reg[30:0], 1'b1};
        end else begin
          quo_reg <= {quo_reg[30:0], 1'b0};
        end
        div_reg <= {1'b0, div_reg[63:1]};

        counter <= counter + 1;
        if (counter == 6'd32) begin
          end_div <= 1'b1;
        end
      end
  
    end else if (end_div == 1'b1) begin
      dataOut <= {rem_reg[31:0], quo_reg};
      start   <= 1'b1;
	  end_div <= 1'b0;
    end
  end
endmodule



