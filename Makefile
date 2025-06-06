# $Id: Makefile.in,v 1.1 2021/07/21 13:06:31 rbj Exp $

# This is the makefile for "Taylor Momsen".
#
# Intended as a series of volumes comprising everything I have to say.
# Three kinds of volume are envisaged at present.
#
# 1. Prose
# 2. Formal Materials using ProofPower or other proof tools
# 3. Theory listings
#
# All are to be made available as A4 PDF, the prose material in two columns
# the formal materials and theory listings in one.
#
# Two formats will be produced for hard copy POD publishing, the prose in
# the smallest standard format, the others in the largest.
# The prose volumes will also be converted to HTML, possibly also to the
# kindle format, when amazon allows non US authors to publish in that format.
#
# It is not intended that this directory contain the sources, apart from
# materials specific to the book formats.  In general the chapters of the
# books (or in some cases whole "parts") will be the body of documents drawn
# from other directories, of which the principal sources are rbjpub/pp/doc
# for the formal materials and rbjpub/www/papers for prose.
#
# The general plan is to have for each volume in the collected works/ideas
# a single tex file which provides the entire content of the work, primarily
# by including files from other directories, but which does not include
# the preliminary materials which determine the format of the resulting
# document.
# There will then typically be two, possibly more, versions of the volume
# in different formats which include the same content.
#
# To create a new volume it is necessary to undertake the following steps:
#
# 1. Chose the volume identifier (VID).
#    Volume identifiers consist of a single letter followed by a two digit
#    sequence number.
#    The single letter is:
#        P for a prose volume 
#        F for a volume containing formal material
#    The significance of the letter is that prose goes in small books, or
#    in two column A4, whereas formal materials need more width and are
#    always single column and come as books in
#    the largest standard format for amazon POD or in A4.
# 2. Identify the external source files and define a set of make variables
#    which list the sources from each different source directory.
#    The naming convention is: VolumeId DirId CPY	
# 3. Write the single top level source file which combines these source
#    documents into one volume, using \input to include those files.
# 4. Write a separate highest level document for each format required,
#    which inputs the single combined content in the appropriate place.
# 5. Put in the dependencies for the PDF and html versions to be produced.
# 6. Add the names of the required output files into the relevant lists
#    for building $(TEXPDF) for pdf files, $(LATEX2HTM) for html versions.
# 7. Add the pdf file names to $(WEBFILES) and the html directories to
#    $(WEBDIRS).
#
# It is convenient to have short name for each of the different directories
# from which materials are sourced.
# The following table supplies these names.
# The copying of the files from the relevant directories is effected by the
# following rules.

IABDIR=$(TOPSRCDIR)/src/rbjpub/rbjcv/rjiab
PPDDIR=$(TOPSRCDIR)/src/rbjpub/pp/doc
PAPDIR=$(TOPSRCDIR)/src/rbjpub/www/papers

# The copying of the files from the relevant directories is effected by the
# following rules.

IABCPY=$(P01IABCPY)

include @top_srcdir@/top_srcdir.mk

RELSRCDIR=src/rbjpub/www/books/cw
RELWEBDIR=rbjpub/www/books/cw
SUBDIRS=

XML007x=index.xml

ENTFILES=pp-symbol.ent

VOLS=p01.tex
BUKS=$(VOLS:.tex=b.pdf)
PAMS=$(VOLS:.tex=p.pdf)
HTMS=$(VOLS:.tex=b.htm)

# Volume P01 - Intellectual Autobiography

P01SRCCPY=p01.tex p01b.tex p01p.tex
P01IABCPY=rjiab01.tex rjiab02.tex rjiabrt.tex rjiabgl.tex

SRCDIRBIB=

COMDIRCPY=cwpp.sty cwpb.sty
SRCDIRCPY=$(P01SRCCPY)
XLDPDIRCPY=$(ENTFILES)
TEXPDF=$(BUKS) $(PAMS)

include $(TOPSRCDIR)/build/common/vars.mk

#LATEX2HTM=p01b.htm
BUILDEXTRAS=$(LATEX2HTM)
WEBFILES=$(HTML007x) $(PAMS) $(HTMS)
WEBSUBDIRS=p01b

include $(TOPSRCDIR)/src/common/rules.mk

# Paths

vpath %.bib $(COMDIR)
vpath %.gdf $(COMDIR)
vpath %.in $(SRCDIR)
vpath %.xml $(SRCDIR)
vpath %.xsl $(XLCOMDIR)

# Rules

SHELL = /bin/sh

# Paths

# Variables

# General rules

$(IABCPY): %: $(IABDIR)/%
	cp $(IABDIR)/$@ .

$(PPDCPY): %: $(PPDDIR)/%
	cp $(PPDDIR)/$@ .

$(PAPCPY): %: $(PAPDIR)/%
	cp $(PAPDIR)/$@ .

# Qualified rules

# Specific rules

size: $(BODYTEX)
	@wc attik.tex
	@wc $(BODYTEX)

# Phonies

buks: $(BUKS)

# General Dependencies

$(BUKS): %.pdf: %.tex cwpb.sty

$(PAMS): %.pdf: %.tex cwpp.sty

$(HTMS): %.htm: %.pdf

# Specific Dependencies

p01b.pdf p01p.pdf: p01.tex $(P01IABCPY)
