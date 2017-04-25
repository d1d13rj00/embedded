# AVR ATtiny13A

## Toolchain

### Windows 

Download WinAVR which contains all tools needed to build your applications. It will automatically updated your PATH so that those tools can be run from any folder.

Some tools provided with the package are 
 * GNU GCC for C and C++
 * Some commn apps usually found on linux like wget, ls, md5sum and much more ! 
 * A graphical text-editor oriented towards coding, automating builds etc...
 * AVRdude for uploading your code to the microcontroller.
 * Include files for a big list of AVR microcontrollers.

I personally prefer text editors like VIM which can be also installed on Windows.

### Linux

The toolchains can be found quite easily on most of the major distributions of linux.

### Programmer

You'll also need a hardware programmer to upload your code on the microcontroller. If you own an Arduino, it can usually be used to program those devices.

In my case, I'm using a USBISP device which does not seems to work with AVRdude (seems to need some hardware hack). So I'm using ProgISP on windows to do the job.

ProgISP can be downloaded from Electrogradon website.

## ATtiny13A pinout

```
	                        ------
    (PCINT5/RESET/ADC0/dW) PB5-|o     |-VCC
	(PCINT3/CLKI/ADC3) PB3-|      |-PB2 (SCK/ADC1/T0/PCINT2)
	      PCINT4/ADC2) PB4-|      |-PB1 (MISO/AIN1/OC0B/INT0/PCINT1)
	      		   GND-|      |-PB0 (MOSI/AIN0/OC0A/PCINT0
	                        ------
```

## Your first code - Light a build

### Hardware setup

A LED should be connected to PB0 and GND, after programming the ATtiny13A

### Assembly source code

```Assembly
; Defining ports addresses to ease coding

.EQU DDRB ,0x17     ; Port direction (INPUT or OUTPUT)
.EQU PORTB,0x18     ; PORT state (HIGH or LOW)

; Tell the assembler that our code will execute at address 0x0 in memory
.org 0x0

; Defining Interrup Vector table
    rjmp RESET      ; RESET interrupt handler - Execution starts here at boot

RESET:
    sbi DDRB,0      ; Set PIN0 to OUTPUT mode
    sbi PORTB,0     ; Set PIN0 to HIGH

END:
    rjmp END        ; Loop endlessly :)
```

This can be done with the AVR toolchain by using the following steps : 

### Verify PATH

Make sure that the binaries needed are in the PATH : 

```
avr-as.exe --version
```

If the system does not recognize the program, then add it to PATH (You may have to adjust the folder name depending on your installation folder)

```
set PATH=%PATH%;C:\WinAVR-20100110\bin\
```

### Assembling: 

```
avr-as.exe -mmcu=attiny13a -o PROG1-lightLED.o PROG1-lightLED.s
avr-ld.exe -o PROG1-lightLED.elf PROG1-lightLED.o 
avr-objcopy.exe --output-target=ihex PROG1-lightLED.elf PROG1-lightLED.hex
```

If everything worked s expected, you should have a file called PROG1-lightLED.hex as final ouput of those 3 commands.

### Uploading code 

1. Open ProgISP on Windows
2. Plug the USB ISP to your computer
    * At this point, you shoud see an update on ProgISP console indicating that it recognized the device (Something like ZF-008 HV Programmer)
3. Select 'ATtiny13A' as device
4. Load flash (PROG1-lightLED.hex)
5. Click on Auto to upload the code (The chip will be erased and rewritten)

After successfull upload, your LED should light ! :)

## More projects
 * [Blinking LED with counters](https://github.com/d1d13rj00/embedded/blob/master/AVR/ATtiny13A/src/PROG2-blinkLED.s)

## References
 * [ATtiny13A datasheet](www.atmel.com/images/doc8126.pdf)
 * [AVR Instruction Set Manual](www.atmel.com/images/Atmel-0856-AVR-Instruction-Set-Manual.pdf)
 * [AVR Assembly tutorial](http://www.avr-asm-download.de/beginner_en.pdf)
