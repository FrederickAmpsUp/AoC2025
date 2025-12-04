HC = ghc
HSFLAGS=""

%.elf: %.hs
	$(HC) $(HFLAGS) -o $@ $<
	rm $(patsubst %.elf,%.o,$@)
	rm $(patsubst %.elf,%.hi,$@)

all: $(patsubst %.hs,%.elf,$(wildcard *.hs))

clean:
	rm -f *.elf
	rm -rf build
