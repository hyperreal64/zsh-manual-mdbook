<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [10 Jobs & Signals](#10-jobs--signals)
  - [10.1 Jobs](#101-jobs)
  - [10.2 Signals](#102-signals)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<span id="Jobs-_0026-Signals"></span> <span
id="Jobs-_0026-Signals-1"></span>

# 10 Jobs & Signals

------------------------------------------------------------------------

<span id="Jobs"></span>

## 10.1 Jobs

<span id="index-jobs"></span> <span
id="index-MONITOR_002c-use-of"></span>

If the MONITOR option is set, an interactive shell associates a *job*
with each pipeline. command, and assigns them small integer numbers.
When a job is started asynchronously with ‘&’, the shell prints a line
to standard error which looks like:

<div class="example">

```zsh
[1] 1234
```

</div>

indicating that the job which was started asynchronously was job number
1 and had one (top-level) process, whose process ID was 1234.

If a job is started with ‘&\|’ or ‘&!’, then that job is immediately
disowned. After startup, it to the job control features described here.

If you are running a job and wish to do something else you may hit the
key ^Z (control-Z) which sends a TSTP signal to the current job: this
key may be redefined by the susp option of the external stty command.
<span id="index-jobs_002c-suspending"></span> <span
id="index-suspending-jobs"></span> The shell will then normally indicate
that the job has been ‘suspended’, and print another prompt. You can
then manipulate the state of this job, <span
id="index-bg_002c-use-of"></span> putting it in the background with the
bg command, or run some other commands and then eventually bring the job
back into the foreground with <span id="index-fg_002c-use-of"></span>
the foreground command fg. A ^Z takes effect immediately and is like an
interrupt in that pending output and unread input are discarded when it
is typed.

A job being run in the background will suspend if it tries to read from
the terminal.

Note that if the job running in the foreground is a shell function, then
suspending it will have the effect of causing the shell to fork. This is
necessary to separate the function’s state from that of the parent shell
performing the job control, so that the latter can return to the command
line prompt. As a result, even if fg is used to continue the job the
function will no longer be part of the parent shell, and any variables
set by the function will not be visible in the parent shell. Thus the
behaviour is different from the case where the function was never
suspended. Zsh is different from many other shells in this regard.

One additional side effect is that use of disown with a job created by
suspending shell code in this fashion is delayed: the job can only be
disowned once any process started from the parent shell has terminated.
At that point, the disowned job disappears silently from the job list.

The same behaviour is found when the shell is executing code as the
right hand side of a pipeline or any complex shell construct such as if,
for, etc., in order that the entire block of code can be managed as a
single job. <span id="index-background-jobs_002c-I_002fO"></span> <span
id="index-jobs_002c-background_002c-I_002fO"></span> Background jobs are
normally allowed to produce output, but this can be disabled by giving
the command ‘stty tostop’. If you set this tty option, then background
jobs will suspend when they try to produce output like they do when they
try to read input.

When a command is suspended and continued later with the fg or wait
builtins, zsh restores tty modes that were in effect when it was
suspended. This (intentionally) does not apply if the command is
continued via ‘kill -CONT’, nor when it is continued with bg.

<span id="index-jobs_002c-referring-to"></span> <span
id="index-referring-to-jobs"></span>

There are several ways to refer to jobs in the shell. A job can be
referred to by the process ID of any process of the job or by one of the
following:

%`number`  
The job with the given number.

%`string`  
The last job whose command line begins with `string`.

%?`string`  
The last job whose command line contains `string`.

%%  
Current job.

%+  
Equivalent to ‘%%’.

%-  
Previous job.

The shell learns immediately whenever a process changes state. <span
id="index-NOTIFY_002c-use-of"></span> It normally informs you whenever a
job becomes blocked so that no further progress is possible. If the
NOTIFY option is not set, it waits until just before it prints a prompt
before it informs you. All such notifications are sent directly to the
terminal, not to the standard output or standard error.

When the monitor mode is on, each background job that completes triggers
any trap set for CHLD.

When you try to leave the shell while jobs are running or suspended, you
will be warned that ‘You have suspended (running) jobs’. You may use the
jobs command to see what they are. If you do this or immediately try to
exit again, the shell will not warn you a second time; the suspended
jobs will be terminated, and the running jobs will be sent a SIGHUP
signal, if the HUP option is set. <span
id="index-HUP_002c-use-of"></span>

<span id="index-jobs_002c-disowning"></span> <span
id="index-disowning-jobs"></span> <span
id="index-disown_002c-use-of"></span>

To avoid having the shell terminate the running jobs, either use the
nohup(1) command or the disown builtin.

------------------------------------------------------------------------

<span id="Signals"></span>

## 10.2 Signals

The INT and QUIT signals for an invoked command are ignored if the
command is followed by ‘&’ and the MONITOR option is not active. The
shell itself always ignores the QUIT signal. Otherwise, signals have the
values inherited by the shell from its parent (but see the TRAP`NAL`
special functions in [Functions](Functions.html#Functions)).

<span id="index-exiting-shell_002c-and-asynchronous-jobs"></span> <span
id="index-asynchronous-jobs_002c-and-exiting-shell"></span> <span
id="index-jobs_002c-asynchronous_002c-and-exiting-shell"></span>

Certain jobs are run asynchronously by the shell other than those
explicitly put into the background; even in cases where the shell would
usually wait for such jobs, an explicit exit command or exit due to the
option ERR_EXIT will cause the shell to exit without waiting. Examples
of such asynchronous jobs are process substitution, see [Process
Substitution](Expansion.html#Process-Substitution), and the handler
processes for multios, see the section *Multios* in
[Redirection](Redirection.html#Redirection).

------------------------------------------------------------------------

This document was generated on *May 14, 2022* using [*texi2html
5.0*](http://www.nongnu.org/texi2html/).  
Zsh version 5.9, released on May 14, 2022.
