### Guide to making an Amlogic HDMI recovery dongle with an MH-ET Live Tiny88

To flash your <a href="https://forum.mhetlive.com/topic/47/mh-et-live-tiny88-16-0mhz">MH-ET Live Tiny88</a> with one of the two included compiled binaries, open a terminal window. Connect the Tiny88 to your computer and the red LED will blink to indicate it's ready to be flashed.

To have your Amlogic box boot from USB, flash the Tiny88 with:<br>
<code>sudo ./micronucleus --dump-progress filename i2c-flash_USB.hex</code>

Or to boot from SDcard instead, flash the Tiny88 with:<br>
<code>sudo ./micronucleus --dump-progress filename i2c-flash_SDcard.hex</code>
<br><br>

### Instructions for compiling the ihex files from source

1) Edit <i>i2c-flash.c</i> to choose whether to boot from USB (boot@USB) or SDcard (boot@SDC), lines 8 and 9.

2) Edit <i>Makefile</i> to match your AVR chip model (MCU), and the <a href="https://www.microchip.com/en-us/tools-resources/develop/microchip-studio/gcc-compilers">AVR compiler</a> (CC) path to point to the location on your computer. 

3) Open a terminal window and compile the program by typing <code>make</code> to create the i2c-flash ELF binary

4) The i2c-flash ELF binary needs to be converted to ihex to work with MH-ET Live Tiny88's <a href="https://github.com/micronucleus/micronucleus">Micronucleus</a> bootloader.<br> 
<code>objcopy -O ihex i2c-flash i2c-flash.hex</code>

5) Lastly the <a href="https://github.com/micronucleus/micronucleus/releases/">Micronucleus programmer</a> (version 2.6) is used to flash the Tiny88 with the I2C emulator.<br>
<code>sudo ./micronucleus --dump-progress filename i2c-flash.hex</code>

<b>Note:</b> When powering on / resetting the Tiny88 the red LED will flash for 10 seconds and then the I2C emulator will be active. 
<br><br>

### Wiring MH-ET Live Tiny88 to an HDMI breakout board
Connect the following pins with 3 wires: 

Tiny88 pin A5 SCL (clock) to HDMI pin 15<br>
Tiny88 pin A4 SDA (data)  to HDMI pin 16<br>
Tiny88 pin GND (ground)	  to HDMI pin 17	 


### Background (Original Project Description)
This project is a very simple emulator of an I2C flash for AVR microcontrollers,
designed to trigger BootROM recovery mode on Amlogic SoCs like the S905Y2.
See [here][1] and [here][2] for prior work. Unlike the Arduino sketch in the
Exploitee.rs release, which was designed for the ARM core on an Arduino Due,
this implementation is fast enough to avoid clock stretching on an AVR core,
which is critical since Amlogic's BootROM I2C master does not support clock
stretching.

I've tested this on an Arduino Duemilanove, but it will definitely work on any
board with an ATmega48/88/168/328, and possibly others. Just set `MCU`
appropriately in the Makefile.

To use, attach the SCL and SDA DDC lines (pins 15 and 16, respectively) of an
HDMI breakout to the I2C lines on your AVR (which are PC5 and PC4, respectively,
on the ATmega48/88/168/328), connect the HDMI port to your target device, then
apply power to the device. It should enter BootROM USB DFU mode with no
additional interaction needed.

[1]: https://www.exploitee.rs/index.php/FireFU_Exploit
[2]: https://github.com/superna9999/linux/wiki/Amlogic-HDMI-Boot-Dongle
<br><br>

### Acknowlegments
Thank you to <a href="https://github.com/tchebb">Tom Hebb</a> for his AVR I2C emulator and for helping me to get it to run on the MH-ET Live Tiny88.


