<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [3 Roadmap](#3-roadmap)
  - [3.1 When the shell starts](#31-when-the-shell-starts)
  - [3.2 Interactive Use](#32-interactive-use)
    - [3.2.1 Completion](#321-completion)
    - [3.2.2 Extending the line editor](#322-extending-the-line-editor)
  - [3.3 Options](#33-options)
  - [3.4 Pattern Matching](#34-pattern-matching)
  - [3.5 General Comments on Syntax](#35-general-comments-on-syntax)
  - [3.6 Programming](#36-programming)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Roadmap"></span> <span id="Roadmap-1"></span>

# 3 Roadmap

<span id="index-roadmap"></span>

The Zsh Manual, like the shell itself, is large and often complicated.
This section of the manual provides some pointers to areas of the shell
that are likely to be of particular interest to new users, and indicates
where in the rest of the manual the documentation is to be found.

------------------------------------------------------------------------

<span id="When-the-shell-starts"></span>

## 3.1 When the shell starts

When it starts, the shell reads commands from various files. These can
be created or edited to customize the shell. See
[Files](Files.html#Files).

If no personal initialization files exist for the current user, a
function is run to help you change some of the most common settings. It
won’t appear if your administrator has disabled the zsh/newuser module.
The function is designed to be self-explanatory. You can run it by hand
with ‘autoload -Uz zsh-newuser-install; zsh-newuser-install -f’. See
also [User Configuration
Functions](User-Contributions.html#User-Configuration-Functions).

------------------------------------------------------------------------

<span id="Interactive-Use"></span>

## 3.2 Interactive Use

Interaction with the shell uses the builtin Zsh Line Editor, ZLE. This
is described in detail in [Zsh Line
Editor](Zsh-Line-Editor.html#Zsh-Line-Editor).

The first decision a user must make is whether to use the Emacs or Vi
editing mode as the keys for editing are substantially different. Emacs
editing mode is probably more natural for beginners and can be selected
explicitly with the command bindkey -e.

A history mechanism for retrieving previously typed lines (most simply
with the Up or Down arrow keys) is available; note that, unlike other
shells, zsh will not save these lines when the shell exits unless you
set appropriate variables, and the number of history lines retained by
default is quite small (30 lines). See the description of the shell
variables (referred to in the documentation as parameters) HISTFILE,
HISTSIZE and SAVEHIST in [Parameters Used By The
Shell](Parameters.html#Parameters-Used-By-The-Shell). Note that it’s
currently only possible to read and write files saving history when the
shell is interactive, i.e. it does not work from scripts.

The shell now supports the UTF-8 character set (and also others if
supported by the operating system). This is (mostly) handled
transparently by the shell, but the degree of support in terminal
emulators is variable. There is some discussion of this in the shell
FAQ, <https://www.zsh.org/FAQ/>. Note in particular that for combining
characters to be handled the option COMBINING_CHARS needs to be set.
Because the shell is now more sensitive to the definition of the
character set, note that if you are upgrading from an older version of
the shell you should ensure that the appropriate variable, either LANG
(to affect all aspects of the shell’s operation) or LC_CTYPE (to affect
only the handling of character sets) is set to an appropriate value.
This is true even if you are using a single-byte character set including
extensions of ASCII such as ISO-8859-1 or ISO-8859-15. See the
description of LC_CTYPE in [Parameters](Parameters.html#Parameters).

------------------------------------------------------------------------

<span id="Completion-1"></span>

### 3.2.1 Completion

Completion is a feature present in many shells. It allows the user to
type only a part (usually the prefix) of a word and have the shell fill
in the rest. The completion system in zsh is programmable. For example,
the shell can be set to complete email addresses in arguments to the
mail command from your \~/.abook/addressbook; usernames, hostnames, and
even remote paths in arguments to scp, and so on. Anything that can be
written in or glued together with zsh can be the source of what the line
editor offers as possible completions.

Zsh has two completion systems, an old, so called compctl completion
(named after the builtin command that serves as its complete and only
user interface), and a new one, referred to as compsys, organized as
library of builtin and user-defined functions. The two systems differ in
their interface for specifying the completion behavior. The new system
is more customizable and is supplied with completions for many commonly
used commands; it is therefore to be preferred.

The completion system must be enabled explicitly when the shell starts.
For more information see [Completion
System](Completion-System.html#Completion-System).

------------------------------------------------------------------------

<span id="Extending-the-line-editor"></span>

### 3.2.2 Extending the line editor

Apart from completion, the line editor is highly extensible by means of
shell functions. Some useful functions are provided with the shell; they
provide facilities such as:

insert-composed-char  
composing characters not found on the keyboard

match-words-by-style  
configuring what the line editor considers a word when moving or
deleting by word

history-beginning-search-backward-end, etc.  
alternative ways of searching the shell history

replace-string, replace-pattern  
functions for replacing strings or patterns globally in the command line

edit-command-line  
edit the command line with an external editor.

See [ZLE Functions](User-Contributions.html#ZLE-Functions) for
descriptions of these.

------------------------------------------------------------------------

<span id="Options-1"></span>

## 3.3 Options

The shell has a large number of options for changing its behaviour.
These cover all aspects of the shell; browsing the full documentation is
the only good way to become acquainted with the many possibilities. See
[Options](Options.html#Options).

------------------------------------------------------------------------

<span id="Pattern-Matching"></span>

## 3.4 Pattern Matching

The shell has a rich set of patterns which are available for file
matching (described in the documentation as ‘filename generation’ and
also known for historical reasons as ‘globbing’) and for use when
programming. These are described in [Filename
Generation](Expansion.html#Filename-Generation).

Of particular interest are the following patterns that are not commonly
supported by other systems of pattern matching:

\*\*  
for matching over multiple directories

\|  
for matching either of two alternatives

\~, ^  
the ability to exclude patterns from matching when the EXTENDED_GLOB
option is set

(`...`)  
glob qualifiers, included in parentheses at the end of the pattern,
which select files by type (such as directories) or attribute (such as
size).

------------------------------------------------------------------------

<span id="General-Comments-on-Syntax"></span>

## 3.5 General Comments on Syntax

Although the syntax of zsh is in ways similar to the Korn shell, and
therefore more remotely to the original UNIX shell, the Bourne shell,
its default behaviour does not entirely correspond to those shells.
General shell syntax is introduced in [Shell
Grammar](Shell-Grammar.html#Shell-Grammar).

One commonly encountered difference is that variables substituted onto
the command line are not split into words. See the description of the
shell option SH_WORD_SPLIT in [Parameter
Expansion](Expansion.html#Parameter-Expansion). In zsh, you can either
explicitly request the splitting (e.g. ${=foo}) or use an array when you
want a variable to expand to more than one word. See [Array
Parameters](Parameters.html#Array-Parameters).

------------------------------------------------------------------------

<span id="Programming"></span>

## 3.6 Programming

The most convenient way of adding enhancements to the shell is typically
by writing a shell function and arranging for it to be autoloaded.
Functions are described in [Functions](Functions.html#Functions). Users
changing from the C shell and its relatives should notice that aliases
are less used in zsh as they don’t perform argument substitution, only
simple text replacement.

A few general functions, other than those for the line editor described
above, are provided with the shell and are described in [User
Contributions](User-Contributions.html#User-Contributions). Features
include:

promptinit  
a prompt theme system for changing prompts easily, see [Prompt
Themes](User-Contributions.html#Prompt-Themes)

zsh-mime-setup  
a MIME-handling system which dispatches commands according to the suffix
of a file as done by graphical file managers

zcalc  
a calculator

zargs  
a version of xargs that makes the find command redundant

zmv  
a command for renaming files by means of shell patterns.

------------------------------------------------------------------------

This document was generated on *May 14, 2022* using [*texi2html
5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.9, released on May 14, 2022.
