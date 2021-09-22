# zsh-manual-mdbook

[Zsh Manual](https://zsh-manual.netlify.app)

[Zsh User's Guide by Peter Stephenson](https://zsh-user-guide.netlify.app)

This is a markdown version of the [Zsh Manual](http://zsh.sourceforge.net/Doc/).
It is generated with a Bash script that removes some non-markdown-friendly
elements and converts the .html files to markdown using Pandoc. The SUMMARY.md
is generated with a Python script that scrapes the web page of the Zsh Manual's
table of contents.

The scripts contained in this repository are highly specialized for this
use-case and do not scale to anything else, but I've tried to make them as
abstract as possible, so they should work on anything with the same HTML
structure.

## Why not just use the plain old Zsh Manual?

An [mdbook](https://rust-lang.github.io/mdBook/) version is easier to browse and is more
aesthetically satisfying.

## Running/testing a local version

```bash
# Ensure mdbook is installed
cargo install mdbook

# Clone this repository
git clone https://github.com/hyperreal64/zsh-manual-mdbook

# Install Perl dependencies
# Ensure cpanminus is installed from your distro's repos
# e.g. sudo apt install cpanminus or sudo dnf install cpanminus
cd zsh-manual-mdbook
sudo cpanm Archive::Extract File::Basename HTTP::Simple IPC::Cmd Mojo::DOM Mojo::UserAgent

# Ensure DocToc is installed
sudo npm -g install doctoc

# Return to repository clone and run the make-mdbook script
./make-mdbook.pl

# Serve locally
cd zsh_manual/
mdbook serve
```
