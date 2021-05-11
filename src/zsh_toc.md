<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Table of Contents](#table-of-contents)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="SEC_Contents"></span>

# Table of Contents

<div class="contents">

  - [1 The Z Shell Manual](The-Z-Shell-Manual.html#The-Z-Shell-Manual)
      - [1.1 Producing documentation from
        zsh.texi](The-Z-Shell-Manual.html#Producing-documentation-from-zsh_002etexi)
  - [2 Introduction](Introduction.html#Introduction)
      - [2.1 Author](Introduction.html#Author)
      - [2.2 Availability](Introduction.html#Availability)
      - [2.3 Mailing Lists](Introduction.html#Mailing-Lists)
      - [2.4 The Zsh FAQ](Introduction.html#The-Zsh-FAQ)
      - [2.5 The Zsh Web Page](Introduction.html#The-Zsh-Web-Page)
      - [2.6 The Zsh Userguide](Introduction.html#The-Zsh-Userguide)
      - [2.7 See Also](Introduction.html#See-Also)
  - [3 Roadmap](Roadmap.html#Roadmap)
      - [3.1 When the shell starts](Roadmap.html#When-the-shell-starts)
      - [3.2 Interactive Use](Roadmap.html#Interactive-Use)
          - [3.2.1 Completion](Roadmap.html#Completion-1)
          - [3.2.2 Extending the line
            editor](Roadmap.html#Extending-the-line-editor)
      - [3.3 Options](Roadmap.html#Options-3)
      - [3.4 Pattern Matching](Roadmap.html#Pattern-Matching)
      - [3.5 General Comments on
        Syntax](Roadmap.html#General-Comments-on-Syntax)
      - [3.6 Programming](Roadmap.html#Programming)
  - [4 Invocation](Invocation.html#Invocation)
      - [4.1 Invocation](Invocation.html#Invocation-2)
      - [4.2 Compatibility](Invocation.html#Compatibility)
      - [4.3 Restricted Shell](Invocation.html#Restricted-Shell)
  - [5 Files](Files.html#Files)
      - [5.1 Startup/Shutdown
        Files](Files.html#Startup_002fShutdown-Files)
      - [5.2 Files](Files.html#Files-2)
  - [6 Shell Grammar](Shell-Grammar.html#Shell-Grammar)
      - [6.1 Simple Commands &
        Pipelines](Shell-Grammar.html#Simple-Commands-_0026-Pipelines)
      - [6.2 Precommand
        Modifiers](Shell-Grammar.html#Precommand-Modifiers)
      - [6.3 Complex Commands](Shell-Grammar.html#Complex-Commands)
      - [6.4 Alternate Forms For Complex
        Commands](Shell-Grammar.html#Alternate-Forms-For-Complex-Commands)
      - [6.5 Reserved Words](Shell-Grammar.html#Reserved-Words)
      - [6.6 Errors](Shell-Grammar.html#Errors)
      - [6.7 Comments](Shell-Grammar.html#Comments)
      - [6.8 Aliasing](Shell-Grammar.html#Aliasing)
          - [6.8.1 Alias
            difficulties](Shell-Grammar.html#Alias-difficulties)
      - [6.9 Quoting](Shell-Grammar.html#Quoting)
  - [7 Redirection](Redirection.html#Redirection)
      - [7.1 Opening file descriptors using
        parameters](Redirection.html#Opening-file-descriptors-using-parameters)
      - [7.2 Multios](Redirection.html#Multios)
      - [7.3 Redirections with no
        command](Redirection.html#Redirections-with-no-command)
  - [8 Command Execution](Command-Execution.html#Command-Execution)
  - [9 Functions](Functions.html#Functions)
      - [9.1 Autoloading
        Functions](Functions.html#Autoloading-Functions)
      - [9.2 Anonymous Functions](Functions.html#Anonymous-Functions)
      - [9.3 Special Functions](Functions.html#Special-Functions)
          - [9.3.1 Hook Functions](Functions.html#Hook-Functions)
          - [9.3.2 Trap Functions](Functions.html#Trap-Functions)
  - [10 Jobs & Signals](Jobs-_0026-Signals.html#Jobs-_0026-Signals)
      - [10.1 Jobs](Jobs-_0026-Signals.html#Jobs)
      - [10.2 Signals](Jobs-_0026-Signals.html#Signals)
  - [11 Arithmetic
    Evaluation](Arithmetic-Evaluation.html#Arithmetic-Evaluation)
  - [12 Conditional
    Expressions](Conditional-Expressions.html#Conditional-Expressions)
  - [13 Prompt Expansion](Prompt-Expansion.html#Prompt-Expansion)
      - [13.1 Expansion of Prompt
        Sequences](Prompt-Expansion.html#Expansion-of-Prompt-Sequences)
      - [13.2 Simple Prompt
        Escapes](Prompt-Expansion.html#Simple-Prompt-Escapes)
          - [13.2.1 Special
            characters](Prompt-Expansion.html#Special-characters)
          - [13.2.2 Login
            information](Prompt-Expansion.html#Login-information)
          - [13.2.3 Shell state](Prompt-Expansion.html#Shell-state)
          - [13.2.4 Date and time](Prompt-Expansion.html#Date-and-time)
          - [13.2.5 Visual
            effects](Prompt-Expansion.html#Visual-effects)
      - [13.3 Conditional Substrings in
        Prompts](Prompt-Expansion.html#Conditional-Substrings-in-Prompts)
  - [14 Expansion](Expansion.html#Expansion)
      - [14.1 History Expansion](Expansion.html#History-Expansion)
          - [14.1.1 Overview](Expansion.html#Overview)
          - [14.1.2 Event Designators](Expansion.html#Event-Designators)
          - [14.1.3 Word Designators](Expansion.html#Word-Designators)
          - [14.1.4 Modifiers](Expansion.html#Modifiers)
      - [14.2 Process Substitution](Expansion.html#Process-Substitution)
      - [14.3 Parameter Expansion](Expansion.html#Parameter-Expansion)
          - [14.3.1 Parameter Expansion
            Flags](Expansion.html#Parameter-Expansion-Flags)
          - [14.3.2 Rules](Expansion.html#Rules)
          - [14.3.3 Examples](Expansion.html#Examples-1)
      - [14.4 Command Substitution](Expansion.html#Command-Substitution)
      - [14.5 Arithmetic Expansion](Expansion.html#Arithmetic-Expansion)
      - [14.6 Brace Expansion](Expansion.html#Brace-Expansion)
      - [14.7 Filename Expansion](Expansion.html#Filename-Expansion)
          - [14.7.1 Dynamic named
            directories](Expansion.html#Dynamic-named-directories)
          - [14.7.2 Static named
            directories](Expansion.html#Static-named-directories)
          - [14.7.3 ‘=’
            expansion](Expansion.html#g_t_0060_003d_0027-expansion)
          - [14.7.4 Notes](Expansion.html#Notes)
      - [14.8 Filename Generation](Expansion.html#Filename-Generation)
          - [14.8.1 Glob Operators](Expansion.html#Glob-Operators)
          - [14.8.2 ksh-like Glob
            Operators](Expansion.html#ksh_002dlike-Glob-Operators)
          - [14.8.3 Precedence](Expansion.html#Precedence)
          - [14.8.4 Globbing Flags](Expansion.html#Globbing-Flags)
          - [14.8.5 Approximate
            Matching](Expansion.html#Approximate-Matching)
          - [14.8.6 Recursive
            Globbing](Expansion.html#Recursive-Globbing)
          - [14.8.7 Glob Qualifiers](Expansion.html#Glob-Qualifiers)
  - [15 Parameters](Parameters.html#Parameters)
      - [15.1 Description](Parameters.html#Description-5)
      - [15.2 Array Parameters](Parameters.html#Array-Parameters)
          - [15.2.1 Array Subscripts](Parameters.html#Array-Subscripts)
          - [15.2.2 Array Element
            Assignment](Parameters.html#Array-Element-Assignment)
          - [15.2.3 Subscript Flags](Parameters.html#Subscript-Flags)
          - [15.2.4 Subscript
            Parsing](Parameters.html#Subscript-Parsing)
      - [15.3 Positional
        Parameters](Parameters.html#Positional-Parameters)
      - [15.4 Local Parameters](Parameters.html#Local-Parameters)
      - [15.5 Parameters Set By The
        Shell](Parameters.html#Parameters-Set-By-The-Shell)
      - [15.6 Parameters Used By The
        Shell](Parameters.html#Parameters-Used-By-The-Shell)
  - [16 Options](Options.html#Options)
      - [16.1 Specifying Options](Options.html#Specifying-Options)
      - [16.2 Description of
        Options](Options.html#Description-of-Options)
          - [16.2.1 Changing
            Directories](Options.html#Changing-Directories)
          - [16.2.2 Completion](Options.html#Completion-4)
          - [16.2.3 Expansion and
            Globbing](Options.html#Expansion-and-Globbing)
          - [16.2.4 History](Options.html#History)
          - [16.2.5 Initialisation](Options.html#Initialisation)
          - [16.2.6 Input/Output](Options.html#Input_002fOutput)
          - [16.2.7 Job Control](Options.html#Job-Control)
          - [16.2.8 Prompting](Options.html#Prompting)
          - [16.2.9 Scripts and
            Functions](Options.html#Scripts-and-Functions)
          - [16.2.10 Shell Emulation](Options.html#Shell-Emulation)
          - [16.2.11 Shell State](Options.html#Shell-State)
          - [16.2.12 Zle](Options.html#Zle)
      - [16.3 Option Aliases](Options.html#Option-Aliases)
      - [16.4 Single Letter Options](Options.html#Single-Letter-Options)
          - [16.4.1 Default set](Options.html#Default-set)
          - [16.4.2 sh/ksh emulation
            set](Options.html#sh_002fksh-emulation-set)
          - [16.4.3 Also note](Options.html#Also-note)
  - [17 Shell Builtin
    Commands](Shell-Builtin-Commands.html#Shell-Builtin-Commands)
  - [18 Zsh Line Editor](Zsh-Line-Editor.html#Zsh-Line-Editor)
      - [18.1 Description](Zsh-Line-Editor.html#Description-9)
      - [18.2 Keymaps](Zsh-Line-Editor.html#Keymaps)
          - [18.2.1 Reading
            Commands](Zsh-Line-Editor.html#Reading-Commands)
          - [18.2.2 Local Keymaps](Zsh-Line-Editor.html#Local-Keymaps)
      - [18.3 Zle Builtins](Zsh-Line-Editor.html#Zle-Builtins)
      - [18.4 Widgets](Zsh-Line-Editor.html#Zle-Widgets)
      - [18.5 User-Defined
        Widgets](Zsh-Line-Editor.html#User_002dDefined-Widgets)
          - [18.5.1 Special
            Widgets](Zsh-Line-Editor.html#Special-Widgets)
      - [18.6 Standard Widgets](Zsh-Line-Editor.html#Standard-Widgets)
          - [18.6.1 Movement](Zsh-Line-Editor.html#Movement)
          - [18.6.2 History
            Control](Zsh-Line-Editor.html#History-Control)
          - [18.6.3 Modifying Text](Zsh-Line-Editor.html#Modifying-Text)
          - [18.6.4 Arguments](Zsh-Line-Editor.html#Arguments)
          - [18.6.5 Completion](Zsh-Line-Editor.html#Completion)
          - [18.6.6 Miscellaneous](Zsh-Line-Editor.html#Miscellaneous)
          - [18.6.7 Text Objects](Zsh-Line-Editor.html#Text-Objects)
      - [18.7 Character
        Highlighting](Zsh-Line-Editor.html#Character-Highlighting)
  - [19 Completion Widgets](Completion-Widgets.html#Completion-Widgets)
      - [19.1 Description](Completion-Widgets.html#Description-1)
      - [19.2 Completion Special
        Parameters](Completion-Widgets.html#Completion-Special-Parameters)
      - [19.3 Completion Builtin
        Commands](Completion-Widgets.html#Completion-Builtin-Commands)
      - [19.4 Completion Condition
        Codes](Completion-Widgets.html#Completion-Condition-Codes)
      - [19.5 Completion Matching
        Control](Completion-Widgets.html#Completion-Matching-Control)
      - [19.6 Completion Widget
        Example](Completion-Widgets.html#Completion-Widget-Example)
  - [20 Completion System](Completion-System.html#Completion-System)
      - [20.1 Description](Completion-System.html#Description-3)
      - [20.2 Initialization](Completion-System.html#Initialization)
          - [20.2.1 Use of
            compinit](Completion-System.html#Use-of-compinit)
          - [20.2.2 Autoloaded
            files](Completion-System.html#Autoloaded-files)
          - [20.2.3 Functions](Completion-System.html#Functions-4)
      - [20.3 Completion System
        Configuration](Completion-System.html#Completion-System-Configuration)
          - [20.3.1 Overview](Completion-System.html#Overview-1)
          - [20.3.2 Standard Tags](Completion-System.html#Standard-Tags)
          - [20.3.3 Standard
            Styles](Completion-System.html#Standard-Styles)
      - [20.4 Control
        Functions](Completion-System.html#Control-Functions)
      - [20.5 Bindable
        Commands](Completion-System.html#Bindable-Commands)
      - [20.6 Utility
        Functions](Completion-System.html#Completion-Functions)
      - [20.7 Completion System
        Variables](Completion-System.html#Completion-System-Variables)
      - [20.8 Completion
        Directories](Completion-System.html#Completion-Directories)
  - [21 Completion Using
    compctl](Completion-Using-compctl.html#Completion-Using-compctl)
      - [21.1 Types of
        completion](Completion-Using-compctl.html#Types-of-completion)
      - [21.2 Description](Completion-Using-compctl.html#Description-7)
      - [21.3 Command
        Flags](Completion-Using-compctl.html#Command-Flags)
      - [21.4 Option Flags](Completion-Using-compctl.html#Option-Flags)
          - [21.4.1 Simple
            Flags](Completion-Using-compctl.html#Simple-Flags)
          - [21.4.2 Flags with
            Arguments](Completion-Using-compctl.html#Flags-with-Arguments)
          - [21.4.3 Control
            Flags](Completion-Using-compctl.html#Control-Flags)
      - [21.5 Alternative
        Completion](Completion-Using-compctl.html#Alternative-Completion)
      - [21.6 Extended
        Completion](Completion-Using-compctl.html#Extended-Completion)
      - [21.7 Example](Completion-Using-compctl.html#Example)
  - [22 Zsh Modules](Zsh-Modules.html#Zsh-Modules)
      - [22.1 Description](Zsh-Modules.html#Description-6)
      - [22.2 The zsh/attr
        Module](Zsh-Modules.html#The-zsh_002fattr-Module)
      - [22.3 The zsh/cap
        Module](Zsh-Modules.html#The-zsh_002fcap-Module)
      - [22.4 The zsh/clone
        Module](Zsh-Modules.html#The-zsh_002fclone-Module)
      - [22.5 The zsh/compctl
        Module](Zsh-Modules.html#The-zsh_002fcompctl-Module)
      - [22.6 The zsh/complete
        Module](Zsh-Modules.html#The-zsh_002fcomplete-Module)
      - [22.7 The zsh/complist
        Module](Zsh-Modules.html#The-zsh_002fcomplist-Module)
          - [22.7.1 Colored completion
            listings](Zsh-Modules.html#Colored-completion-listings)
          - [22.7.2 Scrolling in completion
            listings](Zsh-Modules.html#Scrolling-in-completion-listings)
          - [22.7.3 Menu selection](Zsh-Modules.html#Menu-selection)
      - [22.8 The zsh/computil
        Module](Zsh-Modules.html#The-zsh_002fcomputil-Module)
      - [22.9 The zsh/curses
        Module](Zsh-Modules.html#The-zsh_002fcurses-Module)
          - [22.9.1 Builtin](Zsh-Modules.html#Builtin)
          - [22.9.2 Parameters](Zsh-Modules.html#Parameters-4)
      - [22.10 The zsh/datetime
        Module](Zsh-Modules.html#The-zsh_002fdatetime-Module)
      - [22.11 The zsh/db/gdbm
        Module](Zsh-Modules.html#The-zsh_002fdb_002fgdbm-Module)
      - [22.12 The zsh/deltochar
        Module](Zsh-Modules.html#The-zsh_002fdeltochar-Module)
      - [22.13 The zsh/example
        Module](Zsh-Modules.html#The-zsh_002fexample-Module)
      - [22.14 The zsh/files
        Module](Zsh-Modules.html#The-zsh_002ffiles-Module)
      - [22.15 The zsh/langinfo
        Module](Zsh-Modules.html#The-zsh_002flanginfo-Module)
      - [22.16 The zsh/mapfile
        Module](Zsh-Modules.html#The-zsh_002fmapfile-Module)
          - [22.16.1 Limitations](Zsh-Modules.html#Limitations)
      - [22.17 The zsh/mathfunc
        Module](Zsh-Modules.html#The-zsh_002fmathfunc-Module)
      - [22.18 The zsh/nearcolor
        Module](Zsh-Modules.html#The-zsh_002fnearcolor-Module)
      - [22.19 The zsh/newuser
        Module](Zsh-Modules.html#The-zsh_002fnewuser-Module)
      - [22.20 The zsh/parameter
        Module](Zsh-Modules.html#The-zsh_002fparameter-Module)
      - [22.21 The zsh/pcre
        Module](Zsh-Modules.html#The-zsh_002fpcre-Module)
      - [22.22 The zsh/param/private
        Module](Zsh-Modules.html#The-zsh_002fparam_002fprivate-Module)
      - [22.23 The zsh/regex
        Module](Zsh-Modules.html#The-zsh_002fregex-Module)
      - [22.24 The zsh/sched
        Module](Zsh-Modules.html#The-zsh_002fsched-Module)
      - [22.25 The zsh/net/socket
        Module](Zsh-Modules.html#The-zsh_002fnet_002fsocket-Module)
          - [22.25.1 Outbound
            Connections](Zsh-Modules.html#Outbound-Connections-1)
          - [22.25.2 Inbound
            Connections](Zsh-Modules.html#Inbound-Connections)
      - [22.26 The zsh/stat
        Module](Zsh-Modules.html#The-zsh_002fstat-Module)
      - [22.27 The zsh/system
        Module](Zsh-Modules.html#The-zsh_002fsystem-Module)
          - [22.27.1 Builtins](Zsh-Modules.html#Builtins)
          - [22.27.2 Math Functions](Zsh-Modules.html#Math-Functions)
          - [22.27.3 Parameters](Zsh-Modules.html#Parameters-3)
      - [22.28 The zsh/net/tcp
        Module](Zsh-Modules.html#The-zsh_002fnet_002ftcp-Module)
          - [22.28.1 Outbound
            Connections](Zsh-Modules.html#Outbound-Connections)
          - [22.28.2 Inbound
            Connections](Zsh-Modules.html#Inbound-Connections-1)
          - [22.28.3 Closing
            Connections](Zsh-Modules.html#Closing-Connections)
          - [22.28.4 Example](Zsh-Modules.html#Example-1)
      - [22.29 The zsh/termcap
        Module](Zsh-Modules.html#The-zsh_002ftermcap-Module)
      - [22.30 The zsh/terminfo
        Module](Zsh-Modules.html#The-zsh_002fterminfo-Module)
      - [22.31 The zsh/zftp
        Module](Zsh-Modules.html#The-zsh_002fzftp-Module)
          - [22.31.1 Subcommands](Zsh-Modules.html#Subcommands)
          - [22.31.2 Parameters](Zsh-Modules.html#Parameters-2)
          - [22.31.3 Functions](Zsh-Modules.html#Functions-1)
          - [22.31.4 Problems](Zsh-Modules.html#Problems)
      - [22.32 The zsh/zle
        Module](Zsh-Modules.html#The-zsh_002fzle-Module)
      - [22.33 The zsh/zleparameter
        Module](Zsh-Modules.html#The-zsh_002fzleparameter-Module)
      - [22.34 The zsh/zprof
        Module](Zsh-Modules.html#The-zsh_002fzprof-Module)
      - [22.35 The zsh/zpty
        Module](Zsh-Modules.html#The-zsh_002fzpty-Module)
      - [22.36 The zsh/zselect
        Module](Zsh-Modules.html#The-zsh_002fzselect-Module)
      - [22.37 The zsh/zutil
        Module](Zsh-Modules.html#The-zsh_002fzutil-Module)
  - [23 Calendar Function
    System](Calendar-Function-System.html#Calendar-Function-System)
      - [23.1 Description](Calendar-Function-System.html#Description-8)
      - [23.2 File and Date
        Formats](Calendar-Function-System.html#Calendar-File-and-Date-Formats)
          - [23.2.1 Calendar File
            Format](Calendar-Function-System.html#Calendar-File-Format)
          - [23.2.2 Date
            Format](Calendar-Function-System.html#Date-Format)
          - [23.2.3 Relative Time
            Format](Calendar-Function-System.html#Relative-Time-Format)
          - [23.2.4 Example](Calendar-Function-System.html#Example-2)
      - [23.3 User
        Functions](Calendar-Function-System.html#Calendar-System-User-Functions)
          - [23.3.1 Calendar system
            functions](Calendar-Function-System.html#Calendar-system-functions)
          - [23.3.2 Glob
            qualifiers](Calendar-Function-System.html#Glob-qualifiers)
      - [23.4 Styles](Calendar-Function-System.html#Calendar-Styles)
      - [23.5 Utility
        functions](Calendar-Function-System.html#Calendar-Utility-Functions)
      - [23.6 Bugs](Calendar-Function-System.html#Calendar-Bugs)
  - [24 TCP Function
    System](TCP-Function-System.html#TCP-Function-System)
      - [24.1 Description](TCP-Function-System.html#Description)
      - [24.2 TCP User
        Functions](TCP-Function-System.html#TCP-Functions)
          - [24.2.1 Basic I/O](TCP-Function-System.html#Basic-I_002fO)
          - [24.2.2 Session
            Management](TCP-Function-System.html#Session-Management)
          - [24.2.3 Advanced
            I/O](TCP-Function-System.html#Advanced-I_002fO)
          - [24.2.4 ‘One-shot’ file
            transfer](TCP-Function-System.html#g_t_0060One_002dshot_0027-file-transfer)
      - [24.3 TCP User-defined
        Functions](TCP-Function-System.html#TCP-User_002ddefined-Functions)
      - [24.4 TCP Utility
        Functions](TCP-Function-System.html#TCP-Utility-Functions)
      - [24.5 TCP User
        Parameters](TCP-Function-System.html#TCP-Parameters)
      - [24.6 TCP User-defined
        Parameters](TCP-Function-System.html#TCP-User_002ddefined-Parameters)
      - [24.7 TCP Utility
        Parameters](TCP-Function-System.html#TCP-Utility-Parameters)
      - [24.8 TCP Examples](TCP-Function-System.html#TCP-Examples)
      - [24.9 TCP Bugs](TCP-Function-System.html#TCP-Bugs)
  - [25 Zftp Function
    System](Zftp-Function-System.html#Zftp-Function-System)
      - [25.1 Description](Zftp-Function-System.html#Description-4)
      - [25.2 Installation](Zftp-Function-System.html#Installation)
      - [25.3 Functions](Zftp-Function-System.html#Zftp-Functions)
          - [25.3.1 Opening a
            connection](Zftp-Function-System.html#Opening-a-connection)
          - [25.3.2 Directory
            management](Zftp-Function-System.html#Directory-management)
          - [25.3.3 Status
            commands](Zftp-Function-System.html#Status-commands)
          - [25.3.4 Retrieving
            files](Zftp-Function-System.html#Retrieving-files)
          - [25.3.5 Sending
            files](Zftp-Function-System.html#Sending-files)
          - [25.3.6 Closing the
            connection](Zftp-Function-System.html#Closing-the-connection)
          - [25.3.7 Session
            management](Zftp-Function-System.html#Session-management)
          - [25.3.8 Bookmarks](Zftp-Function-System.html#Bookmarks)
          - [25.3.9 Other
            functions](Zftp-Function-System.html#Other-functions)
      - [25.4 Miscellaneous
        Features](Zftp-Function-System.html#Miscellaneous-Features)
          - [25.4.1
            Configuration](Zftp-Function-System.html#Configuration-3)
          - [25.4.2 Remote
            globbing](Zftp-Function-System.html#Remote-globbing)
          - [25.4.3 Automatic and temporary
            reopening](Zftp-Function-System.html#Automatic-and-temporary-reopening)
          - [25.4.4 Completion](Zftp-Function-System.html#Completion-3)
  - [26 User Contributions](User-Contributions.html#User-Contributions)
      - [26.1 Description](User-Contributions.html#Description-2)
      - [26.2 Utilities](User-Contributions.html#Utilities)
          - [26.2.1 Accessing On-Line
            Help](User-Contributions.html#Accessing-On_002dLine-Help)
          - [26.2.2 Recompiling
            Functions](User-Contributions.html#Recompiling-Functions)
          - [26.2.3 Keyboard
            Definition](User-Contributions.html#Keyboard-Definition)
          - [26.2.4 Dumping Shell
            State](User-Contributions.html#Dumping-Shell-State)
          - [26.2.5 Manipulating Hook
            Functions](User-Contributions.html#Manipulating-Hook-Functions)
      - [26.3 Remembering Recent
        Directories](User-Contributions.html#Recent-Directories)
          - [26.3.1
            Installation](User-Contributions.html#Installation-3)
          - [26.3.2 Use](User-Contributions.html#Use)
          - [26.3.3 Options](User-Contributions.html#Options-2)
          - [26.3.4
            Configuration](User-Contributions.html#Configuration-2)
          - [26.3.5 Use with dynamic directory
            naming](User-Contributions.html#Use-with-dynamic-directory-naming)
          - [26.3.6 Details of directory
            handling](User-Contributions.html#Details-of-directory-handling)
      - [26.4 Abbreviated dynamic references to
        directories](User-Contributions.html#Other-Directory-Functions)
          - [26.4.1 Usage](User-Contributions.html#Usage)
          - [26.4.2
            Configuration](User-Contributions.html#Configuration)
          - [26.4.3 Complete
            example](User-Contributions.html#Complete-example)
      - [26.5 Gathering information from version control
        systems](User-Contributions.html#Version-Control-Information)
          - [26.5.1
            Quickstart](User-Contributions.html#vcs_005finfo-Quickstart)
          - [26.5.2
            Configuration](User-Contributions.html#vcs_005finfo-Configuration)
          - [26.5.3
            Oddities](User-Contributions.html#vcs_005finfo-Oddities)
          - [26.5.4 Quilt
            Support](User-Contributions.html#vcs_005finfo-Quilt-Support)
          - [26.5.5 Function Descriptions (Public
            API)](User-Contributions.html#vcs_005finfo-API)
          - [26.5.6 Variable
            Description](User-Contributions.html#vcs_005finfo-Variables)
          - [26.5.7 Hooks in
            vcs\_info](User-Contributions.html#vcs_005finfo-Hooks)
          - [26.5.8
            Examples](User-Contributions.html#vcs_005finfo-Examples)
      - [26.6 Prompt Themes](User-Contributions.html#Prompt-Themes)
          - [26.6.1
            Installation](User-Contributions.html#Installation-2)
          - [26.6.2 Theme
            Selection](User-Contributions.html#Theme-Selection)
          - [26.6.3 Utility
            Themes](User-Contributions.html#Utility-Themes)
          - [26.6.4 Writing
            Themes](User-Contributions.html#Writing-Themes)
      - [26.7 ZLE Functions](User-Contributions.html#ZLE-Functions)
          - [26.7.1 Widgets](User-Contributions.html#Widgets)
          - [26.7.2 Utility
            Functions](User-Contributions.html#Utility-Functions)
          - [26.7.3 Styles](User-Contributions.html#Styles)
      - [26.8 Exception
        Handling](User-Contributions.html#Exception-Handling)
      - [26.9 MIME Functions](User-Contributions.html#MIME-Functions)
      - [26.10 Mathematical
        Functions](User-Contributions.html#Mathematical-Functions)
      - [26.11 User Configuration
        Functions](User-Contributions.html#User-Configuration-Functions)
      - [26.12 Other Functions](User-Contributions.html#Other-Functions)
          - [26.12.1 Descriptions](User-Contributions.html#Descriptions)
          - [26.12.2 Styles](User-Contributions.html#Styles-2)
  - [Concept Index](Concept-Index.html#Concept-Index)
  - [Variables Index](Variables-Index.html#Variables-Index)
  - [Options Index](Options-Index.html#Options-Index)
  - [Functions Index](Functions-Index.html#Functions-Index)
  - [Editor Functions
    Index](Editor-Functions-Index.html#Editor-Functions-Index)
  - [Style and Tag Index](Style-and-Tag-Index.html#Style-and-Tag-Index)

</div>

-----

This document was generated on *February 15, 2020* using
[*texi2html 5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.8, released on February 14, 2020.
