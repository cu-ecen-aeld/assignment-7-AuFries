# Comment/uncomment the following line to disable/enable debugging
#DEBUG = y

ifeq ($(DEBUG),y)
  DEBFLAGS = -O -g -DSCULL_DEBUG
else
  DEBFLAGS = -O2
endif

ifneq ($(KERNELRELEASE),)
# called from kernel build system

ccflags-y += $(DEBFLAGS)
ccflags-y += -I$(src)/../include

scull-objs := main.o pipe.o access.o
obj-m := scull.o

else

KERNELDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.mod modules.order *.symvers

endif

depend .depend dep:
	$(CC) $(EXTRA_CFLAGS) -M *.c > .depend


ifeq (.depend,$(wildcard .depend))
include .depend
endif
