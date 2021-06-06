#include "xg_stddefs.h"

#define XEN_IMM 0xEA1

int HYPERVISOR_console_io(unsigned int cmd, unsigned int cnt, char buffer[])
{
    uint64_t x0_reg, x1_reg, x2_reg;
    x0_reg = (uint64_t) cmd;
    x1_reg = (uint64_t) cnt;
    x2_reg = (uint64_t) buffer;
    
    asm("MOV X2, %[x_2]" :: [x_2] "r" (x2_reg));
    asm("MOV X1, %[x_1]" :: [x_1] "r" (x1_reg));
    asm("MOV X0, %[x_0]" :: [x_0] "r" (x0_reg));
    asm("hvc #0xEA1" :: );

    return 0;
}
