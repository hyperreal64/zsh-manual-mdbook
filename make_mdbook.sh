#!/usr/bin/env bash

set -euxo pipefail

_zsh_html_url="http://zsh.sourceforge.net/Doc/zsh_html.tar.gz"
_zsh_doc_tmp_dir="${HOME}/zsh_doc_tmp"
_zsh_html_src_dir="${_zsh_doc_tmp_dir}/zsh_html"
_zsh_md_src_dir="${_zsh_doc_tmp_dir}/zsh_md"
_mdbook_src_dir="${_zsh_doc_tmp_dir}/mdbook_src"

# Ensure zsh_doc_tmp directories exist
rm -rf "${_zsh_doc_tmp_dir}"
for dir in "${_zsh_html_src_dir}" "${_zsh_md_src_dir}" "${_mdbook_src_dir}"; do
  if ! [ -d "$dir" ]; then
    mkdir -p "$dir"
  fi
done

# Download and extract zsh_html.tar.gz to zsh_doc_tmp_dir
wget "${_zsh_html_url}" -O "${_zsh_doc_tmp_dir}/zsh_html.tar.gz"
tar xzf "${_zsh_doc_tmp_dir}/zsh_html.tar.gz" -C "${_zsh_doc_tmp_dir}"

# For some reason, extra files are added to the archive that
# have no content besides aliases to pages that do.
# They are all less than 4k, and they are just clutter for mdbook,
# so we remove them here, along with the Index pages.
find "${_zsh_html_src_dir}" -name "*.html" -type 'f' -size -4k -delete
find "${_zsh_html_src_dir}" -name "*-Index.html" -type 'f' -delete
find "${_zsh_html_src_dir}" -name "zsh_*.html" -type 'f' -delete

# Remove html noise
for file in "${_zsh_html_src_dir}"/*.html; do
  sed -i '/table/d' "$file"
  sed -i '/span/d' "$file"
  sed -i '/valign/d' "$file"
  sed -i '/\[\]{#/d' "$file"
done

# Convert html to md with pandoc
for file in "${_zsh_html_src_dir}"/*.html; do
  pandoc "$file" -f html -t gfm -o "${_mdbook_src_dir}/$(basename -- "$file" .html).md";
done

# Generate TOC with doctoc
doctoc "${_mdbook_src_dir}"/*.md

# Generate SUMMARY.md from zsh_toc.html
python3 "${PWD}/gen_summ_manual.py" > "${_mdbook_src_dir}/SUMMARY.md"

# Copy md files to mdbook src
# First ensure the src directory is empty
rm -rf "${PWD}/zsh_manual/src"
mkdir "${PWD}/zsh_manual/src"
cp -rf "${_mdbook_src_dir}"/* "${PWD}/zsh_manual/src/"

# Cleanup zsh_doc_tmp
rm -rf "${_zsh_doc_tmp_dir}"
