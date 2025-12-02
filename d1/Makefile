CC=gcc
CFLAGS=-Wall

%.elf: %.c
	$(CC) $(CFLAGS) -o $@ $<

all: $(patsubst %.c,%.elf,$(wildcard *.c))

clean:
	rm -f *.elf
