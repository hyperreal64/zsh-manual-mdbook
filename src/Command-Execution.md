<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [8 Command Execution](#8-command-execution)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Command-Execution"></span>
<span id="Command-Execution-1"></span>

# 8 Command Execution

<span id="index-command-execution"></span>
<span id="index-execution_002c-of-commands"></span>
<span id="index-command-not-found_002c-handling-of"></span>
<span id="index-command_005fnot_005ffound_005fhandler"></span>

If a command name contains no slashes, the shell attempts to locate it.
If there exists a shell function by that name, the function is invoked
as described in [Functions](Functions.html#Functions). If there exists a
shell builtin by that name, the builtin is invoked.

<span id="index-path_002c-use-of"></span>

Otherwise, the shell searches each element of `$path` for a search is
unsuccessful, the shell prints an error message and returns a nonzero
exit status.

and the file is not a directory, it is assumed to be a shell script.
`/bin/sh` is spawned to execute it. If the program is a file beginning
with ‘`#!`’, the remainder of the first line specifies an interpreter
for the program. The shell will execute the specified interpreter on
operating systems that do

If no external command is found but a function
`command_not_found_handler` exists the shell executes this function with
all command line arguments. The return status of the function becomes
the status of the command. If the function wishes to mimic the behaviour
of the shell when the command is not found, it should print the message
‘`command not found:` `cmd`’ to standard error and return status 127.
Note that the handler is executed in a subshell forked to execute an
external command, hence changes to directories, shell parameters, etc.
have no effect on the main shell.

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
