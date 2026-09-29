# VVdeC Library
# Makefile by Martin Eesmaa (2026)

VVDEC_VERSION := 3.2.0
VVDEC_URL := $(GITHUB)/fraunhoferhhi/vvdec/archive/v$(VVDEC_VERSION).tar.gz

$(TARBALLS)/vvdec-$(VVDEC_VERSION).tar.gz:
	$(call download_pkg,$(VVDEC_URL),vvdec)

.sum-vvdec: $(TARBALLS)/vvdec-$(VVDEC_VERSION).tar.gz

vvdec: vvdec-$(VVDEC_VERSION).tar.gz .sum-vvdec
	$(UNPACK)
	$(MOVE)

VVDEC_CONF := -DVVDEC_ENABLE_LINK_TIME_OPT=OFF

.vvdec: vvdec toolchain.cmake
	$(CMAKECLEAN)
	$(HOSTVARS) $(CMAKE) $(VVDEC_CONF)
	+$(CMAKEBUILD)
	$(CMAKEINSTALL)
	touch $@
