# 5-Stage Pipelined CPU (Verilog)

## Overview
This repository implements a classic **5-stage pipeline** CPU in Verilog:
**IF → ID → EX → MEM → WB**.  
The design is modular—ALU, register file, Hi/Lo, control unit, instruction/data
memory, sign-extend, and per-stage pipeline registers—plus a testbench for
simulation and waveform inspection (ModelSim).

- **Clear 5-stage pipeline** for learning, debugging, and extension.
- **Simulation-ready** testbench; edit `instr_mem.txt` / `data_mem.txt` to load programs.
- **Simplified control-hazard handling** using **NOP delay slots**  
  (e.g., one `nop` after `j`; three `nop`s for `beq`) to make timing explicit.
- **Modular source layout** to keep each component easy to read and replace.


## Typical Modules (by category)
- **Top/Testbench**: `mips_pipeline.v`, `tb_pipeline.v`
- **ALU & Logic**: `ALU.v`, `ALU1Bit.v`, `ALU_control.v`, `FA1Bit.v`, `shifter.v`
- **Registers**: `reg_file.v`, `reg32.v`, `HiLo.v`,
  pipeline regs `IF_ID_register.v`, `ID_EX_register.v`, `EX_MEM_register.v`, `MEM_WB_register.v`
- **Memory & Data**: `memory.v`, `instr_mem.txt`, `data_mem.txt`, `reg.txt`
- **Control & Utils**: `control_unit.v`, `sign_extend.v`, `add32.v`,
  `mux2.v` / `MUX2_1.v` / `MUX4_1.v`, `divider.v`

## Example Instructions Verified
`add, sub, and, or, srl, slt, mfhi, mflo, addiu, lw, sw, j, beq, jal, nop`

## Quick Start (Simulation)

### ModelSim
1. Create a project and **add all Verilog sources**.
2. Set **`tb_pipeline.v` as the top** for simulation.
3. Run simulation; inspect signals (e.g., `pc`, stage control lines, write-back data).
4. Modify **`instr_mem.txt` / `data_mem.txt`** to load your own program; re-run.
