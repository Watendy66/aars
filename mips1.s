// syscall_diag.s
// 诊断：读一个整数后，分别打印 R0 和 R2
// 如果你输入 99，看控制台输出哪个是 99，就确认了返回寄存器

.text
    // 读一个整数
    mov r2, #5
    syscall

    // 把 R0 和 R2 都保存下来，避免被 syscall 覆盖
    mov r3, r0          // 备份 R0
    mov r4, r2          // 备份 R2（syscall 号寄存器）

    // 打印 R0 的值（如果=99说明结果在R0）
    mov r2, #1
    mov r0, r3
    syscall

    // 打印 R2 的值（如果=99说明结果在R2）
    mov r2, #1
    mov r0, r4
    syscall

    // 退出
    mov r2, #10
    syscall