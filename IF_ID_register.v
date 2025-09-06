module IF_ID_register(clk, rst, PCIn, instructionIn, PCOut, instructionOut) ;
    input clk, rst;
    input [31:0] PCIn, instructionIn;
    output reg [31:0] PCOut, instructionOut;

    always @(posedge clk) begin
        if (rst) begin
			PCOut <= 32'b0;
			instructionOut <= 32'b0;
		end else begin
			PCOut <= PCIn;
			instructionOut <= instructionIn;
		end 
    end
endmodule