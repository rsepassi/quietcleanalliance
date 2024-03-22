#!/bin/sh

set -e

# A shell script that builds the site
# Requires rm, mkdir, cat, cp

cmd=${1:-build}

rootdir=$PWD
srcdir=$rootdir/site
outdir=$rootdir/built

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

# Template each of these files
files="
advisors.html
contact.html
index.html
news.html
newsletter.html
resources.html
supporters.html
who-we-are.html
"

dobuild() {
  # Setup output directories
  rm -rf $outdir
  mkdir -p $outdir
  cd $srcdir

  for f in $files
  do 
    echo $f
    template $f
  done

  # Copy in other files
  cp browserconfig.xml $outdir/
  cp favicon.ico $outdir/
  cp -r assets $outdir/

  # All done
  echo ok
}

watchfiles() {
  echo build.sh
  find site -type f | grep -v swp
}

case $cmd in
  build)
    dobuild
    ;;
  loop)
    watchfiles | entr ./build.sh
    ;;
  *)
    echo "unrecognized cmd $cmd"
    exit 1
    ;;
esac
