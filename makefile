CC = arm-none-eabi-gcc

CFLAGS = -c -mcpu=$(MACH) -std=gnu11 -mthumb -Wall	# $ : means get what is the inside the variable

LDFLAGS = -T STM32F446_LS.ld -nostdlib -Wl,-Map=final.map

MACH = cortex-m4

main.o: main.c
	$(CC) $(CFLAGS) $^ -o $@

RCC_program.o: RCC_program.c
	$(CC) $(CFLAGS) $^ -o $@

GPIO_program.o: GPIO_program.c
	$(CC) $(CFLAGS) $^ -o $@

STM32_F446REStartup.o: STM32_F446REStartup.c
	$(CC) $(CFLAGS) $^ -o $@	

final.elf: main.o RCC_program.o GPIO_program.o STM32_F446REStartup.o
	$(CC) $(LDFLAGS) $^ -o $@

All: main.o GPIO_program.o RCC_program.o STM32_F446REStartup.o final.elf

Clean: 
	rm -rf *.o *.elf		

Load:
	openocd -f board/st_nucleo_f4.cfg