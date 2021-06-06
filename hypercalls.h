#ifndef HYPERCALLS_AARCH64_H
#define HYPERCALLS_AARCH64_H

int HYPERVISOR_console_io(unsigned int cmd, unsigned int cnt, char buffer[]);

#endif