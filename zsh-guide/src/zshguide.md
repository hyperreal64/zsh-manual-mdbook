-----

# A User's Guide to the Z-Shell

## Peter Stephenson

## 2003/03/23

# Table of Contents

## [Chapter 1: A short introduction](zshguide01.html#l1)

### [1.1: Other shells and other guides](zshguide01.html#l2)

### [1.2: Versions of zsh](zshguide01.html#l3)

### [1.3: Conventions](zshguide01.html#l4)

### [1.4: Acknowledgments](zshguide01.html#l5)

## [Chapter 2: What to put in your startup files](zshguide02.html#l6)

### [2.1: Types of shell: interactive and login shells](zshguide02.html#l7)

[2.1.1: What is a login shell? Simple tests](zshguide02.html#l8)

### [2.2: All the startup files](zshguide02.html#l9)

### [2.3: Options](zshguide02.html#l10)

### [2.4: Parameters](zshguide02.html#l11)

[2.4.1: Arrays](zshguide02.html#l12)

### [2.5: What to put in your startup files](zshguide02.html#l13)

[2.5.1: Compatibility options: `SH_WORD_SPLIT` and
others](zshguide02.html#l14)

[2.5.2: Options for csh junkies](zshguide02.html#l15)

[2.5.3: The history mechanism: types of history](zshguide02.html#l16)

[2.5.4: Setting up history](zshguide02.html#l17)

[2.5.5: History options](zshguide02.html#l18)

[2.5.6: Prompts](zshguide02.html#l19)

[2.5.7: Named directories](zshguide02.html#l20)

[2.5.8: \`Go faster' options for power users](zshguide02.html#l21)

[2.5.9: aliases](zshguide02.html#l22)

[2.5.10: Environment variables](zshguide02.html#l23)

[2.5.11: Path](zshguide02.html#l24)

[2.5.12: Mail](zshguide02.html#l25)

[2.5.13: Other path-like things](zshguide02.html#l26)

[2.5.14: Version-specific things](zshguide02.html#l27)

[2.5.15: Everything else](zshguide02.html#l28)

## [Chapter 3: Dealing with basic shell syntax](zshguide03.html#l29)

### [3.1: External commands](zshguide03.html#l30)

### [3.2: Builtin commands](zshguide03.html#l31)

[3.2.1: Builtins for printing](zshguide03.html#l32)

[3.2.2: Other builtins just for speed](zshguide03.html#l33)

[3.2.3: Builtins which change the shell's state](zshguide03.html#l34)

[3.2.4: cd and friends](zshguide03.html#l35)

[3.2.5: Command control and information commands](zshguide03.html#l36)

[3.2.6: Parameter control](zshguide03.html#l37)

[3.2.7: History control commands](zshguide03.html#l38)

[3.2.8: Job control and process control](zshguide03.html#l39)

[3.2.9: Terminals, users, etc.](zshguide03.html#l40)

[3.2.10: Syntactic oddments](zshguide03.html#l41)

[3.2.11: More precommand modifiers: `exec`,
`noglob`](zshguide03.html#l42)

[3.2.12: Testing things](zshguide03.html#l43)

[3.2.13: Handling options to functions and scripts](zshguide03.html#l44)

[3.2.14: Random file control things](zshguide03.html#l45)

[3.2.15: Don't watch this space, watch some other](zshguide03.html#l46)

[3.2.16: And also](zshguide03.html#l47)

### [3.3: Functions](zshguide03.html#l48)

[3.3.1: Loading functions](zshguide03.html#l49)

[3.3.2: Function parameters](zshguide03.html#l50)

[3.3.3: Compiling functions](zshguide03.html#l51)

### [3.4: Aliases](zshguide03.html#l52)

### [3.5: Command summary](zshguide03.html#l53)

### [3.6: Expansions and quotes](zshguide03.html#l54)

[3.6.1: History expansion](zshguide03.html#l55)

[3.6.2: Alias expansion](zshguide03.html#l56)

[3.6.3: Process, parameter, command, arithmetic and brace
expansion](zshguide03.html#l57)

[3.6.4: Filename Expansion](zshguide03.html#l58)

[3.6.5: Filename Generation](zshguide03.html#l59)

### [3.7: Redirection: greater-thans and less-thans](zshguide03.html#l60)

[3.7.1: Clobber](zshguide03.html#l61)

[3.7.2: File descriptors](zshguide03.html#l62)

[3.7.3: Appending, here documents, here strings, read
write](zshguide03.html#l63)

[3.7.4: Clever tricks: exec and other file
descriptors](zshguide03.html#l64)

[3.7.5: Multios](zshguide03.html#l65)

### [3.8: Shell syntax: loops, (sub)shells and so on](zshguide03.html#l66)

[3.8.1: Logical command connectors](zshguide03.html#l67)

[3.8.2: Structures](zshguide03.html#l68)

[3.8.3: Subshells and current shell constructs](zshguide03.html#l69)

[3.8.4: Subshells and current shells](zshguide03.html#l70)

### [3.9: Emulation and portability](zshguide03.html#l71)

[3.9.1: Differences in detail](zshguide03.html#l72)

[3.9.2: Making your own scripts and functions
portable](zshguide03.html#l73)

### [3.10: Running scripts](zshguide03.html#l74)

## [Chapter 4: The Z-Shell Line Editor](zshguide04.html#l75)

### [4.1: Introducing zle](zshguide04.html#l76)

[4.1.1: The simple facts](zshguide04.html#l77)

[4.1.2: Vi mode](zshguide04.html#l78)

### [4.2: Basic editing](zshguide04.html#l79)

[4.2.1: Moving](zshguide04.html#l80)

[4.2.2: Deleting](zshguide04.html#l81)

[4.2.3: More deletion](zshguide04.html#l82)

### [4.3: Fancier editing](zshguide04.html#l83)

[4.3.1: Options controlling zle](zshguide04.html#l84)

[4.3.2: The minibuffer and extended commands](zshguide04.html#l85)

[4.3.3: Prefix (digit) arguments](zshguide04.html#l86)

[4.3.4: Words, regions and marks](zshguide04.html#l87)

[4.3.5: Regions and marks](zshguide04.html#l88)

### [4.4: History and searching](zshguide04.html#l89)

[4.4.1: Moving through the history](zshguide04.html#l90)

[4.4.2: Searching through the history](zshguide04.html#l91)

[4.4.3: Extracting words from the history](zshguide04.html#l92)

### [4.5: Binding keys and handling keymaps](zshguide04.html#l93)

[4.5.1: Simple key bindings](zshguide04.html#l94)

[4.5.2: Removing key bindings](zshguide04.html#l95)

[4.5.3: Function keys and so on](zshguide04.html#l96)

[4.5.4: Binding strings instead of commands](zshguide04.html#l97)

[4.5.5: Keymaps](zshguide04.html#l98)

### [4.6: Advanced editing](zshguide04.html#l99)

[4.6.1: Multi-line editing](zshguide04.html#l100)

[4.6.2: The builtin vared and the function zed](zshguide04.html#l101)

[4.6.3: The buffer stack](zshguide04.html#l102)

### [4.7: Extending zle](zshguide04.html#l103)

[4.7.1: Widgets](zshguide04.html#l104)

[4.7.2: Executing other widgets](zshguide04.html#l105)

[4.7.3: Some special builtin widgets and their
uses](zshguide04.html#l106)

[4.7.4: Special parameters: normal text](zshguide04.html#l107)

[4.7.5: Other special parameters](zshguide04.html#l108)

[4.7.6: Reading keys and using the minibuffer](zshguide04.html#l109)

[4.7.7: Examples](zshguide04.html#l110)

## [Chapter 5: Substitutions](zshguide05.html#l111)

### [5.1: Quoting](zshguide05.html#l112)

[5.1.1: Backslashes](zshguide05.html#l113)

[5.1.2: Single quotes](zshguide05.html#l114)

[5.1.3: POSIX quotes](zshguide05.html#l115)

[5.1.4: Double quotes](zshguide05.html#l116)

[5.1.5: Backquotes](zshguide05.html#l117)

### [5.2: Modifiers and what they modify](zshguide05.html#l118)

### [5.3: Process Substitution](zshguide05.html#l119)

### [5.4: Parameter substitution](zshguide05.html#l120)

[5.4.1: Using arrays](zshguide05.html#l121)

[5.4.2: Using associative arrays](zshguide05.html#l122)

[5.4.3: Substituted substitutions, top- and tailing,
etc.](zshguide05.html#l123)

[5.4.4: Flags for options: splitting and joining](zshguide05.html#l124)

[5.4.5: Flags for options: `GLOB_SUBST` and
`RC_EXPAND_PARAM`](zshguide05.html#l125)

[5.4.6: Yet more parameter flags](zshguide05.html#l126)

[5.4.7: A couple of parameter substitution tricks](zshguide05.html#l127)

[5.4.8: Nested parameter substitutions](zshguide05.html#l128)

### [5.5: That substitution again](zshguide05.html#l129)

### [5.6: Arithmetic Expansion](zshguide05.html#l130)

[5.6.1: Entering and outputting bases](zshguide05.html#l131)

[5.6.2: Parameter typing](zshguide05.html#l132)

### [5.7: Brace Expansion and Arrays](zshguide05.html#l133)

### [5.8: Filename Expansion](zshguide05.html#l134)

### [5.9: Filename Generation and Pattern Matching](zshguide05.html#l135)

[5.9.1: Comparing patterns and regular
expressions](zshguide05.html#l136)

[5.9.2: Standard features](zshguide05.html#l137)

[5.9.3: Extensions usually available](zshguide05.html#l138)

[5.9.4: Extensions requiring `EXTENDED_GLOB`](zshguide05.html#l139)

[5.9.5: Recursive globbing](zshguide05.html#l140)

[5.9.6: Glob qualifiers](zshguide05.html#l141)

[5.9.7: Globbing flags: alter the behaviour of
matches](zshguide05.html#l142)

[5.9.8: The function `zmv`](zshguide05.html#l143)

## [Chapter 6: Completion, old and new](zshguide06.html#l144)

### [6.1: Completion and expansion](zshguide06.html#l145)

### [6.2: Configuring completion using shell options](zshguide06.html#l146)

[6.2.1: Ambiguous completions](zshguide06.html#l147)

[6.2.2: `ALWAYS_LAST_PROMPT`](zshguide06.html#l148)

[6.2.3: Menu completion and menu selection](zshguide06.html#l149)

[6.2.4: Other ways of changing completion
behaviour](zshguide06.html#l150)

[6.2.5: Changing the way completions are
displayed](zshguide06.html#l151)

### [6.3: Getting started with new completion](zshguide06.html#l152)

### [6.4: How the shell finds the right completions](zshguide06.html#l153)

[6.4.1: Contexts](zshguide06.html#l154)

[6.4.2: Tags](zshguide06.html#l155)

### [6.5: Configuring completion using styles](zshguide06.html#l156)

[6.5.1: Specifying completers and their options](zshguide06.html#l157)

[6.5.2: Changing the format of listings: groups
etc.](zshguide06.html#l158)

[6.5.3: Styles affecting particular completions](zshguide06.html#l159)

### [6.6: Command widgets](zshguide06.html#l160)

[6.6.1: `_complete_help`](zshguide06.html#l161)

[6.6.2: `_correct_word`, `_correct_filename`,
`_expand_word`](zshguide06.html#l162)

[6.6.3: `_history_complete_word`](zshguide06.html#l163)

[6.6.4: `_most_recent_file`](zshguide06.html#l164)

[6.6.5: `_next_tags`](zshguide06.html#l165)

[6.6.6: `_bash_completions`](zshguide06.html#l166)

[6.6.7: `_read_comp`](zshguide06.html#l167)

[6.6.8: `_generic`](zshguide06.html#l168)

[6.6.9: `predict-on`, `incremental-complete-word`](zshguide06.html#l169)

### [6.7: Matching control and controlling where things are inserted](zshguide06.html#l170)

[6.7.1: Case-insensitive matching](zshguide06.html#l171)

[6.7.2: Matching option names](zshguide06.html#l172)

[6.7.3: Partial word completion](zshguide06.html#l173)

[6.7.4: Substring completion](zshguide06.html#l174)

[6.7.5: Partial words with capitals](zshguide06.html#l175)

[6.7.6: Final notes](zshguide06.html#l176)

### [6.8: Tutorial](zshguide06.html#l177)

[6.8.1: The dispatcher](zshguide06.html#l178)

[6.8.2: Subcommand completion: `_arguments`](zshguide06.html#l179)

[6.8.3: Completing particular argument types](zshguide06.html#l180)

[6.8.4: The rest](zshguide06.html#l181)

### [6.9: Writing new completion functions and widgets](zshguide06.html#l182)

[6.9.1: Loading completion functions: `compdef`](zshguide06.html#l183)

[6.9.2: Adding a set of completions: `compadd`](zshguide06.html#l184)

[6.9.3: Functions for generating filenames, etc.](zshguide06.html#l185)

[6.9.4: The `zsh/parameter` module](zshguide06.html#l186)

[6.9.5: Special completion parameters and
`compset`](zshguide06.html#l187)

[6.9.6: Fancier completion: using the tags and styles
mechanism](zshguide06.html#l188)

[6.9.7: Getting the work done for you: handling arguments
etc.](zshguide06.html#l189)

[6.9.8: More completion utility functions](zshguide06.html#l190)

### [6.10: Finally](zshguide06.html#l191)

## [Chapter 7: Modules and other bits and pieces *Not written*](zshguide07.html#l192)

### [7.1: Control over modules: `zmodload`](zshguide07.html#l193)

[7.1.1: Modules defining parameters](zshguide07.html#l194)

[7.1.2: Low-level system interaction](zshguide07.html#l195)

[7.1.3: ZFTP](zshguide07.html#l196)

### [7.2: Contributed bits](zshguide07.html#l197)

[7.2.1: Prompt themes](zshguide07.html#l198)

### [7.3: What's new in 4.1](zshguide07.html#l199)

## [Appendix 1: Obtaining zsh and getting more information *Not written*](zshguide08.html#l200)

-----
