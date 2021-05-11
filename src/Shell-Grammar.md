<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [6 Shell Grammar](#6-shell-grammar)
  - [6.1 Simple Commands & Pipelines](#61-simple-commands--pipelines)
  - [6.2 Precommand Modifiers](#62-precommand-modifiers)
  - [6.3 Complex Commands](#63-complex-commands)
  - [6.4 Alternate Forms For Complex Commands](#64-alternate-forms-for-complex-commands)
  - [6.5 Reserved Words](#65-reserved-words)
  - [6.6 Errors](#66-errors)
  - [6.7 Comments](#67-comments)
  - [6.8 Aliasing](#68-aliasing)
    - [6.8.1 Alias difficulties](#681-alias-difficulties)
  - [6.9 Quoting](#69-quoting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Shell-Grammar"></span> <span id="Shell-Grammar-1"></span>

# 6 Shell Grammar

<span id="index-shell-grammar"></span>
<span id="index-grammar_002c-shell"></span>

-----

<span id="Simple-Commands-_0026-Pipelines"></span>
<span id="Simple-Commands-_0026-Pipelines-1"></span>

## 6.1 Simple Commands & Pipelines

<span id="index-simple-commands"></span>
<span id="index-commands_002c-simple"></span>

A *simple command* is a sequence of optional parameter assignments
followed by blank-separated words, with optional redirections
interspersed. For a description of assignment, see the beginning of
[Parameters](Parameters.html#Parameters).

The first word is the command to be executed, and the remaining words,
if any, are arguments to the command. If a command name is given, the
parameter assignments modify the environment of the command when it is
executed. The value of a simple command is its exit status, or 128 plus
the signal number if terminated by a signal. For example,

<div class="example">

``` example
echo foo
```

</div>

is a simple command with arguments.

<span id="index-pipeline"></span>

A *pipeline* is either a simple command, or a sequence of two or more
simple commands where each command is separated from the next by ‘`|`’
or ‘`|&`’. Where commands are separated by ‘`|`’, the standard output of
the first command is connected to the standard input of the next. ‘`|&`’
is shorthand for ‘`2>&1 |`’, which connects both the standard output and
the standard error of the command to the standard input of the next. The
value of a pipeline is the value of the last command, unless the
pipeline is preceded by ‘`!`’ in which case the value is the logical
inverse of the value of the last command. For example,

<div class="example">

``` example
echo foo | sed 's/foo/bar/'
```

</div>

is a pipeline, where the output (‘`foo`’ plus a newline) of the first
command will be passed to the input of the second.

<span id="index-coproc"></span> <span id="index-coprocess"></span>

If a pipeline is preceded by ‘`coproc`’, it is executed as a coprocess;
a two-way pipe is established between it and the parent shell. The shell
can read from or write to the coprocess by means of the ‘`>&p`’ and
‘`<&p`’ redirection operators or with ‘`print -p`’ and ‘`read -p`’. A
pipeline cannot be preceded by both ‘`coproc`’ and ‘`!`’. If job control
is active, the coprocess can be treated in other than input and output
as an ordinary background job.

<span id="index-sublist"></span>

A *sublist* is either a single pipeline, or a sequence of two or more
pipelines separated by ‘`&&`’ or ‘`||`’. If two pipelines are separated
by ‘`&&`’, the second pipeline is executed only if the first succeeds
(returns a zero status). If two pipelines are separated by ‘`||`’, the
second is executed only if the first fails (returns a nonzero status).
Both operators have equal precedence and are left associative. The value
of the sublist is the value of the last pipeline executed. For example,

<div class="example">

``` example
dmesg | grep panic && print yes
```

</div>

is a sublist consisting of two pipelines, the second just a simple
command which will be executed if and only if the `grep` command returns
a zero status. If it does not, the value of the sublist is that return
status, else it is the status returned by the `print` (almost certainly
zero).

<span id="index-list"></span>

A *list* is a sequence of zero or more sublists, in which each sublist
is terminated by ‘`;`’, ‘`&`’, ‘`&|`’, ‘`&!`’, or a newline. This
terminator may optionally be omitted from the last sublist in the list
when the list appears as a complex command inside ‘`(`...`)`’ or
‘`{`...`}`’. When a sublist is terminated by ‘`;`’ or newline, the
shell waits for it to finish before executing the next sublist. If a
sublist is terminated by a ‘`&`’, ‘`&|`’, or ‘`&!`’, the shell executes
the last pipeline in it in the background, and does not wait for it to
finish (note the difference from other shells which execute the whole
sublist in the background). A backgrounded pipeline returns a status of
zero.

More generally, a list can be seen as a set of any shell commands
whatsoever, including the complex commands below; this is implied
wherever the word ‘list’ appears in later descriptions. For example, the
commands in a shell function form a special sort of list.

-----

<span id="Precommand-Modifiers"></span>
<span id="Precommand-Modifiers-1"></span>

## 6.2 Precommand Modifiers

<span id="index-precommand-modifiers"></span>
<span id="index-modifiers_002c-precommand"></span>

A simple command may be preceded by a *precommand modifier*, which will
alter how the command is interpreted. These modifiers are shell builtin
commands with the exception of `nocorrect` which is a reserved word.

<span id="index-_002d"></span>

`-`

The command is executed with a ‘`-`’ prepended to its `argv[0]` string.

<span id="index-builtin"></span>

`builtin`

The command word is taken to be the name of a builtin command, rather
than a shell function or external command.

<span id="index-command"></span>

`command` \[ `-pvV` \]

The command word is taken to be the name of an external command, rather
than a shell function or builtin. If the `POSIX_BUILTINS` option is set,
builtins will also be executed but certain special properties of them
are suppressed. The `-p` flag causes a default path to be searched
instead of that in `$path`. With the `-v` flag, `command` is similar to
`whence` and with `-V`, it is equivalent to `whence -v`.

<span id="index-exec"></span>

`exec` \[ `-cl` \] \[ `-a` `argv0` \]

The following command together with any arguments is run in place of the
current process, rather than as a sub-process. The shell does not fork
and is replaced. The shell does not invoke `TRAPEXIT`, nor does it
source `zlogout` files. The options are provided for compatibility with
other shells.

The `-c` option clears the environment.

The `-l` option is equivalent to the `-` precommand modifier, to treat
the replacement command as a login shell; the command is executed with a
`-` prepended to its `argv[0]` string. This flag has no effect if used
together with the `-a` option.

The `-a` option is used to specify explicitly the `argv[0]` string (the
name of the command as seen by the process itself) to be used by the
replacement command and is directly equivalent to setting a value for
the `ARGV0` environment variable.

<span id="index-nocorrect"></span>

`nocorrect`

Spelling correction is not done on any of the words. This must appear
before any other precommand modifier, as it is interpreted immediately,
before any parsing is done. It has no effect in non-interactive shells.

<span id="index-noglob"></span>

`noglob`

Filename generation (globbing) is not performed on any of the words.

-----

<span id="Complex-Commands"></span>
<span id="Complex-Commands-1"></span>

## 6.3 Complex Commands

<span id="index-complex-commands"></span>
<span id="index-commands_002c-complex"></span>

A *complex command* in zsh is one of the following:

<span id="index-if"></span> <span id="index-if-construct"></span>

`if` `list` `then` `list` \[ `elif` `list` `then` `list` \] ... \[
`else` `list` \] `fi`

The `if` `list` is executed, and if it returns a zero exit status, the
`then` `list` is executed. Otherwise, the `elif` `list` is executed and
if its status is zero, the `then` `list` is executed. If each `elif`
`list` returns nonzero status, the `else` `list` is executed.

<span id="index-for"></span> <span id="index-for-loops"></span>
<span id="index-loops_002c-for"></span>

`for` `name` ... \[ `in` `word` ... \] `term` `do` `list` `done`

Expand the list of `word`s, and set the parameter `name` to each of them
in turn, executing `list` each time. If the ‘`in` `word`’ is omitted,
use the positional parameters instead of the `word`s.

The `term` consists of one or more newline or `;` which terminate the
`word`s, and are optional when the ‘`in` `word`’ is omitted.

More than one parameter `name` can appear before the list of `word`s. If
`N` `name`s are given, then on each execution of the loop the next `N`
`word`s are assigned to the corresponding parameters. If there are more
`name`s than remaining `word`s, the remaining parameters are each set to
the empty string. Execution of the loop ends when there is no remaining
`word` to assign to the first `name`. It is only possible for `in` to
appear as the first `name` in the list, else it will be treated as
marking the end of the list.

`for ((` \[`expr1`\] `;` \[`expr2`\] `;` \[`expr3`\] `)) do` `list`
`done`

The arithmetic expression `expr1` is evaluated first (see [Arithmetic
Evaluation](Arithmetic-Evaluation.html#Arithmetic-Evaluation)). The
arithmetic expression `expr2` is repeatedly evaluated until it evaluates
to zero and when non-zero, `list` is executed and the arithmetic
expression `expr3` evaluated. If any expression is omitted, then it
behaves as if it evaluated to 1.

<span id="index-while"></span> <span id="index-while-loops"></span>
<span id="index-loops_002c-while"></span>

`while` `list` `do` `list` `done`

Execute the `do` `list` as long as the `while` `list` returns a zero
exit status.

<span id="index-until"></span> <span id="index-until-loops"></span>
<span id="index-loops_002c-until"></span>

`until` `list` `do` `list` `done`

Execute the `do` `list` as long as `until` `list` returns a nonzero exit
status.

<span id="index-repeat"></span> <span id="index-repeat-loops"></span>
<span id="index-loops_002c-repeat"></span>

`repeat` `word` `do` `list` `done`

`word` is expanded and treated as an arithmetic expression, which must
evaluate to a number `n`. `list` is then executed `n` times.

The `repeat` syntax is disabled by default when the shell starts in a
mode emulating another shell. It can be enabled with the command
‘`enable -r repeat`’

<span id="index-case"></span> <span id="index-case-selection"></span>
<span id="index-selection_002c-case"></span>

`case` `word` `in` \[ \[`(`\] `pattern` \[ `|` `pattern` \] ... `)`
`list` (`;;`|`;&`|`;|`) \] ... `esac`

Execute the `list` associated with the first `pattern` that matches
`word`, if any. The form of the patterns is the same as that used for
filename generation. See [Filename
Generation](Expansion.html#Filename-Generation).

Note further that, unless the `SH_GLOB` option is set, the whole pattern
with alternatives is treated by the shell as equivalent to a group of
patterns within parentheses, although white space may appear about the
parentheses and the vertical bar and will be stripped from the pattern
at those points. White space may appear elsewhere in the pattern; this
is not stripped. If the `SH_GLOB` option is set, so that an opening
parenthesis can be unambiguously treated as part of the case syntax, the
expression is parsed into separate words and these are treated as strict
alternatives (as in other shells).

If the `list` that is executed is terminated with `;&` rather than `;;`,
the following list is also executed. The rule for the terminator of the
following list `;;`, `;&` or `;|` is applied unless the `esac` is
reached.

If the `list` that is executed is terminated with `;|` the shell
continues to scan the `pattern`s looking for the next match, executing
the corresponding `list`, and applying the rule for the corresponding
terminator `;;`, `;&` or `;|`. Note that `word` is not re-expanded; all
applicable `pattern`s are tested with the same `word`.

<span id="index-select"></span> <span id="index-user-selection"></span>
<span id="index-selection_002c-user"></span>

`select` `name` \[ `in` `word` ... `term` \] `do` `list` `done`

where `term` is one or more newline or `;` to terminate the `word`s.
<span id="index-REPLY_002c-use-of"></span> Print the set of `word`s,
each preceded by a number. If the `in` `word` is omitted, use the
positional parameters. The `PROMPT3` prompt is printed and a line is
read from the line editor if the shell is interactive and that is
active, or else standard input. If this line consists of the number of
one of the listed `word`s, then the parameter `name` is set to the
`word` corresponding to this number. If this line is empty, the
selection list is printed again. Otherwise, the value of the parameter
`name` is set to null. The contents of the line read from standard input
is saved in the parameter `REPLY`. `list` is executed for each selection
until a break or end-of-file is encountered.

<span id="index-subshell"></span>

`(` `list` `)`

Execute `list` in a subshell. Traps set by the `trap` builtin are reset
to their default values while executing `list`.

`{` `list` `}`

Execute `list`.

<span id="index-always"></span> <span id="index-always-blocks"></span>
<span id="index-try-blocks"></span>

`{` `try-list` `} always {` `always-list` `}`

First execute `try-list`. Regardless of errors, or `break` or `continue`
commands encountered within `try-list`, execute `always-list`. Execution
then continues from the result of the execution of `try-list`; in other
words, any error, or `break` or `continue` command is treated in the
normal way, as if `always-list` were not present. The two chunks of code
are referred to as the ‘try block’ and the ‘always block’.

Optional newlines or semicolons may appear after the `always`; note,
however, that they may *not* appear between the preceding closing brace
and the `always`.

An ‘error’ in this context is a condition such as a syntax error which
causes the shell to abort execution of the current function, script, or
list. Syntax errors encountered while the shell is parsing the code do
not cause the `always-list` to be executed. For example, an erroneously
constructed `if` block in `try-list` would cause the shell to abort
during parsing, so that `always-list` would not be executed, while an
erroneous substitution such as `${*foo*}` would cause a run-time error,
after which `always-list` would be executed.

An error condition can be tested and reset with the special integer
variable `TRY_BLOCK_ERROR`. Outside an `always-list` the value is
irrelevant, but it is initialised to `-1`. Inside `always-list`, the
value is 1 if an error occurred in the `try-list`, else 0. If
`TRY_BLOCK_ERROR` is set to 0 during the `always-list`, the error
condition caused by the `try-list` is reset, and shell execution
continues normally after the end of `always-list`. Altering the value
during the `try-list` is not useful (unless this forms part of an
enclosing `always` block).

Regardless of `TRY_BLOCK_ERROR`, after the end of `always-list` the
normal shell status `$?` is the value returned from `try-list`. This
will be non-zero if there was an error, even if `TRY_BLOCK_ERROR` was
set to zero.

The following executes the given code, ignoring any errors it causes.
This is an alternative to the usual convention of protecting code by
executing it in a subshell.

<div class="example">

``` example
{
    # code which may cause an error
  } always {
    # This code is executed regardless of the error.
    (( TRY_BLOCK_ERROR = 0 ))
}
# The error condition has been reset.
```

</div>

When a `try` block occurs outside of any function, a `return` or a
`exit` encountered in `try-list` does *not* cause the execution of
`always-list`. Instead, the shell exits immediately after any `EXIT`
trap has been executed. Otherwise, a `return` command encountered in
`try-list` will cause the execution of `always-list`, just like `break`
and `continue`.

<span id="index-function"></span>

`function` `word` ... \[ `()` \] \[ `term` \] `{` `list` `}`

`word` ... `()` \[ `term` \] `{` `list` `}`

`word` ... `()` \[ `term` \] `command`

where `term` is one or more newline or `;`. Define a function which is
referenced by any one of `word`. Normally, only one `word` is provided;
multiple `word`s are usually only useful for setting traps. The body of
the function is the `list` between the `{` and `}`. See
[Functions](Functions.html#Functions).

If the option `SH_GLOB` is set for compatibility with other shells, then
whitespace may appear between the left and right parentheses when there
is a single `word`; otherwise, the parentheses will be treated as
forming a globbing pattern in that case.

In any of the forms above, a redirection may appear outside the function
body, for example

<div class="example">

``` example
func() { ... } 2>&1
```

</div>

The redirection is stored with the function and applied whenever the
function is executed. Any variables in the redirection are expanded at
the point the function is executed, but outside the function scope.

<span id="index-timing"></span> <span id="index-time"></span>

`time` \[ `pipeline` \]

The `pipeline` is executed, and timing statistics are reported on the
standard error in the form specified by the `TIMEFMT` parameter. If
`pipeline` is omitted, print statistics about the shell process and its
children.

<span id="index-conditional-expression"></span>
<span id="index-_005b_005b"></span>

`[[` `exp` `]]`

Evaluates the conditional expression `exp` and return a zero exit status
if it is true. See [Conditional
Expressions](Conditional-Expressions.html#Conditional-Expressions) for a
description of `exp`.

-----

<span id="Alternate-Forms-For-Complex-Commands"></span>
<span id="Alternate-Forms-For-Complex-Commands-1"></span>

## 6.4 Alternate Forms For Complex Commands

<span id="index-alternate-forms-for-complex-commands"></span>
<span id="index-commands_002c-alternate-forms-for-complex"></span>

Many of zsh’s complex commands have alternate forms. These are
non-standard and are likely not to be obvious even to seasoned shell
programmers; they should not be used anywhere that portability of shell
code is a concern.

The short versions below only work if `sublist` is of the form ‘`{`
`list` `}`’ or if the `SHORT_LOOPS` option is set. For the `if`, `while`
and `until` commands, in both these cases the test part of the loop must
also be suitably delimited, such as by ‘`[[` `...` `]]`’ or ‘`((` `...`
`))`’, else the end of the test will not be recognized. For the `for`,
`repeat`, `case` and `select` commands no such special form for the
arguments is necessary, but the other condition (the special form of
`sublist` or use of the `SHORT_LOOPS` option) still applies.

  - `if` `list` `{` `list` `}` \[ `elif` `list` `{` `list` `}` \] ... \[
    `else {` `list` `}` \]  
    An alternate form of `if`. The rules mean that
    
    <div class="example">
    
    ``` example
    if [[ -o ignorebraces ]] {
      print yes
    }
    ```
    
    </div>
    
    works, but
    
    <div class="example">
    
    ``` example
    if true {  # Does not work!
      print yes
    }
    ```
    
    </div>
    
    does *not*, since the test is not suitably delimited.

  - `if` `list` `sublist`  
    A short form of the alternate `if`. The same limitations on the form
    of `list` apply as for the previous form.

  - `for` `name` ... `(` `word` ... `)` `sublist`  
    A short form of `for`.

  - `for` `name` ... \[ `in` `word` ... \] `term` `sublist`  
    where `term` is at least one newline or `;`. Another short form of
    `for`.

  - `for ((` \[`expr1`\] `;` \[`expr2`\] `;` \[`expr3`\] `))`
    `sublist`  
    A short form of the arithmetic `for` command.
    
    <span id="index-foreach"></span>

  - `foreach` `name` ... `(` `word` ... `)` `list` `end`  
    Another form of `for`.

  - `while` `list` `{` `list` `}`  
    An alternative form of `while`. Note the limitations on the form of
    `list` mentioned above.

  - `until` `list` `{` `list` `}`  
    An alternative form of `until`. Note the limitations on the form of
    `list` mentioned above.

  - `repeat` `word` `sublist`  
    This is a short form of `repeat`.

  - `case` `word` `{` \[ \[`(`\] `pattern` \[ `|` `pattern` \] ... `)`
    `list` (`;;`|`;&`|`;|`) \] ... `}`  
    An alternative form of `case`.

  - `select` `name` \[ `in` `word` ... `term` \] `sublist`  
    where `term` is at least one newline or `;`. A short form of
    `select`.

  - `function` `word` ... \[ `()` \] \[ `term` \] `sublist`  
    This is a short form of `function`.

-----

<span id="Reserved-Words"></span> <span id="Reserved-Words-1"></span>

## 6.5 Reserved Words

<span id="index-reserved-words"></span>
<span id="index-disable_002c-use-of"></span>

The following words are recognized as reserved words when used as the
first word of a command unless quoted or disabled using `disable -r`:

`do done esac then elif else fi for case if while function repeat time
until select coproc nocorrect foreach end ! [[ { } declare export float
integer local readonly typeset`

Additionally, ‘`}`’ is recognized in any position if neither the
`IGNORE_BRACES` option nor the `IGNORE_CLOSE_BRACES` option is set.

-----

<span id="Errors"></span> <span id="Errors-1"></span>

## 6.6 Errors

<span id="index-errors_002c-handling-of"></span>

Certain errors are treated as fatal by the shell: in an interactive
shell, they cause control to return to the command line, and in a
non-interactive shell they cause the shell to be aborted. In older
versions of zsh, a non-interactive shell running a script would not
abort completely, but would resume execution at the next command to be
read from the script, skipping the remainder of any functions or shell
constructs such as loops or conditions; this somewhat illogical
behaviour can be recovered by setting the option `CONTINUE_ON_ERROR`.

Fatal errors found in non-interactive shells include:

  - Failure to parse shell options passed when invoking the shell
  - Failure to change options with the `set` builtin
  - Parse errors of all sorts, including failures to parse mathematical
    expressions
  - Failures to set or modify variable behaviour with `typeset`,
    `local`, `declare`, `export`, `integer`, `float`
  - Execution of incorrectly positioned loop control structures
    (`continue`, `break`)
  - Attempts to use regular expression with no regular expression module
    available
  - Disallowed operations when the `RESTRICTED` options is set
  - Failure to create a pipe needed for a pipeline
  - Failure to create a multio
  - Failure to autoload a module needed for a declared shell feature
  - Errors creating command or process substitutions
  - Syntax errors in glob qualifiers
  - File generation errors where not caught by the option `BAD_PATTERN`
  - All bad patterns used for matching within case statements
  - File generation failures where not caused by `NO_MATCH` or similar
    options
  - All file generation errors where the pattern was used to create a
    multio
  - Memory errors where detected by the shell
  - Invalid subscripts to shell variables
  - Attempts to assign read-only variables
  - Logical errors with variables such as assignment to the wrong type
  - Use of invalid variable names
  - Errors in variable substitution syntax
  - Failure to convert characters in `$’`...`’` expressions

If the `POSIX_BUILTINS` option is set, more errors associated with shell
builtin commands are treated as fatal, as specified by the POSIX
standard.

-----

<span id="Comments"></span> <span id="Comments-1"></span>

## 6.7 Comments

<span id="index-comments"></span>
<span id="index-INTERACTIVE_005fCOMMENTS_002c-use-of"></span>
<span id="index-histchars_002c-use-of"></span>

In non-interactive shells, or in interactive shells with the
`INTERACTIVE_COMMENTS` option set, a word beginning with the third
character of the `histchars` parameter (‘`#`’ by default) causes that
word and all the following characters up to a newline to be ignored.

-----

<span id="Aliasing"></span> <span id="Aliasing-1"></span>

## 6.8 Aliasing

<span id="index-aliasing"></span>

Every eligible *word* in the shell input is checked to see if there is
an alias defined for it. If so, it is replaced by the text of the alias
if it is in command position (if it could be the first word of a simple
command), or if the alias is global. If the replacement text ends with a
space, the next word in the shell input is always eligible for purposes
of alias expansion. <span id="index-alias_002c-use-of"></span>
<span id="index-aliases_002c-global"></span> An alias is defined using
the `alias` builtin; global aliases may be defined using the `-g` option
to that builtin.

A *word* is defined as:

  - Any plain string or glob pattern
  - Any quoted string, using any quoting method (note that the quotes
    must be part of the alias definition for this to be eligible)
  - Any parameter reference or command substitution
  - Any series of the foregoing, concatenated without whitespace or
    other tokens between them
  - Any reserved word (`case`, `do`, `else`, etc.)
  - With global aliasing, any command separator, any redirection
    operator, and ‘`(`’ or ‘`)`’ when not part of a glob pattern

Alias expansion is done on the shell input before any other expansion
except history expansion. Therefore, if an alias is defined for the word
`foo`, alias expansion may be avoided by quoting part of the word, e.g.
`\foo`. Any form of quoting works, although there is nothing to prevent
an alias being defined for the quoted form such as `\foo` as well.

When `POSIX_ALIASES` is set, only plain unquoted strings are eligible
for aliasing. The `alias` builtin does not reject ineligible aliases,
but they are not expanded.

For use with completion, which would remove an initial backslash
followed by a character that isn’t special, it may be more convenient to
quote the word by starting with a single quote, i.e. `’foo`; completion
will automatically add the trailing single quote.

-----

<span id="Alias-difficulties"></span>

### 6.8.1 Alias difficulties

Although aliases can be used in ways that bend normal shell syntax, not
every string of non-white-space characters can be used as an alias.

Any set of characters not listed as a word above is not a word, hence no
attempt is made to expand it as an alias, no matter how it is defined
(i.e. via the builtin or the special parameter `aliases` described in
[The zsh/parameter
Module](Zsh-Modules.html#The-zsh_002fparameter-Module)). However, as
noted in the case of `POSIX_ALIASES` above, the shell does not attempt
to deduce whether the string corresponds to a word at the time the alias
is created.

For example, an expression containing an `=` at the start of a command
line is an assignment and cannot be expanded as an alias; a lone `=` is
not an assignment but can only be set as an alias using the parameter,
as otherwise the `=` is taken part of the syntax of the builtin command.

It is not presently possible to alias the ‘`((`’ token that introduces
arithmetic expressions, because until a full statement has been parsed,
it cannot be distinguished from two consecutive ‘`(`’ tokens introducing
nested subshells. Also, if a separator such as `&&` is aliased, `\&&`
turns into the two tokens `\&` and `&`, each of which may have been
aliased separately. Similarly for `\<<`, `\>|`, etc.

There is a commonly encountered problem with aliases illustrated by the
following code:

<div class="example">

``` example
alias echobar='echo bar'; echobar
```

</div>

This prints a message that the command `echobar` could not be found.
This happens because aliases are expanded when the code is read in; the
entire line is read in one go, so that when `echobar` is executed it is
too late to expand the newly defined alias. This is often a problem in
shell scripts, functions, and code executed with ‘`source`’ or ‘`.`’.
Consequently, use of functions rather than aliases is recommended in
non-interactive code.

Note also the unhelpful interaction of aliases and function definitions:

<div class="example">

``` example
alias func='noglob func'
func() {
    echo Do something with $*
}
```

</div>

Because aliases are expanded in function definitions, this causes the
following command to be executed:

<div class="example">

``` example
noglob func() {
    echo Do something with $*
}
```

</div>

which defines `noglob` as well as `func` as functions with the body
given. To avoid this, either quote the name `func` or use the
alternative function definition form ‘`function func`’. Ensuring the
alias is defined after the function works but is problematic if the code
fragment might be re-executed.

-----

<span id="Quoting"></span> <span id="Quoting-1"></span>

## 6.9 Quoting

<span id="index-quoting"></span>

A character may be *quoted* (that is, made to stand for itself) by
preceding it with a ‘`\`’. ‘`\`’ followed by a newline is ignored.

A string enclosed between ‘`$’`’ and ‘`’`’ is processed the same way as
the string arguments of the `print` builtin, and the resulting string is
considered to be entirely quoted. A literal ‘`’`’ character can be
included in the string by using the ‘`\’`’ escape.

<span id="index-RC_005fQUOTES_002c-use-of"></span>

All characters enclosed between a pair of single quotes (`’’`) that is
not preceded by a ‘`$`’ are quoted. A single quote cannot appear within
single quotes unless the option `RC_QUOTES` is set, in which case a pair
of single quotes are turned into a single quote. For example,

<div class="example">

``` example
print ''''
```

</div>

outputs nothing apart from a newline if `RC_QUOTES` is not set, but one
single quote if it is set.

Inside double quotes (`""`), parameter and command substitution occur,
and ‘`\`’ quotes the characters ‘`\`’, ‘`‘`’, ‘`"`’, ‘`$`’, and the
first character of `$histchars` (default ‘`!`’).

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
