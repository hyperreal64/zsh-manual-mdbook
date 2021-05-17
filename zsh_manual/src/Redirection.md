<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [7 Redirection](#7-redirection)
  - [7.1 Opening file descriptors using parameters](#71-opening-file-descriptors-using-parameters)
  - [7.2 Multios](#72-multios)
  - [7.3 Redirections with no command](#73-redirections-with-no-command)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Redirection"></span> <span id="Redirection-1"></span>

# 7 Redirection

<span id="index-redirection"></span>
<span id="index-file-descriptors"></span>
<span id="index-descriptors_002c-file"></span>

If a command is followed by `&` and job control is not active, then the
default standard input for the command is the empty file `/dev/null`.
Otherwise, the environment for the execution of a command contains the
file descriptors of the invoking shell as modified by input/output
specifications.

The following may appear anywhere in a simple command or may precede or
follow a complex command. Expansion occurs before `word` or `digit` is
used except as noted below. If the result of substitution on `word`
produces more than one filename, redirection occurs for each separate
filename in turn.

  - `<` `word`  
    Open file `word` for reading as standard input. It is an error to
    open a file in this fashion if it does not exist.

  - `<>` `word`  
    Open file `word` for reading and writing as standard input. If the
    file does not exist then it is created.

  - `>` `word`  
    Open file `word` for writing as standard output. If the file does
    not exist then it is created. If the file exists, and the `CLOBBER`
    option is unset, this causes an error; otherwise, it is truncated to
    zero length.

  - `>|` `word`  
    `>!` `word`  
    Same as `>`, except that the file is truncated to zero length if it
    exists, regardless of `CLOBBER`.

  - `>>` `word`  
    Open file `word` for writing in append mode as standard output. If
    the file does not exist, and the `CLOBBER` and `APPEND_CREATE`
    options are both unset, this causes an error; otherwise, the file is
    created.

  - `>>|` `word`  
    `>>!` `word`  
    Same as `>>`, except that the file is created if it does not exist,
    regardless of `CLOBBER` and `APPEND_CREATE`.

  - `<<`\[`-`\] `word`  
    The shell input is read up to a line that is the same as `word`, or
    to an end-of-file. No parameter expansion, command substitution or
    filename generation is performed on `word`. The resulting document,
    called a *here-document*, becomes the standard input.
    
    If any character of `word` is quoted with single or double quotes or
    a ‘`\`’, no interpretation is placed upon the characters of the
    document. Otherwise, parameter and command substitution occurs,
    ‘`\`’ followed by a newline is removed, and ‘`\`’ must be used
    to quote the characters ‘`\`’, ‘`$`’, ‘`‘`’ and the first character
    of `word`.
    
    Note that `word` itself does not undergo shell expansion. Backquotes
    in `word` do not have their usual effect; instead they behave
    similarly to double quotes, except that the backquotes themselves
    are passed through unchanged. (This information is given for
    completeness and it is not recommended that backquotes be used.)
    Quotes in the form `$’``...``’` have their standard effect of
    expanding backslashed references to special characters.
    
    If `<<-` is used, then all leading tabs are stripped from `word` and
    from the document.

  - `<<<` `word`  
    Perform shell expansion on `word` and pass the result to standard
    input. This is known as a *here-string*. Compare the use of `word`
    in here-documents above, where `word` does not undergo shell
    expansion.

  - `<&` `number`  
    `>&` `number`  
    The standard input/output is duplicated from file descriptor
    `number` (see man page dup2(2)).

  - `<& -`  
    `>& -`  
    Close the standard input/output.

  - `<& p`  
    `>& p`  
    The input/output from/to the coprocess is moved to the standard
    input/output.

  - `>&` `word`  
    `&>` `word`  
    (Except where ‘`>&` `word`’ matches one of the above syntaxes;
    ‘`&>`’ can always be used to avoid this ambiguity.) Redirects
    both standard output and standard error (file descriptor 2) in the
    manner of ‘`>` `word`’. Note that this does *not* have the same
    effect as ‘`>` `word` `2>&1`’ in the presence of multios (see the
    section below).

  - `>&|` `word`  
    `>&!` `word`  
    `&>|` `word`  
    `&>!` `word`  
    Redirects both standard output and standard error (file descriptor
    2) in the manner of ‘`>|` `word`’.

  - `>>&` `word`  
    `&>>` `word`  
    Redirects both standard output and standard error (file descriptor
    2) in the manner of ‘`>>` `word`’.

  - `>>&|` `word`  
    `>>&!` `word`  
    `&>>|` `word`  
    `&>>!` `word`  
    Redirects both standard output and standard error (file descriptor
    2) in the manner of ‘`>>|` `word`’.

If one of the above is preceded by a digit, then the file descriptor
referred to is that specified by the digit instead of the default 0 or
1. The order in which redirections are specified is significant. The
shell evaluates each redirection in terms of the (*file descriptor*,
*file*) association at the time of evaluation. For example:

> ... `1>``fname` `2>&1`

first associates file descriptor 1 with file `fname`. It then associates
file descriptor 2 with the file associated with file descriptor 1 (that
is, `fname`). If the order of redirections were reversed, file
descriptor 2 would be associated with the terminal (assuming file
descriptor 1 had been) and then file descriptor 1 would be associated
with file `fname`.

The ‘`|&`’ command separator described in [Simple Commands &
Pipelines](Shell-Grammar.html#Simple-Commands-_0026-Pipelines) is a
shorthand for ‘`2>&1 |`’.

The various forms of process substitution, ‘`<(``list``)`’, and
‘`=(``list``)`’ for input and ‘`>(``list``)`’ for output, are often
used together with redirection. For example, if `word` in an output
redirection is of the form ‘`>(``list``)`’ then the output is piped to
the command represented by `list`. See [Process
Substitution](Expansion.html#Process-Substitution).

-----

<span id="Opening-file-descriptors-using-parameters"></span>

## 7.1 Opening file descriptors using parameters

<span id="index-file-descriptors_002c-use-with-parameters"></span>
<span id="index-parameters_002c-for-using-file-descriptors"></span>

When the shell is parsing arguments to a command, and the shell option
`IGNORE_BRACES` is not set, a different form of redirection is allowed:
instead of a digit before the operator there is a valid shell identifier
enclosed in braces. The shell will open a new file descriptor that is
guaranteed to be at least 10 and set the parameter named by the
identifier to the file descriptor opened. No whitespace is allowed
between the closing brace and the redirection character. For example:

> ... `{myfd}>&1`

This opens a new file descriptor that is a duplicate of file descriptor
1 and sets the parameter `myfd` to the number of the file descriptor,
which will be at least 10. The new file descriptor can be written to
using the syntax `>&$myfd`. The file descriptor remains open in
subshells

The syntax `{``varid``}>&-`, for example `{myfd}>&-`, may be used to
close a file descriptor opened in this fashion. Note that the parameter
given by `varid` must previously be set to a file descriptor in this
case.

It is an error to open or close a file descriptor in this fashion when
the parameter is readonly. However, it is not an error to read or write
a file descriptor using `<&$``param` or `>&$``param` if `param` is
readonly.

If the option `CLOBBER` is unset, it is an error to open a file
descriptor using a parameter that is already set to an open file
descriptor previously allocated by this mechanism. Unsetting the
parameter before using it for allocating a file descriptor avoids the
error.

Note that this mechanism merely allocates or closes a file descriptor;
it does not perform any redirections from or to it. It is usually
convenient to allocate a file descriptor prior to use as an argument to
`exec`. The syntax does not in any case work when used around complex
commands such as parenthesised subshells or loops, where the opening
brace is interpreted as part of a command list to be executed in the
current shell.

The following shows a typical sequence of allocation, use, and closing
of a file descriptor:

<div class="example">

``` example
integer myfd
exec {myfd}>~/logs/mylogfile.txt
print This is a log message. >&$myfd
exec {myfd}>&-
```

</div>

Note that the expansion of the variable in the expression `>&$myfd`
occurs at the point the redirection is opened. This is after the
expansion of command arguments and after any redirections to the left on
the command line have been processed.

-----

<span id="Multios"></span>

## 7.2 Multios

<span id="index-multios"></span>
<span id="index-MULTIOS_002c-use-of"></span>

If the user tries to open a file descriptor for writing more than once,
the shell opens the file descriptor as a pipe to a process that copies
its input to all the specified outputs, similar to tee, provided the
`MULTIOS` option is set, as it is by default. Thus:

<div class="example">

``` example
date >foo >bar
```

</div>

writes the date to two files, named ‘`foo`’ and ‘`bar`’. Note that a
pipe is an implicit redirection; thus

<div class="example">

``` example
date >foo | cat
```

</div>

writes the date to the file ‘`foo`’, and also pipes it to cat.

Note that the shell opens all the files to be used in the multio process
immediately, not at the point they are about to be written.

Note also that redirections are always expanded in order. This happens
regardless of the setting of the `MULTIOS` option, but with the option
in effect there are additional consequences. For example, the meaning of
the expression `>&1` will change after a previous redirection:

<div class="example">

``` example
date >&1 >output
```

</div>

In the case above, the `>&1` refers to the standard output at the start
of the line; the result is similar to the `tee` command. However,
consider:

<div class="example">

``` example
date >output >&1
```

</div>

As redirections are evaluated in order, when the `>&1` is encountered
the standard output is set to the file `output` and another copy of the
output is therefore sent to that file. This is unlikely to be what is
intended.

If the `MULTIOS` option is set, the word after a redirection operator is
also subjected to filename generation (globbing). Thus

<div class="example">

``` example
: > *
```

</div>

will truncate all files in the current directory, assuming there’s at
least one. (Without the `MULTIOS` option, it would create an empty file
called ‘`*`’.) Similarly, you can do

<div class="example">

``` example
echo exit 0 >> *.sh
```

</div>

If the user tries to open a file descriptor for reading more than once,
the shell opens the file descriptor as a pipe to a process that copies
all the specified inputs to its output in the order specified, provided
the `MULTIOS` option is set. It should be noted that each file is opened
immediately, not at the point where it is about to be read: this
behaviour differs from `cat`, so if strictly standard behaviour is
needed, `cat` should be used instead.

Thus

<div class="example">

``` example
sort <foo <fubar
```

</div>

or even

<div class="example">

``` example
sort <f{oo,ubar}
```

</div>

is equivalent to ‘`cat foo fubar | sort`’.

Expansion of the redirection argument occurs at the point the
redirection is opened, at the point described above for the expansion of
the variable in `>&$myfd`.

Note that a pipe is an implicit redirection; thus

<div class="example">

``` example
cat bar | sort <foo
```

</div>

is equivalent to ‘`cat bar foo | sort`’ (note the order of the inputs).

If the `MULTIOS` option is *un*set, each redirection replaces the
previous redirection for that file descriptor. However, all files
redirected to are actually opened, so

<div class="example">

``` example
echo Hello > bar > baz
```

</div>

when `MULTIOS` is unset will truncate ‘`bar`’, and write ‘`Hello`’ into
‘`baz`’.

There is a problem when an output multio is attached to an external
program. A simple example shows this:

<div class="example">

``` example
cat file >file1 >file2
cat file1 file2
```

</div>

Here, it is possible that the second ‘`cat`’ will not display the full
contents of `file1` and `file2` (i.e. the original contents of `file`
repeated twice).

The reason for this is that the multios are spawned after the `cat`
process is forked from the parent shell, so the parent shell does not
wait for the multios to finish writing data. This means the command as
shown can exit before `file1` and `file2` are completely written. As a
workaround, it is possible to run the `cat` process as part of a job in
the current shell:

<div class="example">

``` example
{ cat file } >file >file2
```

</div>

Here, the `{``...``}` job will pause to wait for both files to be
written.

-----

<span id="Redirections-with-no-command"></span>

## 7.3 Redirections with no command

When a simple command consists of one or more redirection operators and
zero or more parameter assignments, but no command name, zsh can behave
in several ways.

<span id="index-NULLCMD_002c-use-of"></span>
<span id="index-CSH_005fNULLCMD_002c-use-of"></span>

If the parameter `NULLCMD` is not set or the option `CSH_NULLCMD` is
set, an error is caused. This is the csh behavior and `CSH_NULLCMD` is
set by default when emulating csh.

<span id="index-SH_005fNULLCMD_002c-use-of"></span>

If the option `SH_NULLCMD` is set, the builtin ‘`:`’ is inserted as a
command with the given redirections. This is the default when emulating
sh or ksh.

<span id="index-READNULLCMD_002c-use-of"></span>

Otherwise, if the parameter `NULLCMD` is set, its value will be used as
a command with the given redirections. If both `NULLCMD` and
`READNULLCMD` are set, then the value of the latter will be used instead
of that of the former when the redirection is an input. The default for
`NULLCMD` is ‘`cat`’ and for `READNULLCMD` is ‘`more`’. Thus

<div class="example">

``` example
< file
```

</div>

shows the contents of `file` on standard output, with paging if that is
a terminal. `NULLCMD` and `READNULLCMD` may refer to shell functions.

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
