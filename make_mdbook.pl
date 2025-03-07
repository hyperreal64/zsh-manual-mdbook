#!/usr/bin/env perl

use strict;
use warnings;

use Archive::Extract;
use Cwd;
use File::Basename;
use HTTP::Simple;
use IPC::Cmd qw[can_run run_forked];
use Mojo::DOM;
use Mojo::UserAgent;

# Check for dependencies, exit with error if not available
can_run("pandoc") or die "pandoc command not found";
can_run("doctoc") or die "doctoc command not found";

my $zsh_html_url     = "http://zsh.sourceforge.net/Doc/zsh_html.tar.gz";
my $zsh_doc_tmp_dir  = $ENV{'HOME'} . "/zsh_doc_tmp";
my $zsh_html_src_dir = $zsh_doc_tmp_dir . "/zsh_html";
my $mdbook_src_dir   = $zsh_doc_tmp_dir . "/mdbook_src";

# Ensure fresh tmp directories exist
system("rm -rf $zsh_doc_tmp_dir") == 0 or die "$?";
mkdir($zsh_doc_tmp_dir)                or die "$?";
mkdir($zsh_html_src_dir)               or die "$?";
mkdir($mdbook_src_dir)                 or die "$?";

# Download, extract zsh_html.tar.gz to zsh_doc_tmp_dir
my $dest   = "$zsh_doc_tmp_dir/zsh_html.tar.gz";
my $status = getstore( $zsh_html_url, $dest )
  or die "Error in fetching or storing $zsh_html_url: $?";

my $ae = Archive::Extract->new( archive => $dest );
my $ok = $ae->extract( to => $zsh_doc_tmp_dir )
  or die $ae->error;

# Extra files are added to the archive that have no content besides aliases to
# pages that do. They are all less than 4k, and they are just clutter for mdbook, so
# we remove them here along with the Index pages.
my @files = <$zsh_html_src_dir/*.html>;

foreach my $file (@files) {
    unlink $file if ( -s $file < 4000 );

    my $bname = qx(basename $file);
    unlink $file if ( $bname =~ /-Index/ );
    unlink $file if ( $bname =~ /^zsh_[\w]+/ );
}

# Remove HTML noise
@files = <$zsh_html_src_dir/*.html>;
foreach my $file (@files) {
    system("perl -i -ne 'print unless m/valign/' $file") == 0 or die "$?";
    system("perl -i -ne 'print unless m/table/' $file") == 0  or die "$?";
}

# Convert html to md with pandoc
foreach my $file (@files) {
    my $basename   = basename( $file, ".html" );
    my @pandoc_cmd = (
        "pandoc", "$file", "-f", "html", "-t", "gfm", "-o",
        "$mdbook_src_dir/$basename.md"
    );

    system(@pandoc_cmd) == 0 or die "system @pandoc_cmd failed: $?";
}

# Rename Jobs-_0026-Signals.md to Jobs-&-Signals.md
rename(
    "$mdbook_src_dir/Jobs-_0026-Signals.md",
    "$mdbook_src_dir/Jobs-&-Signals.md"
) or die "$?";

# Generate TOC with doctoc
my $result = run_forked("doctoc $mdbook_src_dir/");
print $result->{'stdout'} if ( $result->{'exit_code'} == 0 );
print $result->{'stderr'} if ( $result->{'exit_code'} != 0 );

# Generate SUMMARY.md from table of contents
my $ua = Mojo::UserAgent->new;

my $dom =
  $ua->get("https://zsh.sourceforge.io/Doc/Release/zsh_toc.html")->res->dom;

my $summary_file = "$mdbook_src_dir/SUMMARY.md";
open( FH, ">", $summary_file ) or die $?;
print FH "# Summary\n\n";

my @toc = $dom->find('a')->map('text')->each;
foreach my $toc (@toc) {
    if ( $toc =~ /(?<![\d.])[0-9]+(?![\d.])/ ) {
        my $line = "$toc\n";
        $line =~ s/\d+//;
        $line =~ s/^\s+|\s+$//g;
        my $title = $line;
        $line =~ s/\s+/-/g;
        print FH "- [$title](./$line.md)\n";
    }
}
close(FH);

# Copy md files to zsh manual mdbook src
# First ensure it is empty
my $cwd = getcwd();
system("rm -rf $cwd/zsh-manual/src") == 0                or die "$?";
mkdir("$cwd/zsh-manual/src")                             or die "$?";
system("cp $mdbook_src_dir/* $cwd/zsh-manual/src/") == 0 or die "$?";

# Replace ``` example with ```zsh for syntax highlighting
@files = <$cwd/zsh-manual/src/*.md>;
foreach my $file (@files) {
    system("sed -i 's/``` example/```zsh/g' '$file'") == 0 or die "$?";
}

# Cleanup zsh_doc_tmp
system("rm -rf $zsh_doc_tmp_dir") == 0 or die "$?";
