lib_LTLIBRARIES = libmtdev.la

libmtdev_la_LDFLAGS = -version-info @LIB_VERSION@

libmtdev_la_SOURCES = \
	$(top_srcdir)/include/mtdev-mapping.h \
	$(top_srcdir)/include/mtdev-plumbing.h \
	common.h \
	evbuf.h \
	iobuf.h \
	match.h \
	state.h \
	caps.c \
	core.c \
	iobuf.c \
	match.c \
	match_four.c

AM_CFLAGS = $(CWARNFLAGS) #-DMTDEV_NO_LEGACY_ABI

INCLUDES = -I$(top_srcdir)/include/

libmtdevincludedir = $(includedir)
libmtdevinclude_HEADERS = \
	$(top_srcdir)/include/mtdev-mapping.h \
	$(top_srcdir)/include/mtdev-plumbing.h \
	$(top_srcdir)/include/mtdev.h


# Only Android stuff below this line

Android.mk: Makefile
	androgenizer \
	-:PROJECT mtdev \
	-:REL_TOP $(top_srcdir) -:ABS_TOP $(abs_top_srcdir) \
	\
	-:STATIC libmtdev \
	-:TAGS eng debug \
	-:SOURCES $(libmtdev_la_SOURCES) \
	-:CFLAGS $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(AM_CFLAGS) \
	\
	-:PASSTHROUGH 'mtdev-clean: clean-libmtdev' \
	> $@

