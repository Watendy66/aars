// bubble_sort.s
// 全部用 blt/ble 控制循环，避免 beq。
// 输入循环用显式 str + add，不用 pre-indexed write-back 伪指令。

.data
str0:   .asciz  "Please input how many numbers to sort:\n"
str1:   .asciz  "Please input each number:\n"
str2:   .asciz  "The sorted numbers are: "
space:  .asciz  " "
        .align  #2
data:   .word   #0 : #20    // 最多 20 个数

.text

// ── 输入阶段 ─────────────────────────────────────────────────
get_array:
    mov r2, #4
    mov r0, str0
    syscall

    mov r2, #5              // 读 count → R0
    syscall
    mov r6, r0              // R6 = count

    mov r2, #4
    mov r0, str1
    syscall

    mov r1, data            // R1 = 数组指针
    mov r7, #0              // R7 = 已存入数量

loop_store_data:
    mov r2, #5
    syscall                 // 读整数 → R0
    str r0, [r1]            // 存入当前地址（不用 write-back 伪指令）
    add r1, r1, #4          // 指针后移
    add r7, r7, #1          // 计数+1
    cmp r7, r6
    blt loop_store_data     // r7 < r6 → 继续读

// ── 冒泡排序 ─────────────────────────────────────────────────
// R12 = r6 - 1（每趟比较次数，也是趟数上限）
sub r12, r6, #1

    mov r7, #0              // R7 = 外层趟数计数

loop_outside:
    mov r8, #0              // R8 = 内层比较计数
    mov r9, data            // R9 = 数组指针归零

loop_inner:
    ldr r10, [r9, #0]       // r10 = arr[i]
    ldr r11, [r9, #4]       // r11 = arr[i+1]
    cmp r10, r11
    ble switch_done         // r10 <= r11，无需交换
    str r11, [r9, #0]       // 交换
    str r10, [r9, #4]

switch_done:
    add r9, r9, #4
    add r8, r8, #1
    cmp r8, r12
    blt loop_inner          // r8 < r6-1 → 继续内层

    add r7, r7, #1
    cmp r7, r12
    blt loop_outside        // r7 < r6-1 → 继续外层

// ── 打印结果 ─────────────────────────────────────────────────
    mov r2, #4
    mov r0, str2
    syscall

    eor r7, r7, r7          // R7 = 打印计数
    mov r9, data

loop_print:
    ldr r3, [r9, #0]
    add r9, r9, #4
    mov r2, #1
    mov r0, r3
    syscall
    mov r2, #4
    mov r0, space
    syscall
    add r7, r7, #1
    cmp r7, r6
    blt loop_print          // r7 < r6 → 继续打印

    mov r2, #10
    syscall                 // 正常退出
