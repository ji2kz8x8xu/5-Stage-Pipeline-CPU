/*
	Title: MIPS Single-Cycle Control Unit
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. instr: 輸入的指令代號，據此產生對應的控制訊號
	Output Port
		1. RegDst: 控制RFMUX
		2. ALUSrc: 控制ALUMUX
		3. MemtoReg: 控制WRMUX
		4. RegWrite: 控制暫存器是否可寫入
		5. MemRead:  控制記憶體是否可讀出
		6. MemWrite: 控制記憶體是否可寫入
		7. Branch: 與ALU輸出的zero訊號做AND運算控制PCMUX
		8. ALUOp: 輸出至ALU Control
		9. signalToMux 給EX的多工器選擇result
*/

module control_unit(instr, RegDst, ALUSrc, MemtoReg, RegWrite, 
					   MemRead, MemWrite, Branch, Jump, ALUOp, signalToMux, jal);
    input[31:0] instr;
    output reg RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, jal;
    output reg [1:0] ALUOp, signalToMux;


    parameter R_FORMAT = 6'd0;
    parameter LW = 6'd35;
    parameter SW = 6'd43;
    parameter BEQ = 6'd4;
	parameter J = 6'd2;
	parameter NOP = 32'd0;
	parameter mfhi = 6'b010000;
	parameter mflo = 6'b010010;
	parameter slt = 6'b101010;
	parameter srl = 6'b000010;
	parameter addiu = 6'b001001;
	parameter JAL = 6'b000011;

    always @(instr) begin
        case (instr[31:26])
          R_FORMAT: 
			begin
				if (instr == NOP) begin // 先設全0
					RegDst = 1'b0; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b0; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; signalToMux = 2'b00; jal = 1'b0;
				end else if (instr[5:0] == mfhi) begin
					RegDst = 1'b1; ALUSrc = 1'bx; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'bxx; signalToMux = 2'b01; jal = 1'b0;
				end else if (instr[5:0] == mflo) begin
					RegDst = 1'b1; ALUSrc = 1'bx; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'bxx; signalToMux = 2'b01; jal = 1'b0;
				end else if (instr[5:0] == srl) begin
					RegDst = 1'b1; ALUSrc = 1'bx; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; signalToMux = 2'b11; jal = 1'b0;
				end else begin // R-type 交給ALU control判斷
					RegDst = 1'b1; ALUSrc = 1'b0; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
					MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b10; signalToMux = 2'b10; jal = 1'b0;
				end
			end
		  LW :
			begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b1; RegWrite = 1'b1; MemRead = 1'b1; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; signalToMux = 2'b10; jal = 1'b0;
			end
		  SW :
			begin
				RegDst = 1'bx; ALUSrc = 1'b1; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b1; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; signalToMux = 2'b10; jal = 1'b0;
			end
		  BEQ :
			begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b1; Jump = 1'b0; ALUOp = 2'b01; signalToMux = 2'b00; jal = 1'b0; // 不影響 選00
			end
		  J :
			begin
				RegDst = 1'bx; ALUSrc = 1'b0; MemtoReg = 1'bx; RegWrite = 1'b0; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; ALUOp = 2'b01; signalToMux = 2'b00; jal = 1'b0; // 不影響 選00 Branch = 1 改 0
			end
		  addiu :
			begin
				RegDst = 1'b0; ALUSrc = 1'b1; MemtoReg = 1'b0; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b0; ALUOp = 2'b00; signalToMux = 2'b10; jal = 1'b0;
			end
		  JAL :
			begin
				RegDst = 1'bx; ALUSrc = 1'bx; MemtoReg = 1'bx; RegWrite = 1'b1; MemRead = 1'b0; 
				MemWrite = 1'b0; Branch = 1'b0; Jump = 1'b1; ALUOp = 2'bxx; signalToMux = 2'bxx; jal = 1'b1;
			end
		  default
			begin
				$display("control_single unimplemented instr %d", instr);
				RegDst=1'bx; ALUSrc=1'bx; MemtoReg=1'bx; RegWrite=1'bx; MemRead=1'bx; 
				MemWrite=1'bx; Branch=1'bx; Jump = 1'bx; ALUOp = 2'bxx; signalToMux = 2'bxx; jal = 1'bx;
			end

        endcase
    end
endmodule