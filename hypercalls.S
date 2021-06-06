 # check this 
# https://github.com/torvalds/linux/blob/master/arch/arm64/xen/hypercall.S

#define XEN_IMM 0xEA1

;##############################################################
; Function: HYPERVISOR_console_io
; Makes hypervisor calls for console functions
.globl HYPERVISOR_console_io
; align 2 4 bytes and fill NOP instruction (Aarch64)
.align 4,0xD503201F
HYPERVISOR_console_io:
mov x16, #__HYPERVISOR_console_io;
	hvc XEN_IMM;
	ret;