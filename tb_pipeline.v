/*
	Title: MIPS Single Cycle CPU Testbench
	Author: Selene (Computer System and Architecture Lab, ICE, CYCU) 
*/
module tb_pipeline();
	reg clk, rst;
	parameter MAX_CYCLE = 200;
	
	// ���ͮɯߡA�g���G10ns
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		/*
			���O��ưO����A�ɦW"instr_mem.txt, data_mem.txt"�i�ۦ�ק�
			�C�@�欰1 Byte��ơA�H��ӤQ���i��Ʀr���
			�B��Little Endian�s�X
		*/
		$readmemh("instr_mem.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		// �]�w�Ȧs����l�ȡA�C�@�欰�@���Ȧs�����
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	initial begin
        #(MAX_CYCLE * 10)
        $display("%0t ns : Reached MAX_CYCLE, finishing.", $time);
        $finish;
    end
	
	always @( posedge clk ) begin
		if (CPU.instr !== 32'bx) begin
			$display( "%d, PC:", $time/10-1, CPU.pc );
                end
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.WB_WD );
			if ( CPU.funct == 6'd32 ) $display( "%d, ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, OR\n", $time/10-1 );
			else if ( CPU.funct == 6'd02 ) $display("%d, SRL\n",   $time/10-1);
			else if ( CPU.funct == 6'd42 ) $display("%d, SLT\n",   $time/10-1);
			else if ( CPU.funct == 6'd27 ) $display("%d, DIVU\n",   $time/10-1);
			else if ( CPU.funct == 6'd16 ) $display("%d, MFHI\n",   $time/10-1);
			else if ( CPU.funct == 6'd18 ) $display("%d, MFLO\n",   $time/10-1);
            else if ( CPU.funct == 6'd0 && CPU.rs == 5'd0 && CPU.rt == 5'd0 && CPU.rd == 5'd0 && CPU.shamt == 5'd0) begin
                $display( "%d, NOP\n", $time/10-1 );
            end 
		end
		else if ( CPU.opcode == 6'd35 ) $display("%d, LW\n",  $time/10-1);
		else if ( CPU.opcode == 6'd43 ) $display("%d, SW\n",  $time/10-1);
		else if ( CPU.opcode == 6'd4 ) $display("%d, BEQ\n",  $time/10-1);
		else if ( CPU.opcode == 6'd2 ) $display("%d, J\n",    $time/10-1);
		else if ( CPU.opcode == 6'd9 )$display("%d, ADDIU\n", $time/10-1);
		else if ( CPU.opcode == 6'd3 )$display("%d, JAL\n",   $time/10-1);
	end
	
	mips_pipeline CPU(clk, rst);
	
endmodule
