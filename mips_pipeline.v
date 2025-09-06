module mips_pipeline(clk, rst);
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [25:0] jumpoffset;
	wire [31:0] ID_extend_immed, ID_PC, EX_ADD_PC; // extend 後的 imme, 在 ID 的 PC
	// datapath signals
    wire [4:0] EX_WN;
    wire [31:0] alu_b, pc_next,
                pc, pc_incr;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Jump;
    wire [1:0] ALUOp, signalToMux;
	wire [2:0] EX_ALUOperation;
	wire [31:0] EX_ALUOut, EX_resultMuxOut, EX_DivAns, EX_HiOut, EX_LoOut;
	wire EX_zero;
	
	wire [31:0] PCMUXResult, ID_instr;
	
	// ID接線
	wire [31:0] ID_RD1, ID_RD2;
	
	wire ID_jal;
	// 接ID/EX出來的wire 在EX中使用
	wire [31:0] EX_PC, EX_RD1, EX_RD2, EX_extend_immed, EX_srlResult;
	wire EX_jump, EX_regWrite, EX_memToReg, EX_memRead, EX_memWrite, EX_branch, EX_ALUSrc, EX_RegDst, EX_jal;
	wire [1:0] EX_ALUOp, EX_signalToMux;
	wire [4:0] EX_rt, EX_rd;
	
	
	// EX/MEM 接出來 wire
    wire [31:0] MEM_result, MEM_branchTarget, MEM_RD2, MEM_RD, MEM_PC;
	wire MEM_jump, MEM_regWrite, MEM_memToReg, MEM_memRead, MEM_memWrite, MEM_branch, MEM_zero, MEM_jal;
	wire [4:0] MEM_WN;
	wire [31:0] add_b, WB_MUX1Result;
	
	// WB區域
	wire WB_jump, WB_regWrite, WB_memToReg, WB_jal;
	wire [31:0] WB_RD, WB_result, WB_WD, WB_PC;
	wire [4:0] WB_WN, WB_WNBeforeMux;
	


	// IF ->
	reg32 PC(.clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc));
	
	add32 PCADD4(.a(pc), .b(32'd4), .result(pc_incr));
	
	
	memory InstrMem(.clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr));

	mux2 #(32) PCMUX(.sel(PCSrc), .a(pc_incr), .b(MEM_branchTarget), .y(PCMUXResult));
	mux2 #(32) jumpMUX(.sel(Jump), .a(PCMUXResult), .b({pc_incr[31:28], ID_instr[25:0], 2'b00}), .y(pc_next));
	// <- IF
	
	// IF_ID_register
	IF_ID_register IF_ID_reg(.clk(clk), .rst(rst), .PCIn(pc_incr), .instructionIn(instr), .PCOut(ID_PC), .instructionOut(ID_instr));

    // ID - >
	


    assign opcode = ID_instr[31:26];
    assign rs = ID_instr[25:21];
    assign rt = ID_instr[20:16];
    assign rd = ID_instr[15:11];
    assign shamt = ID_instr[10:6];
    assign funct = ID_instr[5:0];
    assign immed = ID_instr[15:0];
    assign jumpoffset = ID_instr[25:0];
    control_unit CTLUnit(.instr(ID_instr), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .signalToMux(signalToMux), .jal(ID_jal)); // div 的 busy

    reg_file RegFile(.clk(clk), .RegWrite(WB_regWrite), .RN1(rs), .RN2(rt), .WN(WB_WN), 
                                       .WD(WB_WD), .RD1(ID_RD1), .RD2(ID_RD2));
  
    sign_extend signExtend(.immed_in(immed), .ext_immed_out(ID_extend_immed));
    // < - ID 

    // ID_EX_register
    ID_EX_register ID_EX_reg(.clk(clk), .rst(rst), .PCIn(ID_PC), .jumpIn(Jump), .regWriteIn(RegWrite), .memToRegIn(MemtoReg), .memReadIn(MemRead), .memWriteIn(MemWrite), .branchIn(Branch), .signalToMuxIn(signalToMux), .ALUOpIn(ALUOp), .ALUSrcIn(ALUSrc), .regDstIn(RegDst), .RD1In(ID_RD1), .RD2In(ID_RD2), .immeExtendIn(ID_extend_immed), .rtIn(rt), .rdIn(rd), .jalIn(ID_jal),

    .PCOut(EX_PC), .jumpOut(EX_jump), .regWriteOut(EX_regWrite), .memToRegOut(EX_memToReg), .memReadOut(EX_memRead), .memWriteOut(EX_memWrite), .branchOut(EX_branch), .signalToMuxOut(EX_signalToMux), .ALUOpOut(EX_ALUOp), .ALUSrcOut(EX_ALUSrc), .regDstOut(EX_RegDst), .RD1Out(EX_RD1), .RD2Out(EX_RD2), .immeExtendOut(EX_extend_immed), .rtOut(EX_rt), .rdOut(EX_rd), .jalOut(EX_jal));

    // - > EX
    
    mux2 #(32) ALUMUX(.sel(EX_ALUSrc), .a(EX_RD2), .b(EX_extend_immed), .y(alu_b));
    mux2 #(5) WNMUX(.sel(EX_RegDst), .a(EX_rt), .b(EX_rd), .y(EX_WN)); 
	
	assign add_b = EX_extend_immed << 2;

	
	add32 branchADD(.a(EX_PC), .b(add_b), .result(EX_ADD_PC));
	
    ALU_control ALUCTL(.ALUOp(EX_ALUOp), .funct(EX_extend_immed[5:0]), .ALUOperation(EX_ALUOperation));

    ALU alu(.dataA(EX_RD1), .dataB(alu_b), .Signal(EX_ALUOperation), .dataOut(EX_ALUOut), .zero(EX_zero));
	
	// srl
	shifter SHI(.dataA(EX_RD2), .dataB(EX_extend_immed[10:6]), .Signal(6'b000010), .dataOut(EX_srlResult));
	
	
	// DIVU = 6'b011011
	
	divider divu(.clk(clk), .reset(rst), .dataA(EX_RD1), .dataB(EX_RD2), .Signal(6'b000000), .dataOut(EX_DivAns));
	
	HiLo HiLo(.clk(clk), .reset(rst), .DivAns(EX_DivAns), .HiOut(EX_HiOut), .LoOut(EX_LoOut));

	// 選擇 result
    MUX4_1 resultMUX(.sel(EX_signalToMux), .HiIn(EX_HiOut), .LoIn(EX_LoOut), .ALUIn(EX_ALUOut), .shiftIn(EX_srlResult), .dataOut(EX_resultMuxOut));
	
	
    // < - EX

    // EX_MEM_register
    EX_MEM_register EX_MEM_reg(.clk(clk), .rst(rst), .resultIn(EX_resultMuxOut), .PCIn(EX_ADD_PC), .jumpIn(EX_jump), .regWriteIn(EX_regWrite), .memToRegIn(EX_memToReg), .memReadIn(EX_memRead), .memWriteIn(EX_memWrite), .branchIn(EX_branch), .zeroIn(EX_zero), .RD2In(EX_RD2), .WNIn(EX_WN), .jalIn(EX_jal), .OR_PCIn(EX_PC), 

    .resultOut(MEM_result), .PCOut(MEM_branchTarget), .jumpOut(MEM_jump), .regWriteOut(MEM_regWrite), .memToRegOut(MEM_memToReg), .memReadOut(MEM_memRead), .memWriteOut(MEM_memWrite), .branchOut(MEM_branch), .zeroOut(MEM_zero), .RD2Out(MEM_RD2), .WNOut(MEM_WN), .jalOut(MEM_jal), .OR_PCOut(MEM_PC));
    
    // - > MEM

    and Branch_AND(PCSrc, MEM_branch, MEM_zero);

    memory DatMem(.clk(clk), .MemRead(MEM_memRead), .MemWrite(MEM_memWrite), .wd(MEM_RD2), .addr(MEM_result), .rd(MEM_RD));

    // < - MEM


    // MEM_WB_register
    MEM_WB_register MEM_WB_reg(.clk(clk), .rst(rst), .jumpIn(MEM_jump), .regWriteIn(MEM_regWrite), .memToRegIn(MEM_memToReg), .RDIn(MEM_RD), .resultIn(MEM_result), .WNIn(MEM_WN), .PCIn(MEM_PC), .jalIn(MEM_jal), 

    .jumpOut(WB_jump), .regWriteOut(WB_regWrite), .memToRegOut(WB_memToReg), .RDOut(WB_RD), .resultOut(WB_result), .WNOut(WB_WNBeforeMux), .PCOut(WB_PC), .jalOut(WB_jal));


    // -> WB

    mux2 #(32) WDMUX(.sel(WB_memToReg), .a(WB_result), .b(WB_RD), .y(WB_MUX1Result));
	
	mux2 #(32) WD2MUX(.sel(WB_jal), .a(WB_MUX1Result), .b(WB_PC), .y(WB_WD));
	                                                   // $ra
	mux2 #(5) WN2MUX(.sel(WB_jal), .a(WB_WNBeforeMux), .b(5'd31), .y(WB_WN));

    // <- WB

endmodule
