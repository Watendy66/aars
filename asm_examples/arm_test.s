// arm_test.s — BIT-AARS 功能测试
// 预期输出（console）：1  2  42  64
// 每个数字对应一个测试点，详见注释。

.global main
main:
    // ── Test 1: 基础算术 ──────────────────────────────────────
    mov r0, #10
    mov r1, #3
    add r2, r0, r1          // r2 = 13
    sub r3, r0, r1          // r3 = 7

    // ── Test 2: CMP + 条件分支（Bug 3 修复验证）──────────────
    cmp r0, r1              // 10 vs 3
    bgt label_gt            // 应跳转
    mov r4, #0
    b test3
label_gt:
    mov r4, #1              // r4 = 1  ✓ bgt 正常
    mov r2, #1              // 打印 r4，期望输出：1
    mov r0, r4
    syscall

    mov r0, #3              // 恢复 r0=3 用于下次比较
    mov r1, #10
    cmp r0, r1              // 3 vs 10
    blt label_lt            // 应跳转
    mov r4, #0
    b test3
label_lt:
    mov r4, #2              // r4 = 2  ✓ blt 正常
    mov r2, #1              // 打印 r4，期望输出：2
    mov r0, r4
    syscall

    // ── Test 3: BL 保存 LR，BX 绝对跳转返回（Bug 4&5）───────
test3:
    bl my_func              // LR = PC+4，跳转
    mov r2, #1              // 打印 r5，期望输出：42
    mov r0, r5
    syscall

    // ── Test 4: LSL 立即数 + 寄存器 ──────────────────────────
    mov r8, #1
    lsl r8, r8, #4          // r8 = 16
    mov r9, #2
    lsl r8, r8, r9          // r8 = 64
    mov r2, #1              // 打印 r8，期望输出：64
    mov r0, r8
    syscall

    // ── 正常退出 ─────────────────────────────────────────────
    mov r2, #10
    syscall

my_func:
    mov r5, #42
    bx lr