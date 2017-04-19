; Defining ports addresses to ease coding
.EQN DDRB ,0x17	    ; Port direction (INPUT or OUTPUT)
.EQN PORTB,0x18	    ; PORT state (HIGH or LOW)

; Tell the assembler that our code will execute at address 0x0 in memory
.org 0x0

; Defining Interrup Vector table
    rjmp RESET	    ; RESET interrupt handler - Execution starts here at boot

RESET:
    sbi DDRB,0	    ; Set PIN0 to OUTPUT mode
    sbi PORTB,0	    ; Set PIN0 to HIGH

END:
    rjmp END	    ; Loop endlessly :)
