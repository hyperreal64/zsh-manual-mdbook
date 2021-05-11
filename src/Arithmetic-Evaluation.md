<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [11 Arithmetic Evaluation](#11-arithmetic-evaluation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Arithmetic-Evaluation"></span>
<span id="Arithmetic-Evaluation-1"></span>

# 11 Arithmetic Evaluation

<span id="index-arithmetic-evaluation"></span>
<span id="index-evaluation_002c-arithmetic"></span>
<span id="index-let_002c-use-of"></span>

The shell can perform integer and floating point arithmetic, either
using the builtin `let`, or via a substitution of the form
`$((``...``))`. For integers, the shell is usually compiled to use
8-byte precision where this is available, otherwise precision is 4
bytes. This can be tested, for example, by giving the command ‘`print -
$(( 12345678901 ))`’; if the number appears unchanged, the precision is
at least 8 bytes. Floating point arithmetic always uses the ‘double’
type with whatever corresponding precision is provided by the compiler
and the library.

The `let` builtin command takes arithmetic expressions as arguments;
each is evaluated separately. Since many of the arithmetic operators, as
well as spaces, require quoting, an alternative form is provided: for
any command which begins with a ‘`((`’, all the characters until a
matching ‘`))`’ are treated as a quoted expression and arithmetic
expansion performed as for an argument of `let`. More precisely,
‘`((``...``))`’ is equivalent to ‘`let "``...``"`’. The return status
is 0 if the arithmetic value of the expression is non-zero, 1 if it is
zero, and 2 if an error occurred.

For example, the following statement

<div class="example">

``` example
(( val = 2 + 1 ))
```

</div>

is equivalent to

<div class="example">

``` example
let "val = 2 + 1"
```

</div>

both assigning the value 3 to the shell variable `val` and returning a
zero status.

<span id="index-arithmetic-base"></span>
<span id="index-bases_002c-in-arithmetic"></span>

Integers can be in bases other than 10. A leading ‘`0x`’ or ‘`0X`’
denotes hexadecimal and a leading ‘`0b`’ or ‘`0B`’ binary. Integers may
also be of the form ‘`base``#``n`’, where `base` is a decimal number
between two and thirty-six representing the arithmetic base and `n` is a
number in that base (for example, ‘`16#ff`’ is 255 in hexadecimal). The
`base``#` may also be omitted, in which case base 10 is used. For
backwards compatibility the form ‘`[``base``]``n`’ is also accepted.

An integer expression or a base given in the form ‘`base``#``n`’ may
contain underscores (‘`_`’) after the leading digit for visual guidance;
these are ignored in computation. Examples are `1_000_000` or
`0xffff_ffff` which are equivalent to `1000000` and `0xffffffff`
respectively.

It is also possible to specify a base to be used for output in the form
‘`[#``base``]`’, for example ‘`[#16]`’. This is used when outputting
arithmetical substitutions or when assigning to scalar parameters, but
an explicitly defined integer or floating point parameter will not be
affected. If an integer variable is implicitly defined by an arithmetic
expression, any base specified in this way will be set as the variable’s
output arithmetic base as if the option ‘`-i` `base`’ to the `typeset`
builtin had been used. The expression has no precedence and if it occurs
more than once in a mathematical expression, the last encountered is
used. For clarity it is recommended that it appear at the beginning of
an expression. As an example:

<div class="example">

``` example
typeset -i 16 y
print $(( [#8] x = 32, y = 32 ))
print $x $y
```

</div>

outputs first ‘`8#40`’, the rightmost value in the given output base,
and then ‘`8#40 16#20`’, because `y` has been explicitly declared to
have output base 16, while `x` (assuming it does not already exist) is
implicitly typed by the arithmetic evaluation, where it acquires the
output base 8.

The `base` may be replaced or followed by an underscore, which may
itself be followed by a positive integer (if it is missing the value 3
is used). This indicates that underscores should be inserted into the
output string, grouping the number for visual clarity. The following
integer specifies the number of digits to group together. For example:

<div class="example">

``` example
setopt cbases
print $(( [#16_4] 65536 ** 2 ))
```

</div>

outputs ‘`0x1_0000_0000`’.

The feature can be used with floating point numbers, in which case the
base must be omitted; grouping is away from the decimal point. For
example,

<div class="example">

``` example
zmodload zsh/mathfunc
print $(( [#_] sqrt(1e7) ))
```

</div>

outputs ‘`3_162.277_660_168_379_5`’ (the number of decimal places shown
may vary).

<span id="index-C_005fBASES_002c-use-of"></span>
<span id="index-OCTAL_005fZEROES_002c-use-of"></span>

If the `C_BASES` option is set, hexadecimal numbers are output in the
standard C format, for example ‘`0xFF`’ instead of the usual ‘`16#FF`’.
If the option `OCTAL_ZEROES` is also set (it is not by default), octal
numbers will be treated similarly and hence appear as ‘`077`’ instead of
‘`8#77`’. This option has no effect on the output of bases other than
hexadecimal and octal, and these formats are always understood on input.

When an output base is specified using the ‘`[#``base``]`’ syntax, an
appropriate base prefix will be output if necessary, so that the value
output is valid syntax for input. If the `#` is doubled, for example
‘`[##16]`’, then no base prefix is output.

Floating point constants are recognized by the presence of a decimal
point or an exponent. The decimal point may be the first character of
the constant, but the exponent character `e` or `E` may not, as it will
be taken for a parameter name. All numeric parts (before and after the
decimal point and in the exponent) may contain underscores after the
leading digit for visual guidance; these are ignored in computation.

<span id="index-arithmetic-operators"></span>
<span id="index-operators_002c-arithmetic"></span>

An arithmetic expression uses nearly the same syntax and associativity
of expressions as in C.

In the native mode of operation, the following operators are supported
(listed in decreasing order of precedence):

  - `+ - ! ~ ++ –`  
    unary plus/minus, logical NOT, complement, {pre,post}{in,de}crement

  - `<< >>`  
    bitwise shift left, right

  - `&`  
    bitwise AND

  - `^`  
    bitwise XOR

  - `|`  
    bitwise OR

  - `**`  
    exponentiation

  - `* / %`  
    multiplication, division, modulus (remainder)

  - `+ -`  
    addition, subtraction

  - `< > <= >=`  
    comparison

  - `== !=`  
    equality and inequality

  - `&&`  
    logical AND

  - `|| ^^`  
    logical OR, XOR

  - `? :`  
    ternary operator

  - `= += -= *= /= %= &= ^= |= <<= >>= &&= ||= ^^= **=`  
    assignment

  - `,`  
    comma operator

The operators ‘`&&`’, ‘`||`’, ‘`&&=`’, and ‘`||=`’ are short-circuiting,
and only one of the latter two expressions in a ternary operator is
evaluated. Note the precedence of the bitwise AND, OR, and XOR
operators.

With the option `C_PRECEDENCES` the precedences (but no other
properties) of the operators are altered to be the same as those in most
other languages that support the relevant operators:

  - `+ - ! ~ ++ –`  
    unary plus/minus, logical NOT, complement, {pre,post}{in,de}crement

  - `**`  
    exponentiation

  - `* / %`  
    multiplication, division, modulus (remainder)

  - `+ -`  
    addition, subtraction

  - `<< >>`  
    bitwise shift left, right

  - `< > <= >=`  
    comparison

  - `== !=`  
    equality and inequality

  - `&`  
    bitwise AND

  - `^`  
    bitwise XOR

  - `|`  
    bitwise OR

  - `&&`  
    logical AND

  - `^^`  
    logical XOR

  - `||`  
    logical OR

  - `? :`  
    ternary operator

  - `= += -= *= /= %= &= ^= |= <<= >>= &&= ||= ^^= **=`  
    assignment

  - `,`  
    comma operator

Note the precedence of exponentiation in both cases is below that of
unary operators, hence ‘`-3**2`’ evaluates as ‘`9`’, not ‘`-9`’. Use
parentheses where necessary: ‘`-(3**2)`’. This is for compatibility with
other shells.

<span id="index-mathematical-functions_002c-use-of"></span>
<span id="index-functions_002c-math_002c-use-of"></span>

Mathematical functions can be called with the syntax
‘`func``(``args``)`’, where the function decides if the `args` is
used as a string or a comma-separated list of arithmetic expressions.
The shell currently defines no mathematical functions by default, but
the module `zsh/mathfunc` may be loaded with the `zmodload` builtin to
provide standard floating point mathematical functions.

An expression of the form ‘`##``x`’ where `x` is any character sequence
such as ‘`a`’, ‘`^A`’, or ‘`\M-\C-x`’ gives the value of this character
and an expression of the form ‘`#``name`’ gives the value of the first
character of the contents of the parameter `name`. Character values are
according to the character set used in the current locale; for multibyte
character handling the option `MULTIBYTE` must be set. Note that this
form is different from ‘`$#``name`’, a standard parameter substitution
which gives the length of the parameter `name`. ‘`#\`’ is accepted
instead of ‘`##`’, but its use is deprecated.

Named parameters and subscripted arrays can be referenced by name within
an arithmetic expression without using the parameter expansion syntax.
For example,

<div class="example">

``` example
((val2 = val1 * 2))
```

</div>

assigns twice the value of `$val1` to the parameter named `val2`.

An internal integer representation of a named parameter can be specified
with the `integer` builtin.
<span id="index-parameters_002c-integer"></span>
<span id="index-integer-parameters"></span>
<span id="index-integer_002c-use-of"></span> Arithmetic evaluation is
performed on the value of each assignment to a named parameter declared
integer in this manner. Assigning a floating point number to an integer
results in rounding towards zero.

<span id="index-parameters_002c-floating-point"></span>
<span id="index-floating-point-parameters"></span>
<span id="index-float_002c-use-of"></span>

Likewise, floating point numbers can be declared with the `float`
builtin; there are two types, differing only in their output format, as
described for the `typeset` builtin. The output format can be bypassed
by using arithmetic substitution instead of the parameter substitution,
i.e. ‘`${``float``}`’ uses the defined format, but ‘`$((``float``))`’
uses a generic floating point format.

Promotion of integer to floating point values is performed where
necessary. In addition, if any operator which requires an integer
(‘`&`’, ‘`|`’, ‘`^`’, ‘`<<`’, ‘`>>`’ and their equivalents with
assignment) is given a floating point argument, it will be silently
rounded towards zero except for ‘`~`’ which rounds down.

Users should beware that, in common with many other programming
languages but not software designed for calculation, the evaluation of
an expression in zsh is taken a term at a time and promotion of integers
to floating point does not occur in terms only containing integers. A
typical result of this is that a division such as `6/8` is truncated, in
this being rounded towards 0. The `FORCE_FLOAT` shell option can be used
in scripts or functions where floating point evaluation is required
throughout.

Scalar variables can hold integer or floating point values at different
times; there is no memory of the numeric type in this case.

If a variable is first assigned in a numeric context without previously
being declared, it will be implicitly typed as `integer` or `float` and
retain that type either until the type is explicitly changed or until
the end of the scope. This can have unforeseen consequences. For
example, in the loop

<div class="example">

``` example
for (( f = 0; f < 1; f += 0.1 )); do
# use $f
done
```

</div>

if `f` has not already been declared, the first assignment will cause it
to be created as an integer, and consequently the operation ‘`f += 0.1`’
will always cause the result to be truncated to zero, so that the loop
will fail. A simple fix would be to turn the initialization into ‘`f
= 0.0`’. It is therefore best to declare numeric variables with explicit
types.

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
