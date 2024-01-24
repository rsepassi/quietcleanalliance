#!/bin/sh

set -e

rootdir=$PWD
srcdir=$rootdir/site
outdir=$rootdir/public

rm -rf $outdir
mkdir -p $outdir

template() {
  src=$1
  dst=$outdir/$src

	mkdir -p $(dirname $dst)
  echo > $dst
  cat _header.html >> $dst
  cat $src >> $dst
  cat _footer.html >> $dst
}

cd $srcdir

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

# Icons
mkdir -p $outdir/icon
cp icon/* $outdir/icon/
cp browserconfig.xml $outdir/
cp favicon.ico $outdir/

echo ok
