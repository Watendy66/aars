README

# BIT-AARS : ARM Simulator in Java 


## 1. Introduction
  BIT-AARS is a ARM simulator for teaching designed by Pengxiang Li and Donghai Liao based on MARS ansd RARS, a MIPS simulator in Java and a Risc-V simulator in Java. <br>

## 2. Supported Instructions
  The most of basic instructions set ARM 7.3.<br>
  Directives and macro are supported.<br>
  A few pseudo-instructions are supportet. we noticed that it's not enough and will be enriched in the future version.<br>
  For specific support instructions, please refer to the help documentation.<br>
  

## 3. Installing and Running
   Java JRE 1.6 or above is required. Download jar file in directory `.\bin` and Run it from console<br>
   
    $ java -jar BIT-AARS.jar 
   
  ![1](https://github.com/jiweixing/aars/raw/master/screen_shot/3_1.jpg "Main UI")	<br>
  There are mainly four sections in the main UI. <br>
  The first and second section are menu and tool bar. <br>
  The third section is "Edit/Excute" section, in which you can edit your code or watch the simulation result. <br>
  The fourth section is a console to display the output and reports of assembling and simulation.<br>
  <br>
  Here is an exmaple to show you how to use the simulator:<br>
  Click **File→Open**, and follow the instructions in [section 4→(2)](#4-examples) to find the examples. Copy and paste the example in the edit page.<br>
  ![2](https://github.com/jiweixing/aars/raw/master/screen_shot/3_2.jpg "Open file")
  ![3](https://github.com/jiweixing/aars/raw/master/screen_shot/3_3.jpg "Select file")	<br>
  <br>
  Go to Run→Assemble to assemble the asm code. You will see the execute page, in which there are source code, basic format of each code, binary code, code address(section 1), the memory(section 2) of and registers(section 3).<br>
  ![4](https://github.com/jiweixing/aars/raw/master/screen_shot/3_4.jpg "Assemble file")	<br>
  ![5](https://github.com/jiweixing/aars/raw/master/screen_shot/3_5.jpg "Assemble button in tool bar")	<br>
  Then all the work have been done. Just use run, step and other command in the tool bar(next to  the assemble button) to run the code and watch the outcomes.<br>
### About the source code：
  The main class is in Aars.java and other source codes are in help, images and Aars, in case anyone want to compile or read the code
## 4. Examples 
  (1. Open Aars.jar, find **Help→Aars→Examples**, where two example are presented.<br>
  (2. Open directory `.\asm_examples`. More examples will be found to implement Bubblesort and calculate fibonacci.<br>

## 5. Future Work
  More pseudo-instrucions to be added.
  <br>
  Please feel free to contact us(jwx@bit.edu.cn), if you have any questions about this project.<br>

## 6. Changelog
### v1.1 (2026)
**Bug Fixes**
- **Duplicate instruction**: removed duplicate registration of `sub r0,#-112` in `InstructionSet.java`.
- **LDR reads only 16 bits**: all three `ldr` variants changed from `getHalf()` to `getWord()`; offset sign-extension corrected from `<<16>>16` to `<<20>>20`.
- **CMP incomplete flags**: `cmp` now sets all four CPSR flags (N/Z/C/V), restoring correct behaviour of `blt`, `bgt`, `bge`, `ble`.
- **BL does not save return address**: `bl` now writes `PC+4` into LR (R14) before branching.
- **BX uses relative jump**: `bx` changed from `processBranch` (relative) to `processJump` (absolute); syntax updated from `bx label` to `bx r0`.
- **BXEQ uses relative jump**: same fix as BX above.

**Syscall Register Alignment**
- Arguments and return values now follow ARM convention: R0 (1st arg / return), R1 (2nd arg), R3 (3rd arg), R2 (syscall number). Updated across all 30 files in `syscalls/`.

**New Instructions**
- Added `lsl r0,r1,#imm` (immediate shift) and `lsl r0,r1,r2` (register shift).

**Planned for next release**: `lsr`, `asr`, `mul`, `push`, `pop`, `bne`.

**Syntax changes** (applied in Phase 1, prior to v1.1)
- Comment character: `;` → `//`
- File extension: `.asm` → `.s`
- Register names: `a1/a2/v1…` → `R0–R12/SP/LR/PC`
