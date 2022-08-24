<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [13 Prompt Expansion](#13-prompt-expansion)
  - [13.1 Expansion of Prompt Sequences](#131-expansion-of-prompt-sequences)
  - [13.2 Simple Prompt Escapes](#132-simple-prompt-escapes)
    - [13.2.1 Special characters](#1321-special-characters)
    - [13.2.2 Login information](#1322-login-information)
    - [13.2.3 Shell state](#1323-shell-state)
    - [13.2.4 Date and time](#1324-date-and-time)
    - [13.2.5 Visual effects](#1325-visual-effects)
  - [13.3 Conditional Substrings in Prompts](#133-conditional-substrings-in-prompts)
- [](#)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Prompt-Expansion"></span> <span
id="Prompt-Expansion-1"></span>

# 13 Prompt Expansion

------------------------------------------------------------------------

<span id="Expansion-of-Prompt-Sequences"></span>

## 13.1 Expansion of Prompt Sequences

<span id="index-prompt-expansion"></span> <span
id="index-expansion_002c-prompt"></span>

Prompt sequences undergo a special form of expansion. This type of
expansion is also available using the -P option to the print builtin.

<span id="index-PROMPT_005fSUBST_002c-use-of"></span>

If the PROMPT_SUBST option is set, the prompt string is first subjected
to *parameter expansion*, *command substitution* and *arithmetic
expansion*. See [Expansion](Expansion.html#Expansion).

Certain escape sequences may be recognised in the prompt string.

<span id="index-PROMPT_005fBANG_002c-use-of"></span>

If the PROMPT_BANG option is set, a ‘!’ in the prompt is replaced by the
current history event number. A literal ‘!’ may then be represented as
‘!!’.

<span id="index-PROMPT_005fPERCENT_002c-use-of"></span>

If the PROMPT_PERCENT option is set, certain escape sequences that start
with ‘%’ are expanded. Many escapes are followed by a single character,
although some of these take an optional integer argument that should
appear between the ‘%’ and the next character of the sequence. More
complicated escape sequences are available to provide conditional
expansion.

------------------------------------------------------------------------

<span id="Simple-Prompt-Escapes"></span>

## 13.2 Simple Prompt Escapes

------------------------------------------------------------------------

<span id="Special-characters"></span>

### 13.2.1 Special characters

%%  
A ‘%’.

%)  
A ‘)’.

------------------------------------------------------------------------

<span id="Login-information"></span>

### 13.2.2 Login information

%l  
The line (tty) the user is logged in on, without ‘/dev/’ prefix. If the
name starts with ‘/dev/tty’, that prefix is stripped.

%M  
The full machine hostname.

%m  
The hostname up to the first ‘.’. An integer may follow the ‘%’ to
specify how many components of the hostname are desired. With a negative
integer, trailing components of the hostname are shown.

%n  
$USERNAME.

%y  
The line (tty) the user is logged in on, without ‘/dev/’ prefix. This
does not treat ‘/dev/tty’ names specially.

------------------------------------------------------------------------

<span id="Shell-state"></span>

### 13.2.3 Shell state

%#  
A ‘#’ if the shell is running with privileges, a ‘%’ if not. Equivalent
to ‘%(!.#.%%)’. The definition of ‘privileged’, for these purposes, is
that either the effective user ID is zero, or, if POSIX.1e capabilities
are supported, that capability vectors.

%?  
The return status of the last command executed just before the prompt.

%\_  
The status of the parser, i.e. the shell constructs (like ‘if’ and
‘for’) that have been started on the command line. If given an integer
number that many strings will be printed; zero or negative or no integer
means print as many as there are. This is most useful in prompts PS2 for
continuation lines and PS4 for debugging with the XTRACE option; in the
latter case it will also work non-interactively.

%^  
The status of the parser in reverse. This is the same as ‘%\_’ other
than the order of strings. It is often used in RPS2.

%d  
%/  
Current working directory. If an integer follows the ‘%’, it specifies a
number of trailing components of the current working directory to show;
zero means the whole path. A negative integer specifies leading
components, i.e. %-1d specifies the first component.

%\~  
As %d and %/, but if the current working directory starts with $HOME,
that part is replaced by a ‘\~’. Furthermore, if it has a named
directory as its prefix, that part is replaced by a ‘\~’ followed by the
name of the directory, but only if the result is shorter than the full
path; [Filename Expansion](Expansion.html#Filename-Expansion).

%e  
Evaluation depth of the current sourced file, shell function, or eval.
This is incremented or decremented every time the value of %N is set or
reverted to a previous value, respectively. This is most useful for
debugging as part of $PS4.

%h  
%!  
Current history event number.

%i  
The line number currently being executed in the script, sourced file, or
shell function given by %N. This is most useful for debugging as part of
$PS4.

%I  
The line number currently being executed in the file %x. This is similar
to %i, but the line number is always a line number in the file where the
code was defined, even if the code is a shell function.

%j  
The number of jobs.

%L  
The current value of $SHLVL.

%N  
The name of the script, sourced file, or shell function that zsh is
currently executing, whichever was started most recently. If there is
none, this is equivalent to the parameter $0. An integer may follow the
‘%’ to specify a number of trailing path components to show; zero means
the full path. A negative integer specifies leading components.

%x  
The name of the file containing the source code currently being
executed. This behaves as %N except that function and eval command names
are not shown, instead the file where they were defined.

%c  
%.  
%C  
Trailing component of the current working directory. An integer may
follow the ‘%’ to get more than one component. Unless ‘%C’ is used,
tilde contraction is performed first. These are deprecated as %c and %C
are equivalent to %1\~ and %1/, respectively, while explicit positive
integers have the same effect as for the latter two sequences.

------------------------------------------------------------------------

<span id="Date-and-time"></span>

### 13.2.4 Date and time

%D  
The date in `yy`-`mm`-`dd` format.

%T  
Current time of day, in 24-hour format.

%t  
%@  
Current time of day, in 12-hour, am/pm format.

%\*  
Current time of day in 24-hour format, with seconds.

%w  
The date in `day`-`dd` format.

%W  
The date in `mm`/`dd`/`yy` format.

%D{`string`}  
`string` is formatted using the strftime function. See strftime(3) for
more details. Various zsh extensions provide numbers with no leading
zero or space if the number is a single digit:

%f  
a day of the month

%K  
the hour of the day on the 24-hour clock

%L  
the hour of the day on the 12-hour clock

In addition, if the system supports the POSIX gettimeofday system call,
%. provides decimal fractions of a second since the epoch with leading
zeroes. By default three decimal places are provided, but a number of
digits up to 9 may be given following the %; hence %6. outputs
microseconds, and %9. outputs nanoseconds. (The latter requires a
nanosecond-precision clock_gettime; systems lacking this will return a
value multiplied by the appropriate power of 10.) A typical example of
this is the format ‘%D{%H:%M:%S.%.}’.

The GNU extension %N is handled as a synonym for %9..

Additionally, the GNU extension that a ‘-’ between the % and the format
character causes a leading zero or space to be stripped is handled
directly by the shell for the format characters d, f, H, k, l, m, M, S
and y; any other format characters are provided to the system’s
strftime(3) with any leading ‘-’ present, so the handling is system
dependent. Further GNU (or other) extensions are also passed to
strftime(3) and may work if the system supports them.

------------------------------------------------------------------------

<span id="Visual-effects"></span>

### 13.2.5 Visual effects

%B (%b)  
Start (stop) boldface mode.

%E  
Clear to end of line.

%U (%u)  
Start (stop) underline mode.

%S (%s)  
Start (stop) standout mode.

%F (%f)  
Start (stop) using a different foreground colour, if supported by the
terminal. The colour may be specified two ways: either as a numeric
argument, as normal, or by a sequence in braces following the %F, for
example %F{red}. In the latter case the values allowed are as described
for the fg zle_highlight attribute; [Character
Highlighting](Zsh-Line-Editor.html#Character-Highlighting). This means
that numeric colours are allowed in the second format also.

%K (%k)  
Start (stop) using a different bacKground colour. The syntax is
identical to that for %F and %f.

%{...%}  
Include a string as a literal escape sequence. The string within the
braces should not change the cursor position. Brace pairs can nest.

A positive numeric argument between the % and the { is treated as
described for %G below.

%G  
Within a %{...%} sequence, include a ‘glitch’: that is, assume that a
single character width will be output. This is useful when outputting
characters that otherwise cannot be correctly handled by the shell, such
as the alternate character set on some terminals. The characters in
question can be included within a %{...%} sequence together with the
appropriate number of %G sequences to indicate the correct width. An
integer between the ‘%’ and ‘G’ indicates a character width other than
one. Hence %{`seq`%2G%} outputs `seq` and assumes it takes up the width
of two standard characters.

Multiple uses of %G accumulate in the obvious fashion; the position of
the %G is unimportant. Negative integers are not handled.

Note that when prompt truncation is in use it is advisable to divide up
output into single characters within each %{...%} group so that the
correct truncation point can be found.

------------------------------------------------------------------------

<span id="Conditional-Substrings-in-Prompts"></span>

## 13.3 Conditional Substrings in Prompts

%v  
<span id="index-psvar_002c-use-of"></span>

The value of the first element of the psvar array parameter. Following
the ‘%’ with an integer gives that element of the array. Negative
integers count from the end of the array.

%(`x`.`true-text`.`false-text`)  
Specifies a ternary expression. The character following the `x` is
arbitrary; the same character is used to separate the text for the
‘true’ result from that for the ‘false’ result. This separator may not
appear in the `true-text`, except as part of a %-escape sequence. A ‘)’
may appear in the `false-text` as ‘%)’. `true-text` and `false-text` may
both contain arbitrarily-nested escape sequences, including further
ternary expressions.

The left parenthesis may be preceded or followed by a positive integer
`n`, which defaults to zero. A negative integer will be multiplied by
-1, except as noted below for ‘l’. The test character `x` may be any of
the following:

!  
True if the shell is running with privileges.

#  
True if the effective uid of the current process is `n`.

?  
True if the exit status of the last command was `n`.

\_  
True if at least `n` shell constructs were started.

C  
/  
True if the current absolute path has at least `n` elements relative to
the root directory, hence / is counted as 0 elements.

c  
.  
\~  
True if the current path, with prefix replacement, has at least `n`
elements relative to the root directory, hence / is counted as 0
elements.

D  
True if the month is equal to `n` (January = 0).

d  
True if the day of the month is equal to `n`.

e  
True if the evaluation depth is at least `n`.

g  
True if the effective gid of the current process is `n`.

j  
True if the number of jobs is at least `n`.

L  
True if the SHLVL parameter is at least `n`.

l  
True if at least `n` characters have already been printed on the current
line. When `n` is negative, true if at least abs(`n`) characters remain
before the opposite margin (thus the left margin for RPROMPT).

S  
True if the SECONDS parameter is at least `n`.

T  
True if the time in hours is equal to `n`.

t  
True if the time in minutes is equal to `n`.

v  
True if the array psvar has at least `n` elements.

V  
True if element `n` of the array psvar is set and non-empty.

w  
True if the day of the week is equal to `n` (Sunday = 0).

%\<`string`\<  
%>`string`\>  
%\[`xstring`\]  
Specifies truncation behaviour for the remainder of the prompt string.
The third, deprecated, form is equivalent to ‘%`xstringx`’, i.e. `x` may
be ‘\<’ or ‘>’. The `string` will be displayed in place of the truncated
portion of any string; note this does not undergo prompt expansion.

The numeric argument, which in the third form may appear immediately
after the ‘\[’, specifies the maximum permitted length of the various
strings that can be displayed in the prompt. In the first two forms,
this numeric argument may be negative, in which case the truncation
length is determined by subtracting the absolute value of the numeric
argument from the number of character positions remaining on the current
prompt line. If this results in a zero or negative length, a length of 1
is used. In other words, a negative argument arranges that after
truncation at least `n` characters remain before the right margin (left
margin for RPROMPT).

The forms with ‘\<’ truncate at the left of the string, and the forms
with ‘>’ truncate at the right of the string. For example, if the
current directory is ‘/home/pike’, the prompt ‘%8\<..\<%/’ will expand
to ‘..e/pike’. In this string, the terminating character (‘\<’, ‘>’ or
‘\]’), or in fact any character, may be quoted by a preceding ‘\\’; note
when using print -P, however, that this must be doubled as the string is
also subject to standard print processing, in addition to any
backslashes removed by a double quoted string: the worst case is
therefore ‘print -P "%\<\\\\\\\\\<\<..."’.

If the `string` is longer than the specified truncation length, it will
appear in full, completely replacing the truncated string.

The part of the prompt string to be truncated runs to the end of the
string, or to the end of the next enclosing group of the ‘%(’ construct,
or to the next truncation encountered at the same grouping level (i.e.
truncations inside a ‘%(’ are separate), which ever comes first. In
particular, a truncation with argument zero (e.g., ‘%\<\<’) marks the
end of the range of the string to be truncated while turning off
truncation from there on. For example, the prompt ‘%10\<...\<%\~%\<\<%#
’ will print a truncated representation of the current directory,
followed by a ‘%’ or ‘#’, followed by a space. Without the ‘%\<\<’,
those two characters would be included in the string to be truncated.
Note that ‘%-0\<\<’ is not equivalent to ‘%\<\<’ but specifies that the
prompt is truncated at the right margin.

Truncation applies only within each individual line of the prompt, as
delimited by embedded newlines (if any). If the total length of any line
of the prompt after truncation is greater than the terminal width, or if
the part to be truncated contains embedded newlines, truncation behavior
is undefined and may change in a future version of the shell. Use
‘%-`n`(l.`true-text`.`false-text`)’ to remove parts of the prompt when
the available space is less than `n`.

------------------------------------------------------------------------

This document was generated on *May 14, 2022* using [*texi2html
5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.9, released on May 14, 2022.
