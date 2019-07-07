DEBOOTSTRAP	= debootstrap
TARGET		= /mnt/dist
ARCH		= amd64
#ARCH		= armhf
SUITE		= stretch
EXCLUDE_PACKAGE	= aptitude,nano
INCLUDE_PACKAGE	= console-setup,keyboard-configuration,locales,ntp,less,ssh,vim,screen,htop
MIRROR		= http://ftp.jp.debian.org/debian

ifdef EXCLUDE_PACKAGE
PACKAGE_MANIFEST += --exclude=$(EXCLUDE_PACKAGE)
# EXCLUDE_PACKAGE
endif
ifdef INCLUDE_PACKAGE
PACKAGE_MANIFEST += --include=$(INCLUDE_PACKAGE)
# INCLUDE_PACKAGE
endif

all install:
	@$(DEBOOTSTRAP)					\
		--foreign				\
		--arch=$(ARCH)				\
		$(PACKAGE_MANIFEST)			\
		$(SUITE)				\
		$(TARGET)				\
		$(MIRROR)

chroot:
	@chroot $(TARGET) /usr/bin/env -i HOME=/root PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/sh -l

clean:
	-$(RM) -r $(TARGET)/*

.PHONY: all clean
