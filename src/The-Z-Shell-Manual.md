<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [1 The Z Shell Manual](#1-the-z-shell-manual)
  - [1.1 Producing documentation from zsh.texi](#11-producing-documentation-from-zshtexi)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="The-Z-Shell-Manual"></span>
<span id="The-Z-Shell-Manual-1"></span>

# 1 The Z Shell Manual

This document has been produced from the texinfo file `zsh.texi`,
included in the `Doc` sub-directory of the Zsh distribution.

-----

<span id="Producing-documentation-from-zsh_002etexi"></span>

## 1.1 Producing documentation from zsh.texi

The texinfo source may be converted into several formats:

  - The Info manual  
    The Info format allows searching for topics, commands, functions,
    etc. from the many Indices. The command ‘`makeinfo zsh.texi`’ is
    used to produce the Info documentation.

  - The printed manual  
    The command ‘`texi2dvi zsh.texi`’ will output `zsh.dvi` which can
    then be processed with dvips and optionally gs (Ghostscript) to
    produce a nicely formatted printed manual.

  - The HTML manual  
    An HTML version of this manual is available at the Zsh web site via:
    
    `http://zsh.sourceforge.net/Doc/`.
    
    (The HTML version is produced with texi2html, which may be obtained
    from `http://www.nongnu.org/texi2html/`. The command is ‘`texi2html
    –output . –ifinfo –split=chapter –node-files zsh.texi`’. If
    necessary, upgrade to version 1.78 of texi2html.)

For those who do not have the necessary tools to process texinfo,
precompiled documentation (PostScript, dvi, PDF, info and HTML formats)
is available from the zsh archive site or its mirrors, in the file
`zsh-doc.tar.gz`. (See [Availability](Introduction.html#Availability)
for a list of sites.)

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
