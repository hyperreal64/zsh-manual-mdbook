<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [5 Files](#5-files)
  - [5.1 Startup/Shutdown Files](#51-startupshutdown-files)
  - [5.2 Files](#52-files)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Files"></span> <span id="Files-1"></span>

# 5 Files

-----

<span id="Startup_002fShutdown-Files"></span>

## 5.1 Startup/Shutdown Files

<span id="index-files_002c-startup"></span>
<span id="index-startup-files"></span>
<span id="index-files_002c-shutdown"></span>
<span id="index-shutdown-files"></span>
<span id="index-RCS_002c-use-of"></span>
<span id="index-GLOBAL_005fRCS_002c-use-of"></span>
<span id="index-NO_005fRCS_002c-use-of"></span>
<span id="index-NO_005fGLOBAL_005fRCS_002c-use-of"></span>
<span id="index-ZDOTDIR_002c-use-of"></span>
<span id="index-zshenv"></span>

Commands are first read from `/etc/zshenv`; this cannot be overridden.
Subsequent behaviour is modified by the `RCS` and `GLOBAL_RCS` options;
the former affects all startup files, while the second only affects
global startup files (those shown here with an path starting with a
`/`). If one of the options is unset at any point, any subsequent
startup file(s) of the corresponding type will not be read. It is also
possible for a file in `$ZDOTDIR` to re-enable `GLOBAL_RCS`. Both `RCS`
and `GLOBAL_RCS` are set by default.

Commands are then read from `$ZDOTDIR/.zshenv`.
<span id="index-LOGIN_002c-use-of"></span>
<span id="index-zprofile"></span> If the shell is a login shell,
commands are read from `/etc/zprofile` and then `$ZDOTDIR/.zprofile`.
<span id="index-zshrc"></span> Then, if the shell is interactive,
commands are read from `/etc/zshrc` and then `$ZDOTDIR/.zshrc`.
<span id="index-zlogin"></span> Finally, if the shell is a login shell,
`/etc/zlogin` and `$ZDOTDIR/.zlogin` are read.

<span id="index-zlogout"></span>

When a login shell exits, the files `$ZDOTDIR/.zlogout` and then
`/etc/zlogout` are read. This happens with either an explicit exit via
the `exit` or `logout` commands, or an implicit exit by reading
end-of-file from the terminal. However, if the shell terminates due to
`exec`’ing another process, the logout files are not read. These are
also affected by the `RCS` and `GLOBAL_RCS` options. Note also that the
`RCS` option affects the saving of history files, i.e. if `RCS` is unset
when the shell exits, no history file will be saved.

<span id="index-HOME_002c-use-of"></span>

If `ZDOTDIR` is unset, `HOME` is used instead. Files listed above as
being in `/etc` may be in another directory, depending on the
installation.

As `/etc/zshenv` is run for all instances of zsh, it is important that
it be kept as small as possible. In particular, it is a good idea to put
code that does not need to be run for every single shell behind a test
of the form ‘`if [[ -o rcs ]]; then ...`’ so that it will not be
executed when zsh is invoked with the ‘`-f`’ option.

-----

<span id="Files-2"></span>

## 5.2 Files

<span id="index-files-used"></span>

`$ZDOTDIR/.zshenv`

`$ZDOTDIR/.zprofile`

`$ZDOTDIR/.zshrc`

`$ZDOTDIR/.zlogin`

`$ZDOTDIR/.zlogout`

`${TMPPREFIX}*` (default is /tmp/zsh\*)

`/etc/zshenv`

`/etc/zprofile`

`/etc/zshrc`

`/etc/zlogin`

`/etc/zlogout` (installation-specific - `/etc` is the default)

  

Any of these files may be pre-compiled with the `zcompile` builtin
command ([Shell Builtin
Commands](Shell-Builtin-Commands.html#Shell-Builtin-Commands)). If a
compiled file exists (named for the original file plus the `.zwc`
extension) and it is newer than the original file, the compiled file
will be used instead.

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
