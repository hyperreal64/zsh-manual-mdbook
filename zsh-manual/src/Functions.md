<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [9 Functions](#9-functions)
  - [9.1 Autoloading Functions](#91-autoloading-functions)
  - [9.2 Anonymous Functions](#92-anonymous-functions)
  - [9.3 Special Functions](#93-special-functions)
    - [9.3.1 Hook Functions](#931-hook-functions)
    - [9.3.2 Trap Functions](#932-trap-functions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Functions"></span> <span id="Functions-4"></span>

# 9 Functions

<span id="index-functions"></span> <span
id="index-function_002c-use-of"></span>

Shell functions are defined with the function reserved word or the
special syntax ‘`funcname` ()’. Shell functions are read in and stored
internally. Alias names are resolved when the function is read.
Functions are executed like commands with the arguments passed as
positional parameters. (See [Command
Execution](Command-Execution.html#Command-Execution).)

Functions execute in the same process as the caller and share all files
and present working directory with the caller. A trap on EXIT set inside
a function is executed after the function completes in the environment
of the caller.

<span id="index-return_002c-use-of"></span>

The return builtin is used to return from function calls.

<span id="index-functions_002c-use-of"></span>

Function identifiers can be listed with the functions builtin. <span
id="index-unfunction_002c-use-of"></span> Functions can be undefined
with the unfunction builtin.

------------------------------------------------------------------------

<span id="Autoloading-Functions"></span>

## 9.1 Autoloading Functions

<span id="index-autoloading-functions"></span> <span
id="index-functions_002c-autoloading"></span> <span
id="index-autoload_002c-use-of"></span> <span
id="index-fpath_002c-use-of"></span>

A function can be marked as *undefined* using the autoload builtin (or
‘functions -u’ or ‘typeset -fu’). Such a function has no body. When the
function is first executed, the shell searches for its definition using
the elements of the fpath variable. Thus to define functions for
autoloading, a typical sequence is:

<div class="example">

```zsh
fpath=(~/myfuncs $fpath)
autoload myfunc1 myfunc2 ...
```

</div>

The usual alias expansion during reading will be suppressed if the
autoload builtin or its equivalent is given the option -U. This is
recommended for the use of functions supplied with the zsh distribution.
<span id="index-zcompile_002c-use-of"></span> Note that for functions
precompiled with the zcompile builtin command the flag -U must be
provided when the .zwc file is created, as the corresponding information
is compiled into the latter.

For each `element` in fpath, the shell looks for three possible files,
the newest of which is used to load the definition for the function:

`element`.zwc  
A file created with the zcompile builtin command, which is expected to
contain the definitions for all functions in the directory named
`element`. The file is treated in the same manner as a directory
containing files for functions and is searched for the definition of the
function. If the definition is not found, the search for a definition
proceeds with the other two possibilities described below.

If `element` already includes a .zwc extension (i.e. the extension was
explicitly given by the user), `element` is searched for the definition
of the function without comparing its age to that of other files; in
fact, there does not need to be any directory named `element` without
the suffix. Thus including an element such as ‘/usr/local/funcs.zwc’ in
fpath will speed up the search for functions, with the disadvantage that
functions included must be explicitly recompiled by hand before the
shell notices any changes.

`element`/`function`.zwc  
A file created with zcompile, which is expected to contain the
definition for `function`. It may include other function definitions as
well, but those are neither loaded nor executed; a file found in this
way is searched *only* for the definition of `function`.

`element`/`function`  
A file of zsh command text, taken to be the definition for `function`.

In summary, the order of searching is, first, in the *parents of*
directories in fpath for the newer of either a compiled directory or a
directory in fpath; second, if more than one of these contains a
definition for the function that is sought, the leftmost in the fpath is
chosen; and third, within a directory, the newer of either a compiled
function or an ordinary function definition is used.

<span id="index-KSH_005fAUTOLOAD_002c-use-of"></span>

If the KSH_AUTOLOAD option is set, or the file contains only a simple
definition of the function, the file’s contents will be executed. This
will normally define the function in question, but may also perform
initialization, which is executed in the context of the function
execution, and may therefore define local parameters. It is an error if
the function is not defined by loading the file.

Otherwise, the function body (with no surrounding ‘`funcname`()
{`...`}’) is taken to be the complete contents of the file. This
processing of the file results in the function being re-defined, the
function itself is not re-executed. To force the shell to perform
initialization and then call the function defined, the file should
contain initialization code (which will be executed then discarded) in
addition to a complete function definition (which will be retained for
subsequent calls to the function), and a call to the shell function,
including any arguments, at the end.

For example, suppose the autoload file func contains

<div class="example">

```zsh
func() { print This is func; }
print func is initialized
```

</div>

then ‘func; func’ with KSH_AUTOLOAD set will produce both messages on
the first call, but only the message ‘This is func’ on the second and
subsequent calls. Without KSH_AUTOLOAD set, it will produce the
initialization message on the first call, and the other message on the
second and subsequent calls.

It is also possible to create a function that is not marked as
autoloaded, but which loads its own definition by searching fpath, by
using ‘autoload -X’ within a shell function. For example, the following
are equivalent:

<div class="example">

```zsh
myfunc() {
  autoload -X
}
myfunc args...
```

</div>

and

<div class="example">

```zsh
unfunction myfunc   # if myfunc was defined
autoload myfunc
myfunc args...
```

</div>

In fact, the functions command outputs ‘builtin autoload -X’ as the body
of an autoloaded function. This is done so that

<div class="example">

```zsh
eval "$(functions)"
```

</div>

produces a reasonable result. A true autoloaded function can be
identified by the presence of the comment ‘# undefined’ in the body,
because all comments are discarded from defined functions.

To load the definition of an autoloaded function myfunc without
executing myfunc, use:

<div class="example">

```zsh
autoload +X myfunc
```

</div>

------------------------------------------------------------------------

<span id="Anonymous-Functions"></span>

## 9.2 Anonymous Functions

<span id="index-anonymous-functions"></span> <span
id="index-functions_002c-anonymous"></span>

If no name is given for a function, it is ‘anonymous’ and is handled
specially. Either form of function definition may be used: a ‘()’ with
no preceding name, or a ‘function’ with an immediately following open
brace. The function is executed immediately at the point of definition
and is not stored for future use. The function name is set to ‘(anon)’.

Arguments to the function may be specified as words following the
closing brace defining the function, hence if there are none no
arguments (other than $0) are set. This is a difference from the way
other functions are parsed: normal function definitions may be followed
by certain keywords such as ‘else’ or ‘fi’, which will be treated as
arguments to anonymous functions, so that a newline or semicolon is
needed to force keyword interpretation.

Note also that the argument list of any enclosing script or function is
hidden (as would be the case for any other function called at this
point).

Redirections may be applied to the anonymous function in the same manner
as to a current-shell structure enclosed in braces. The main use of
anonymous functions is to provide a scope for local variables. This is
particularly convenient in start-up files as these do not provide their
own local variable scope.

For example,

<div class="example">

```zsh
variable=outside
function {
  local variable=inside
  print "I am $variable with arguments $*"
} this and that
print "I am $variable"
```

</div>

outputs the following:

<div class="example">

```zsh
I am inside with arguments this and that
I am outside
```

</div>

Note that function definitions with arguments that expand to nothing,
for example ‘name=; function $name { `...` }’, are not treated as
anonymous functions. Instead, they are treated as normal function
definitions where the definition is silently discarded.

------------------------------------------------------------------------

<span id="Special-Functions"></span>

## 9.3 Special Functions

Certain functions, if defined, have special meaning to the shell.

------------------------------------------------------------------------

<span id="Hook-Functions"></span>

### 9.3.1 Hook Functions

<span id="index-functions_002c-hook"></span> <span
id="index-hook-functions"></span>

For the functions below, it is possible to define an array that has the
same name as the function with ‘\_functions’ appended. Any element in
such an array is taken as the name of a function to execute; it is
executed in the same context and with the same arguments and same
initial value of $? as the basic function. For example, if
$chpwd_functions is an array containing the values ‘mychpwd’,
‘chpwd_save_dirstack’, then the shell attempts to execute the functions
‘chpwd’, ‘mychpwd’ and ‘chpwd_save_dirstack’, in that order. Any
function that does not exist is silently ignored. A function found by
this mechanism is referred to elsewhere as a *hook function*. An error
in any function causes subsequent functions not to be run. Note further
that an error in a precmd hook causes an immediately following periodic
function not to run (though it may run at the next opportunity).

<span id="index-chpwd"></span> <span
id="index-chpwd_005ffunctions"></span>

chpwd

Executed whenever the current working directory is changed.

<span id="index-periodic"></span> <span
id="index-periodic_005ffunctions"></span>

periodic

<span id="index-PERIOD"></span>

If the parameter PERIOD is set, this function is executed every $PERIOD
seconds, just before a prompt. Note that if multiple functions are
defined using the array periodic_functions only one period is applied to
the complete set of functions, and the scheduled time is not reset if
the list of functions is altered. Hence the set of functions is always
called together.

<span id="index-precmd"></span> <span
id="index-precmd_005ffunctions"></span>

precmd

Executed before each prompt. Note that precommand functions are not
re-executed simply because the command line is redrawn, as happens, for
example, when a notification about an exiting job is displayed.

<span id="index-preexec"></span> <span
id="index-preexec_005ffunctions"></span>

preexec

Executed just after a command has been read and is about to be executed.
If the history mechanism is active (regardless of whether the line was
discarded from the history buffer), the string that the user typed is
passed as the first argument, otherwise it is an empty string. The
actual command that will be executed (including expanded aliases) is
passed in two different forms: the second argument is a single-line,
size-limited version of the command (with things like function bodies
elided); the third argument contains the full text that is being
executed.

<span id="index-zshaddhistory"></span> <span
id="index-zshaddhistory_005ffunctions"></span>

zshaddhistory

<span id="index-history_002c-hook-when-line-is-saved"></span>

Executed when a history line has been read interactively, but before it
is executed. The sole argument is the complete history line (so that any
terminating newline will still be present).

If any of the hook functions returns status 1 (or any non-zero value
other than 2, though this is not guaranteed for future versions of the
shell) the history line will not be saved, although it lingers in the
history until the next line is executed, allowing you to reuse or edit
it immediately.

If any of the hook functions returns status 2 the history line will be
saved on the internal history list, but not written to the history file.
In case of a conflict, the first non-zero status value is taken.

A hook function may call ‘fc -p `...`’ to switch the history context so
that the history is saved in a different file from that in the global
HISTFILE parameter. This is handled specially: the history context is
automatically restored after the processing of the history line is
finished.

The following example function works with one of the options
INC_APPEND_HISTORY or SHARE_HISTORY set, in order that the line is
written out immediately after the history entry is added. It first adds
the history line to the normal history with the newline stripped, which
is usually the correct behaviour. Then it switches the history context
so that the line will be written to a history file in the current
directory.

<div class="example">

```zsh
zshaddhistory() {
  print -sr -- ${1%%$'\n'}
  fc -p .zsh_local_history
}
```

</div>

<span id="index-zshexit"></span> <span
id="index-zshexit_005ffunctions"></span>

zshexit

Executed at the point where the main shell is about to exit normally.
This is not called by exiting subshells, nor when the exec precommand
modifier is used before an external command. Also, unlike TRAPEXIT, it
is not called when functions exit.

------------------------------------------------------------------------

<span id="Trap-Functions"></span>

### 9.3.2 Trap Functions

The functions below are treated specially but do not have corresponding
hook arrays.

TRAP`NAL`  
<span id="index-signals_002c-trapping"></span> <span
id="index-trapping-signals"></span>

If defined and non-null, this function will be executed whenever the
shell catches a signal SIG`NAL`, where `NAL` is a signal name as
specified for the kill builtin. The signal number will be passed as the
first parameter to the function.

If a function of this form is defined and null, the shell and processes
spawned by it will ignore SIG`NAL`.

The return status from the function is handled specially. If it is zero,
the signal is assumed to have been handled, and execution continues
normally. Otherwise, the shell will behave as interrupted except that
the return status of the trap is retained.

Programs terminated by uncaught signals typically return the status 128
plus the signal number. Hence the following causes the handler for
SIGINT to print a message, then mimic the usual effect of the signal.

<div class="example">

```zsh
TRAPINT() {
  print "Caught SIGINT, aborting."
  return $(( 128 + $1 ))
}
```

</div>

The functions TRAPZERR, TRAPDEBUG and TRAPEXIT are never executed inside
other traps.

<span id="index-TRAPDEBUG"></span>

TRAPDEBUG  
If the option DEBUG_BEFORE_CMD is set (as it is by default), executed
before each command; otherwise executed after each command. See the
description of the trap builtin in [Shell Builtin
Commands](Shell-Builtin-Commands.html#Shell-Builtin-Commands) for
details of additional features provided in debug traps.

<span id="index-TRAPEXIT"></span>

TRAPEXIT  
Executed when the shell exits, or when the current function exits if
defined inside a function. The value of $? at the start of execution is
the exit status of the shell or the return status of the function
exiting.

<span id="index-TRAPZERR"></span> <span id="index-TRAPERR"></span>

TRAPZERR  
Executed whenever a command has a non-zero exit status. However, the
function is not executed if the command occurred in a sublist followed
by ‘&&’ or ‘\|\|’; only the final command in a sublist of this type
causes the trap to be executed. The function TRAPERR acts the same as
TRAPZERR on systems where there is no SIGERR (this is the usual case).

<span id="index-trap_002c-use-of"></span>

The functions beginning ‘TRAP’ may alternatively be defined with the
trap builtin: this may be preferable for some uses. Setting a trap with
one form removes any trap of the other form for the same signal;
removing a trap in either form removes all traps for the same signal.
The forms

<div class="example">

```zsh
TRAPNAL() { 
 # code
}
```

</div>

(’function traps’) and

<div class="example">

```zsh
trap '
 # code
' NAL
```

</div>

(’list traps’) are equivalent in most ways, the exceptions being the
following:

-   Function traps have all the properties of normal functions,
    appearing in the list of functions and being called with their own
    function context rather than the context where the trap was
    triggered.
-   The return status from function traps is special, whereas a return
    from a list trap causes the surrounding context to return with the
    given status.
-   Function traps are not reset within subshells, in accordance with
    zsh behaviour; list traps are reset, in accordance with POSIX
    behaviour.

------------------------------------------------------------------------

This document was generated on *May 14, 2022* using [*texi2html
5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.9, released on May 14, 2022.
