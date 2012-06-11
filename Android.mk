LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

MTDEV_TOP := $(LOCAL_PATH)

MTDEV_BUILT_MAKEFILES := \
	$(MTDEV_TOP)/src/Android.mk

mtdev-configure:
	cd $(MTDEV_TOP) && autoreconf -fiv
	cd $(MTDEV_TOP) && \
		CC="$(CONFIGURE_CC)" \
		CFLAGS="$(CONFIGURE_CFLAGS)" \
		LD=$(TARGET_LD) \
		LDFLAGS="$(CONFIGURE_LDFLAGS)" \
		CPP=$(CONFIGURE_CPP) \
		CPPFLAGS="$(CONFIGURE_CPPFLAGS)" \
		PKG_CONFIG_LIBDIR=$(CONFIGURE_PKG_CONFIG_LIBDIR) \
		PKG_CONFIG_TOP_BUILD_DIR=$(PKG_CONFIG_TOP_BUILD_DIR) \
		./configure --host=arm-linux-androideabi \
		--prefix /system
	rm -f $(MTDEV_BUILT_MAKEFILES)
	@for file in $(MTDEV_BUILT_MAKEFILES); do \
		echo "make -C $$(dirname $$file) $$(basename $$file)" ; \
		make -C $$(dirname $$file) $$(basename $$file) ; \
	done

mtdev-reset:
	cd $(MTDEV_TOP) && \
	git clean -qdxf && \
	git reset --hard HEAD

mtdev-clean:

.PHONY: mtdev-configure mtdev-clean mtdev-reset

CONFIGURE_TARGETS += mtdev-configure
CONFIGURE_RESET_TARGETS += mtdev-reset
AGGREGATE_CLEAN_TARGETS += mtdev-clean
CONFIGURE_PKG_CONFIG_LIBDIR := $(CONFIGURE_PKG_CONFIG_LIBDIR):$(MTDEV_TOP)

-include $(MTDEV_BUILT_MAKEFILES)

