#!/bin/sh

cd `dirname $0`

cat <<EOP |patch -p0
--- Makefile	2012-01-16 17:03:47.000000000 +0900
+++ Makefile	2012-01-18 01:23:54.000000000 +0900
@@ -37,6 +37,7 @@
 	@echo "  changes    to make an overview of all changed/added/deprecated items"
 	@echo "  linkcheck  to check all external links for integrity"
 	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"
+	@echo "  pdf        to to make pdf file"
 
 clean:
 	-rm -rf \$(BUILDDIR)/*
@@ -151,3 +152,8 @@
 	\$(SPHINXBUILD) -b doctest \$(ALLSPHINXOPTS) \$(BUILDDIR)/doctest
 	@echo "Testing of doctests in the sources finished, look at the " \\
 	      "results in \$(BUILDDIR)/doctest/output.txt."
+
+pdf:
+	\$(SPHINXBUILD) -b pdf \$(ALLSPHINXOPTS) \$(BUILDDIR)/pdf
+	@echo
+	@echo "Build finished. The PDF files are in \$(BUILDDIR)/pdf."
EOP


cat <<EOP >> source/conf.py

## pdf by rst2pdf
extensions += ['rst2pdf.pdfbuilder']
pdf_documents = [ 
    (master_doc, project, project, copyright),
]
pdf_stylesheets = ['sphinx','kerning','a4','ja']
pdf_language = "ja"
# Mode for literal blocks wider than the frame. Can be
# overflow, shrink or truncate
#pdf_fit_mode = "shrink"

# Section level that forces a break page.
# For example: 1 means top-level sections start in a new page
# 0 means disabled
#pdf_break_level = 0

# When a section starts in a new page, force it to be 'even', 'odd',
# or just use 'any'
pdf_breakside = 'any'

# Insert footnotes where they are defined instead of 
# at the end.
pdf_inline_footnotes = True

# verbosity level. 0 1 or 2
pdf_verbosity = 0

# If false, no index is generated.
pdf_use_index = True

# If false, no modindex is generated.
pdf_use_modindex = True

# If false, no coverpage is generated.
pdf_use_coverpage = True

# Name of the cover page template to use
#pdf_cover_template = 'sphinxcover.tmpl'

# Documents to append as an appendix to all manuals.    
#pdf_appendices = []

# Enable experimental feature to split table cells. Use it
# if you get "DelayedTable too big" errors
#pdf_splittables = False

# Set the default DPI for images
#pdf_default_dpi = 72

# Enable rst2pdf extension modules (default is only vectorpdf)
# you need vectorpdf if you want to use sphinx's graphviz support
#pdf_extensions = ['vectorpdf']

# Page template name for "regular" pages
#pdf_page_template = 'cutePage'

# Show Table Of Contents at the beginning?
pdf_use_toc = True

# How many levels deep should the table of contents be?
pdf_toc_depth = 2

# Add section number to section references
pdf_use_numbered_links = False

# Background images fitting mode
pdf_fit_background_mode = 'scale'

EOP

cat <<EOP >> ja.json
{
  "fontsAlias" : {
    "stdFont": "HeiseiKakuGo-W5",
    "stdBold": "HeiseiKakuGo-W5",
    "stdItalic": "HeiseiKakuGo-W5",
    "stdBoldItalic": "HeiseiKakuGo-W5",
    "stdMono": "Ricty"
  },
  "styles" : [
        ["base",    { "wordWrap": "CJK"}],
        ["literal", { "wordWrap": "None"}],
        ["normal",  { "wordWrap": "CJK"}]]
}
EOP

touch source/_templates/searchbox.html

