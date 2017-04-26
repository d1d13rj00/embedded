;-----------------------------------------------------------
; Blink LED using counters
; Author : Didier Michel JOOMUN
;-----------------------------------------------------------

;FUSEBIT : CKDIV8 = 0

; Defining ports addresses to ease coding

.EQU PINB, 0x16	    ; PORT state (HIGH or LOW)
.EQU DDRB, 0x17	    ; Port direction (INPUT or OUTPUT)
.EQU PORTB,0x18	    ; PORT state (HIGH or LOW)

; Tell the assembler that our code will execute at address 0x0 in memory
.org 0x0

; Defining Interrup Vector table
    rjmp RESET	    ; RESET interrupt handler - Execution starts here at boot

RESET:
    sbi DDRB, 0	    ; Set PIN0 to OUTPUT mode
    sbi PORTB,0	    ; Set PIN0 to HIGH

END:
    rcall DELAY
    sbi PINB,0	    ; Toggles the PIN. Refer to section 10.2.2 in ATtiny13A datasheet.
    rjmp END	    ; Loop endlessly :)

DELAY:
    ; We want our LED to toggle 2 times per second (1 toggle every 500ms)
    push r16	    ; save registers
    push r17	    ; save registers
    ldi r17,0xFF    ; Initialize the counter with a big value
DEC17_LOOP:
    ldi r16,0xFF    ; Initialize the counter with a big value
    dec r17
    tst r17
    breq DEC_END
DEC16_LOOP:
    dec r16
    tst r16	    ; test if zero
    breq DEC17_LOOP
    rjmp DEC16_LOOP
DEC_END:
    pop r17
    pop r16
    ret
