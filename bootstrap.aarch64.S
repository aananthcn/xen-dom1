;#include <arch-x86_64.h>

.section __xen_guest
	.ascii	"GUEST_OS=Mini-OS"
	.ascii	",XEN_VER=xen-3.0"
	.ascii	",VIRT_BASE=0x0" /* &_text from minios_x86_64.lds */
	.ascii	",ELF_PADDR_OFFSET=0x0"
	.ascii	",HYPERCALL_PAGE=0x2"
	.ascii	",LOADER=generic"
	.byte	0
.text

#define ENTRY(X) .globl X ; X :
.globl _start, shared_info, hypercall_page


_start:
    # zImage header
.rept   8
    mov     x0, x0
.endr
    b       1f
    .word   0x016f2818      ;# Magic numbers to help the loader
    .word   0               ;# absolute load/run zImage address (0 = use start of RAM + 0x8000)
    .word   _end - _start   ;# zImage size
    # @ end of zImage header
1:
        ldr     lr, =__exit ;# Set up LR so when main returns, it goes nowhere      
        b       start_kernel
__exit:
        b       .

stack_start:
        .quad stack+(2*8192)

        /* Unpleasant -- the PTE that maps this page is actually overwritten */
        /* to map the real shared-info page! :-)                             */
        .org 0x1000
shared_info:

        .org 0x2000
hypercall_page:

        .org 0x3000
