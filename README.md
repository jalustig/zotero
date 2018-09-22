# Zotero tools

These scripts are tools I've developed to help manage zotero citations

# Requirements

 - OS X -- required because it uses applescript & macOS finder tags
 - Zotero (and perhaps *zotfile* plugin)
 - perl
 - sqlite3
 - *tags* CLI utility (can be installed via `brew`)

# Usage & Notes

**zoterotags.pl**

This script helps correlate your Zotero database with the PDF files which are stored in your computer and linked to citation. If you use the Zotfile plugin, these files will be organized elsewhere on your computer but you may want to search them effectively using spotlight! This script will bring tags from your citations to the PDF files directly, so for instance you can search "author name tag:article" and it will only bring up that person's articles. It does this for journal articles (tag:article), books (tag:book), and theses/dissertations (tag:dissertation).

It will also tag any PDF files as "important" which you have marked with a tag of that name in zotero.