<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [12 Conditional Expressions](#12-conditional-expressions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Conditional-Expressions"></span> <span
id="Conditional-Expressions-1"></span>

# 12 Conditional Expressions

<span id="index-conditional-expressions"></span> <span
id="index-expressions_002c-conditional"></span>

A *conditional expression* is used with the \[\[ compound command to
test attributes of files and to compare strings. Each expression can be
constructed from one or more of the following unary or binary
expressions:

-a `file`  
true if `file` exists.

-b `file`  
true if `file` exists and is a block special file.

-c `file`  
true if `file` exists and is a character special file.

-d `file`  
true if `file` exists and is a directory.

-e `file`  
true if `file` exists.

-f `file`  
true if `file` exists and is a regular file.

-g `file`  
true if `file` exists and has its setgid bit set.

-h `file`  
true if `file` exists and is a symbolic link.

-k `file`  
true if `file` exists and has its sticky bit set.

-n `string`  
true if length of `string` is non-zero.

-o `option`  
true if option named `option` is on. `option` may be a single character,
in which case it is a single letter option name. (See [Specifying
Options](Options.html#Specifying-Options).)

When no option named `option` exists, and the POSIX_BUILTINS option
hasn’t been set, return 3 with a warning. If that option is set, return
1 with no warning.

-p `file`  
true if `file` exists and is a FIFO special file (named pipe).

-r `file`  
true if `file` exists and is readable by current process.

-s `file`  
true if `file` exists and has size greater than zero.

-t `fd`  
true if file descriptor number `fd` is open and associated with a
terminal device. (note: `fd` is not optional)

-u `file`  
true if `file` exists and has its setuid bit set.

-v `varname`  
true if shell variable `varname` is set.

-w `file`  
-x `file`  
-z `string`  
true if length of `string` is zero.

-L `file`  
true if `file` exists and is a symbolic link.

-O `file`  
true if `file` exists and is owned by the effective user ID of this
process.

-G `file`  
true if `file` exists and its group matches the effective group ID of
this process.

-S `file`  
true if `file` exists and is a socket.

-N `file`  
true if `file` exists and its access time is not newer than its
modification time.

`file1` -nt `file2`  
true if `file1` exists and is newer than `file2`.

`file1` -ot `file2`  
true if `file1` exists and is older than `file2`.

`file1` -ef `file2`  
true if `file1` and `file2` exist and refer to the same file.

`string` = `pattern`  
`string` == `pattern`  
true if `string` matches `pattern`. The two forms are exactly
equivalent. The ‘=’ form is the traditional shell syntax (and hence the
only one generally used with the test and \[ builtins); the ‘==’ form
provides compatibility with other sorts of computer language.

`string` != `pattern`  
true if `string` does not match `pattern`.

`string` =\~ `regexp`  
true if `string` matches the regular expression `regexp`. If the option
RE_MATCH_PCRE is set `regexp` is tested as a PCRE regular expression
using the zsh/pcre module, else it is tested as a POSIX extended regular
expression using the zsh/regex module. Upon successful match, some
variables will be updated; no variables are changed if the matching
fails.

If the option BASH_REMATCH is not set the scalar parameter MATCH is set
to the substring that matched the pattern and the integer parameters
MBEGIN and MEND to the index of the start and end, respectively, of the
match in `string`, such that if `string` is contained in variable var
the expression ‘${var\[$MBEGIN,$MEND\]}’ is identical to ‘$MATCH’. The
setting of the option KSH_ARRAYS is respected. Likewise, the array match
is set to the substrings that matched parenthesised subexpressions and
the arrays mbegin and mend to the indices of the start and end
positions, respectively, of the substrings within `string`. The arrays
are not set if there were no parenthesised subexpressions. For example,
if the string ‘a short string’ is matched against the regular expression
‘s(...)t’, then (assuming the option KSH_ARRAYS is not set) MATCH,
MBEGIN and MEND are ‘short’, 3 and 7, respectively, while match, mbegin
and mend are single entry arrays containing the strings ‘hor’, ‘4’ and
‘6’, respectively.

If the option BASH_REMATCH is set the array BASH_REMATCH is set to the
substring that matched the pattern followed by the substrings that
matched parenthesised subexpressions within the pattern.

`string1` \< `string2`  
true if `string1` comes before `string2` based on ASCII value of their
characters.

`string1` > `string2`  
true if `string1` comes after `string2` based on ASCII value of their
characters.

`exp1` -eq `exp2`  
true if `exp1` is numerically equal to `exp2`. Note that for purely
numeric comparisons use of the ((`...`)) builtin described in
[Arithmetic
Evaluation](Arithmetic-Evaluation.html#Arithmetic-Evaluation) is more
convenient than conditional expressions.

`exp1` -ne `exp2`  
true if `exp1` is numerically not equal to `exp2`.

`exp1` -lt `exp2`  
true if `exp1` is numerically less than `exp2`.

`exp1` -gt `exp2`  
true if `exp1` is numerically greater than `exp2`.

`exp1` -le `exp2`  
true if `exp1` is numerically less than or equal to `exp2`.

`exp1` -ge `exp2`  
true if `exp1` is numerically greater than or equal to `exp2`.

( `exp` )  
true if `exp` is true.

! `exp`  
true if `exp` is false.

`exp1` && `exp2`  
true if `exp1` and `exp2` are both true.

`exp1` \|\| `exp2`  
true if either `exp1` or `exp2` is true.

For compatibility, if there is a single argument that is not
syntactically significant, typically a variable, the condition is
treated as a test for whether the expression expands as a string of
non-zero length. In other words, \[\[ $var \]\] is the same as \[\[ -n
$var \]\]. It is recommended that the second, explicit, form be used
where possible.

Normal shell expansion is performed on the `file`, `string` and
`pattern` arguments, but the result of each expansion is constrained to
be a single word, similar to the effect of double quotes.

Filename generation is not performed on any form of argument to
conditions. However, it can be forced in any case where normal shell
expansion is valid and when the option EXTENDED_GLOB is in effect by
using an explicit glob qualifier of the form (#q) at the end of the
string. A normal glob qualifier expression may appear between the ‘q’
and the closing parenthesis; if none appears the expression has no
effect beyond causing filename generation. The results of filename
generation are joined together to form a single word, as with the
results of other forms of expansion.

This special use of filename generation is only available with the \[\[
syntax. If the condition occurs within the \[ or test builtin commands
then globbing occurs instead as part of normal command line expansion
before the condition is evaluated. In this case it may generate multiple
words which are likely to confuse the syntax of the test command.

For example,

<div class="example">

```zsh
[[ -n file*(#qN) ]]
```

</div>

produces status zero if and only if there is at least one file in the
current directory beginning with the string ‘file’. The globbing
qualifier N ensures that the expression is empty if there is no matching
file.

Pattern metacharacters are active for the `pattern` arguments; the
patterns are the same as those used for filename generation, see
[Filename Generation](Expansion.html#Filename-Generation), but there is
no special behaviour of ‘/’ nor initial dots, and no glob qualifiers are
allowed.

In each of the above expressions, if `file` is of the form
‘/dev/fd/`n`’, where `n` is an integer, then the test applied to the
open file whose descriptor number is `n`, even if the underlying system
does not support the /dev/fd directory.

In the forms which do numeric comparison, the expressions `exp` undergo
arithmetic expansion as if they were enclosed in $((`...`)).

For example, the following:

<div class="example">

```zsh
[[ ( -f foo || -f bar ) && $report = y* ]] && print File exists.
```

</div>

tests if either file foo or file bar exists, and if so, if the value of
the parameter report begins with ‘y’; if the complete condition is true,
the message ‘File exists.’ is printed.

------------------------------------------------------------------------

This document was generated on *May 14, 2022* using [*texi2html
5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.9, released on May 14, 2022.
