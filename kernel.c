#include "xg_stddefs.h"

#define XEN_HAVE_PV_GUEST_ENTRY 1 //FIXME: This work-around is needed as the definitions for ARM64 are not done as it is done for x86
#include <xen.h>


#include "hypercalls.h"

/* Some static space for the stack */
char stack[8192];


/* Main kernel entry point, called by trampoline */
void start_kernel(start_info_t *start_info)
{
	HYPERVISOR_console_io(CONSOLEIO_write,12,"Hello World\n");
	while(1);
}
