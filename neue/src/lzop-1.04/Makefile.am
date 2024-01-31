## Process this file with automake to create Makefile.in
#
#  Makefile --- Makefile for building lzop
#
#  This file is part of the lzop file compressor.
#    http://www.oberhumer.com/opensource/lzop/
#
#  Copyright (C) 1996-2017 Markus Franz Xaver Johannes Oberhumer
#  All Rights Reserved.
#

dist_doc_DATA =
dist_man1_MANS =
EXTRA_DIST =
CLEANFILES =
DISTCLEANFILES =
SUFFIXES = .1 .html .man .pod .ps .tex .txt

##/***********************************************************************
##// TOPDIR
##************************************************************************/

dist_doc_DATA += AUTHORS COPYING NEWS README THANKS
EXTRA_DIST += CMakeLists.txt autoconf/shtool

dist-hook: dist-hook-1
dist-hook-1:
	cp -pR '$(srcdir)/B/' '$(distdir)/'
.PHONY: dist-hook-1

##/***********************************************************************
##// SUBDIR src
##************************************************************************/

bin_PROGRAMS = src/lzop

src_lzop_SOURCES = \
    src/c_ansic.c src/c_ansim.c src/c_init.c src/c_none.c src/c_screen.c \
    src/compress.c src/djgpp2.c src/filter.c src/frames.c src/help.c \
    src/lzop.c src/mblock.c src/p_lzo.c src/s_curses.c src/s_djgpp2.c \
    src/s_object.c src/s_vcsa.c src/util.c

EXTRA_DIST += \
    src/conf.h src/console.h src/frames.h src/miniacc.h src/screen.h \
    src/version.h

##/***********************************************************************
##// SUBDIR doc
##************************************************************************/

built_docs = doc/lzop.html doc/lzop.man doc/lzop.ps doc/lzop.tex doc/lzop.txt
built_mans = doc/lzop.1

dist_doc_DATA  += $(built_docs) doc/lzop.pod
dist_man1_MANS += $(built_mans)
EXTRA_DIST     += doc/magic
DISTCLEANFILES += doc/$(am__dirstamp)
DOCCLEANFILES   =

doc/$(am__dirstamp):
	@$(MKDIR_P) doc
	@: > doc/$(am__dirstamp)

doc-clean:
	-test -z "$(DOCCLEANFILES)" || rm -f $(DOCCLEANFILES)
.PHONY: doc-clean

if MAINTAINER_MODE

CLEANFILES    += $(built_docs) $(built_mans)
DOCCLEANFILES += $(built_docs) $(built_mans)

$(built_docs) $(built_mans) : doc/$(am__dirstamp)
.DELETE_ON_ERROR: $(built_docs) $(built_mans)

## rules begin
.pod.1:
	pod2man --center=" " --release="$(PACKAGE) $(VERSION)" --date="2017-08-10" $< > $@

.pod.html:
	pod2html --noindex $< > $@
	-rm -f pod2htm*

.pod.tex:
	pod2latex -out $@ $<

.pod.txt:
	pod2text < $< > $@

.1.man:
	nroff -man $< > $@

.1.ps:
	groff -man $< > $@
## rules end

endif # MAINTAINER_MODE

@MAINT@-include $(top_srcdir)/Makefile.maint
