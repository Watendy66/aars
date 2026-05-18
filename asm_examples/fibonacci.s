// fibonacci.s
// Computes Fibonacci numbers F(1)..F(n) and prints each.
// Uses ARM register names (R0-R12) and ARM syscall conventions.
//
// Register map:
//   R0  = n (iteration count = 9)
//   R4  = syscall scratch / integer to print
//   R5  = pointer into fibs array
//   R7  = loop counter i
//   R8  = fibs[i]
//   R9  = fibs[i+1]
//   R10 = fibs[i+2]  (newly computed)
//   R11 = running sum of all fibonacci values

.data
    fibs:   .word   #0 : #12    // 12-word array for fib values
    header: .asciz  "Fibonacci sequence:\n"
    space:  .asciz  " "

.text

    mov r0,  #9             // n = 9 iterations
    eor r11, r11, r11       // r11 = 0 (running sum)
    mov r7,  #1             // r7  = i = 1 (loop counter)
    mov r8,  #0             // r8  = fibs[i]   = 0
    mov r9,  #1             // r9  = fibs[i+1] = 1
    eor r10, r10, r10       // r10 = 0

    // Print header
    mov r2, #4              // syscall: print string
    mov r0, header          // R0 = address (ARM convention)
    syscall

    // Store the initial two values into the array
    mov r5, fibs
    str r8, [r5]            // fibs[0] = 0
    str r9, [r5, #4]!       // fibs[1] = 1, advance R5 to fibs[1]

    // Restore R0 = n (syscall above doesn't clobber it in this simulator,
    // but we re-set for clarity)
    mov r0, #9

// ── Main loop ────────────────────────────────────────────────
loop:
    cmp r7, r0              // i vs n
    beq loopexit            // done when i == n

    add r10, r8, r9         // fibs[i+2] = fibs[i] + fibs[i+1]

    push {r10}              // demo: push onto stack (visible in Data Segment → Stack)

    str r10, [r5, #4]!      // store fibs[i+2], advance pointer

    // Print fibs[i+2]
    mov r2, #1              // syscall: print int
    mov r0, r10             // R0 = value (ARM convention)
    syscall

    // Print space
    mov r2, #4              // syscall: print string
    mov r0, space
    syscall

    mov r8,  r9             // fibs[i]   = fibs[i+1]
    mov r9,  r10            // fibs[i+1] = fibs[i+2]
    add r7,  r7,  #1        // i++
    add r11, r11, r10       // sum += fibs[i+2]

    b loop

// ── Cleanup ──────────────────────────────────────────────────
loopexit:
    mov r0,  #0
    mov r1,  #0
    mov r2,  #0
    mov r3,  #0
    mov r4,  #0
    mov r5,  #0
    mov r6,  #0
    mov r7,  #0
    mov r8,  #0
    mov r9,  #0
    mov r10, #0
    mov r11, #0
    mov r12, #0
