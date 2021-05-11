<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [4 Invocation](#4-invocation)
  - [4.1 Invocation](#41-invocation)
  - [4.2 Compatibility](#42-compatibility)
  - [4.3 Restricted Shell](#43-restricted-shell)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Invocation"></span> <span id="Invocation-1"></span>

# 4 Invocation

<span id="index-invocation"></span>

-----

<span id="Invocation-2"></span>

## 4.1 Invocation

<span id="index-shell-options"></span>
<span id="index-options_002c-shell"></span>
<span id="index-shell-flags"></span>
<span id="index-flags_002c-shell"></span>

The following flags are interpreted by the shell when invoked to
determine where the shell will read commands from:

  - `-c`  
    Take the first argument as a command to execute, rather than reading
    commands from a script or standard input. If any further arguments
    are given, the first one is assigned to `$0`, rather than being used
    as a positional parameter.

  - `-i`  
    Force shell to be interactive. It is still possible to specify a
    script to execute.

  - `-s`  
    Force shell to read commands from the standard input. If the `-s`
    flag is not present and an argument is given, the first argument is
    taken to be the pathname of a script to execute.

If there are any remaining arguments after option processing, and
neither of the options `-c` or `-s` was supplied, the first argument is
taken as the file name of a script containing shell commands to be
executed. If the option `PATH_SCRIPT` is set, and the file name does not
contain a directory path (i.e. there is no ‘`/`’ in the name), first the
current directory and then the command path given by the variable `PATH`
are searched for the script. If the option is not set or the file name
contains a ‘`/`’ it is used directly.

After the first one or two arguments have been appropriated as described
above, the remaining arguments are assigned to the positional
parameters.

For further options, which are common to invocation and the `set`
builtin, see [Options](Options.html#Options).

The long option ‘`-``-emulate`’ followed (in a separate word) by an
emulation mode may be passed to the shell. The emulation modes are those
described for the `emulate` builtin, see [Shell Builtin
Commands](Shell-Builtin-Commands.html#Shell-Builtin-Commands). The
‘`-``-emulate`’ option must precede any other options (which might
otherwise be overridden), but following options are honoured, so may be
used to modify the requested emulation mode. Note that certain extra
steps are taken to ensure a smooth emulation when this option is used
compared with the `emulate` command within the shell: for example,
variables that conflict with POSIX usage such as `path` are not defined
within the shell.

Options may be specified by name using the `-o` option. `-o` acts like a
single-letter option, but takes a following string as the option name.
For example,

<div class="example">

``` example
zsh -x -o shwordsplit scr
```

</div>

runs the script `scr`, setting the `XTRACE` option by the corresponding
letter ‘`-x`’ and the `SH_WORD_SPLIT` option by name. Options may be
turned *off* by name by using `+o` instead of `-o`. `-o` can be stacked
up with preceding single-letter options, so for example ‘`-xo
shwordsplit`’ or ‘`-xoshwordsplit`’ is equivalent to ‘`-x -o
shwordsplit`’.

<span id="index-long-option"></span>

Options may also be specified by name in GNU long option style,
‘`-``-``option-name`’. When this is done, ‘`-`’ characters in the
option name are permitted: they are translated into ‘`_`’, and thus
ignored. So, for example, ‘`zsh -``-sh-word-split`’ invokes zsh with the
`SH_WORD_SPLIT` option turned on. Like other option syntaxes, options
can be turned off by replacing the initial ‘`-`’ with a ‘`+`’; thus
‘`+-sh-word-split`’ is equivalent to ‘`-``-no-sh-word-split`’. Unlike
other option syntaxes, GNU-style long options cannot be stacked with any
other options, so for example ‘`-x-shwordsplit`’ is an error, rather
than being treated like ‘`-x -``-shwordsplit`’.

<span id="index-_002d_002dversion"></span>
<span id="index-_002d_002dhelp"></span>

The special GNU-style option ‘`-``-version`’ is handled; it sends to
standard output the shell’s version information, then exits
successfully. ‘`-``-help`’ is also handled; it sends to standard output
a list of options that can be used when invoking the shell, then exits
successfully.

Option processing may be finished, allowing following arguments that
start with ‘`-`’ or ‘`+`’ to be treated as normal arguments, in two
ways. Firstly, a lone ‘`-`’ (or ‘`+`’) as an argument by itself ends
option processing. Secondly, a special option ‘`-``-`’ (or ‘`+-`’),
which may be specified on its own (which is the standard POSIX usage) or
may be stacked with preceding options (so ‘`-x-`’ is equivalent to ‘`-x
-``-`’). Options are not permitted to be stacked after ‘`-``-`’ (so
‘`-x-f`’ is an error), but note the GNU-style option form discussed
above, where ‘`-``-shwordsplit`’ is permitted and does not end option
processing.

Except when the sh/ksh emulation single-letter options are in effect,
the option ‘`-b`’ (or ‘`+b`’) ends option processing. ‘`-b`’ is like
‘`-``-`’, except that further single-letter options can be stacked
after the ‘`-b`’ and will take effect as normal.

-----

<span id="Compatibility"></span> <span id="Compatibility-1"></span>

## 4.2 Compatibility

<span id="index-compatibility"></span>
<span id="index-sh-compatibility"></span>
<span id="index-ksh-compatibility"></span>

Zsh tries to emulate sh or ksh when it is invoked as `sh` or `ksh`
respectively; more precisely, it looks at the first letter of the name
by which it was invoked, excluding any initial ‘`r`’ (assumed to stand
for ‘restricted’), and if that is ‘`b`’, ‘`s`’ or ‘`k`’ it will emulate
sh or ksh. Furthermore, if invoked as `su` (which happens on certain
systems when the shell is executed by the `su` command), the shell will
try to find an alternative name from the `SHELL` environment variable
and perform emulation based on that.

In sh and ksh compatibility modes the following parameters are not
special and not initialized by the shell: `ARGC`, `argv`, `cdpath`,
`fignore`, `fpath`, `HISTCHARS`, `mailpath`, `MANPATH`, `manpath`,
`path`, `prompt`, `PROMPT`, `PROMPT2`, `PROMPT3`, `PROMPT4`, `psvar`,
`status`, `watch`.

<span id="index-ENV_002c-use-of"></span>

The usual zsh startup/shutdown scripts are not executed. Login shells
source `/etc/profile` followed by `$HOME/.profile`. If the `ENV`
environment variable is set on invocation, `$ENV` is sourced after the
profile scripts. The value of `ENV` is subjected to parameter expansion,
command substitution, and arithmetic expansion before being interpreted
as a pathname. Note that the `PRIVILEGED` option also affects the
execution of startup files.

The following options are set if the shell is invoked as `sh` or `ksh`:
`NO_BAD_PATTERN`, `NO_BANG_HIST`, `NO_BG_NICE`, `NO_EQUALS`,
`NO_FUNCTION_ARGZERO`, `GLOB_SUBST`, `NO_GLOBAL_EXPORT`, `NO_HUP`,
`INTERACTIVE_COMMENTS`, `KSH_ARRAYS`, `NO_MULTIOS`, `NO_NOMATCH`,
`NO_NOTIFY`, `POSIX_BUILTINS`, `NO_PROMPT_PERCENT`, `RM_STAR_SILENT`,
`SH_FILE_EXPANSION`, `SH_GLOB`, `SH_OPTION_LETTERS`, `SH_WORD_SPLIT`.
Additionally the `BSD_ECHO` and `IGNORE_BRACES` options are set if zsh
is invoked as `sh`. Also, the `KSH_OPTION_PRINT`, `LOCAL_OPTIONS`,
`PROMPT_BANG`, `PROMPT_SUBST` and `SINGLE_LINE_ZLE` options are set if
zsh is invoked as `ksh`.

-----

<span id="Restricted-Shell"></span>
<span id="Restricted-Shell-1"></span>

## 4.3 Restricted Shell

<span id="index-restricted-shell"></span>
<span id="index-RESTRICTED"></span>

When the basename of the command used to invoke zsh starts with the
letter ‘`r`’ or the ‘`-r`’ command line option is supplied at
invocation, the shell becomes restricted. Emulation mode is determined
after stripping the letter ‘`r`’ from the invocation name. The following
are disabled in restricted mode:

  - changing directories with the `cd` builtin
  - changing or unsetting the `EGID`, `EUID`, `GID`, `HISTFILE`,
    `HISTSIZE`, `IFS`, `LD_AOUT_LIBRARY_PATH`, `LD_AOUT_PRELOAD`,
    `LD_LIBRARY_PATH`, `LD_PRELOAD`, `MODULE_PATH`, `module_path`,
    `PATH`, `path`, `SHELL`, `UID` and `USERNAME` parameters
  - specifying command names containing `/`
  - specifying command pathnames using `hash`
  - redirecting output to files
  - using the `exec` builtin command to replace the shell with another
    command
  - using `jobs -Z` to overwrite the shell process’ argument and
    environment space
  - using the `ARGV0` parameter to override `argv[0]` for external
    commands
  - turning off restricted mode with `set +r` or `unsetopt RESTRICTED`

These restrictions are enforced after processing the startup files. The
startup files should set up `PATH` to point to a directory of commands
which can be safely invoked in the restricted environment. They may also
add further restrictions by disabling selected builtins.

Restricted mode can also be activated any time by setting the
`RESTRICTED` option. This immediately enables all the restrictions
described above even if the shell still has not processed all startup
files.

A shell *Restricted Mode* is an outdated way to restrict what users may
do: modern systems have better, safer and more reliable ways to confine
user actions, such as *chroot jails*, *containers* and *zones*.

A restricted shell is very difficult to implement safely. The feature
may be removed in a future version of zsh.

It is important to realise that the restrictions only apply to the
shell, not to the commands it runs (except for some shell builtins).
While a restricted shell can only run the restricted list of commands
accessible via the predefined ‘`PATH`’ variable, it does not prevent
those commands from running any other command.

As an example, if ‘`env`’ is among the list of *allowed* commands, then
it allows the user to run any command as ‘`env`’ is not a shell

So when implementing a restricted shell framework it is important to be
fully aware of what actions each of the *allowed* commands or features
(which may be regarded as *modules*) can perform.

Many commands can have their behaviour affected by environment
variables. Except for the few listed above, zsh does not restrict the
setting of environment variables.

If a ‘`perl`’, ‘`python`’, ‘`bash`’, or other general purpose
interpreted script it treated as a restricted command, the user can work
around the restriction by setting specially crafted ‘`PERL5LIB`’,
‘`PYTHONPATH`’, ‘`BASHENV`’ (etc.) environment variables. On GNU
systems, any command can be made to run arbitrary code when performing
character set conversion (including zsh itself) by setting a
‘`GCONV_PATH`’ environment variable. Those are only a few examples.

Bear in mind that, contrary to some other shells, ‘`readonly`’ is not a
security feature in zsh as it can be undone and so cannot be used to
mitigate the above.

A restricted shell only works if the allowed commands are few and
carefully written so as not to grant more access to users than intended.
It is also important to restrict what zsh module the user may load as
some of them, such as ‘`zsh/system`’, ‘`zsh/mapfile`’ and ‘`zsh/files`’,
allow bypassing most of the restrictions.

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
