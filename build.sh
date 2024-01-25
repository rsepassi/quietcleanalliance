#!/bin/sh

set -e

rootdir=$PWD
srcdir=$rootdir/site
outdir=$rootdir/public

# Setup output directories
rm -rf $outdir
mkdir -p $outdir $outdir/bios $outdir/icon

# Simple templating
# _header.html + page + _footer.html
template() {
  src=$1
  dst=$outdir/$src

  echo > $dst
  cat _header.html >> $dst
  cat $src >> $dst
  cat _footer.html >> $dst
}

cd $srcdir

# Template each of these files
files="
index.html
about.html
resources.html
news.html
allies.html
contact.html
newsletter.html
bios/jeff.html
bios/chuck.html
bios/james.html
bios/lucy.html
bios/patti.html
"
for f in $files
do 
  echo $f
  template $f
done

# Copy in other files
cp icon/* $outdir/icon/
cp browserconfig.xml $outdir/
cp favicon.ico $outdir/
cp simple-grid.css $outdir/

# All done
echo ok
