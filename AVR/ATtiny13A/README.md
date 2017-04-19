# AVR ATtiny13A

Datasheet can be found on Atmel's website

## Toolchain

### Windows 

Download WinAVR which contains all tools needed to build your applications. It will automatically updated your PATH so that those tools can be run from any folder.

Some tools provided with the package are 
 * GNU GCC for C and C++
 * Some commn apps usually found on linux like wget, ls, md5sum and much more ! 
 * A graphical text-editor oriented towards coding, automating builds etc...
 * AVRdude for uploading your code to the microcontroller.
 * Include files for a big list of AVR microcontrollers. The file avr/include/avr/iotn13a.h will be used in this project.

I personally prefer text editors like VIM which can be also installed on Windows.

### Linux

The toolchains can be found quite easily on most of the major distributions of linux.

### Programmer

You'll also need a hardware programmer to upload your code on the microcontroller. If you own an Arduino, it can usually be used to program those devices.

In my case, I'm using a USBISP device which does not seems to work with AVRdude (seems to need some hardware hack). So I'm using ProgISP on windows to do the job.

ProgISP can be downloaded from Electrogradon website.

## Your first code 

### Light a led

```Assembly
.include "iotn13a.h"

; Defining ports addresses
.EQN DDRB ,0x17
.EQN PORTB,0x18

; Tell the assembler that our code will execute at address 0x0 in memory
.org 0x0

; Defining Interrup Vector table
    rjmp RESET	; RESET interrupt handler - This MUST be defined as the microcontroller will start execution here.

RESET:
    sbi DDRB,0	    ; Set PIN0 to OUTPUT mode
    sbi PORTB,0	    ; Set PIN0 to HIGH

END:
    rjmp END	    ; Loop endlessly :)

```
