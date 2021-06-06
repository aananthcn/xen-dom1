CC=aarch64-none-elf-gcc
LD=aarch64-none-elf-ld
OBJCOPY=aarch64-none-elf-objcopy
ARCH = arm64
XEN_SRC = ../xen

TARGET = dom1_image

LDFLAGS  += -nostdlib
CFLAGS   += -Werror -I${XEN_SRC}/xen/include/public -D XEN_HAVE_PV_GUEST_ENTRY=1 
ASFLAGS  += -D__ASSEMBLY__ -I${XEN_SRC}/xen/include/public

$(info compilating for arm64)
CFLAGS  += -march=armv8-a
ASFLAGS += -march=armv8-a
LDFLAGS += -m aarch64elf -T xen-dom1.lds
OBJS    += bootstrap.aarch64.o


.PHONY: all

all: clean ${TARGET}

${TARGET}: $(OBJS) kernel.o hypercalls.o
	@echo Compiled for ARCH=${ARCH}
	$(LD) $(LDFLAGS) $^ -o ${TARGET}
	$(OBJCOPY) -O binary ${TARGET} ${TARGET}.bin
	rm -f ${TARGET}

info:
	@echo make can be run with var ARCH={arm64}
	@echo By default ARCH=arm64

clean:
	rm -f *.o 
	rm -f ${TARGET}.bin
