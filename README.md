# zsh-manual-mdbook

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

# Install Python dependencies
cd zsh-manual-mdbook
pip install -r requirements.txt

# Initialize an mdbook project at (e.g.) ~/zsh-mdbook
mdbook init ~/zsh-mdbook

# Remove sample items from mdbook src
cd ~/zsh-mdbook/src
rm *.md

# Return to repository clone and run the make-mdbook script
./make-mdbook.sh

# Copy items to mdbook src
cp -rf ~/zsh_doc_tmp/mdbook_src/* ~/zsh-mdbook/src/
```