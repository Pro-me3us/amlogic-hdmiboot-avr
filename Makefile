MCU := attiny88
PROGPORT := /dev/ttyUSB0

CC := avr8-gnu-toolchain-linux_x86_64/bin/avr-gcc
CFLAGS := -mmcu=$(MCU) -Wall -Wextra -O2 -std=gnu11
LDFLAGS := -mmcu=$(MCU)

i2c-flash: i2c-flash.o

.PHONY: program
program: i2c-flash
	avrdude -c arduino -p $(MCU) -b 57600 -P $(PROGPORT) -D -U flash:w:$<:e
