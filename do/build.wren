#!/usr/bin/env wrensh

// A script that builds the site

var rootdir = IO.cwd()
var srcdir = "%(rootdir)/site"
var outdir = "%(rootdir)/built"

var header = IO.run(["cat", "site/_header.html"])
var footer = IO.run(["cat", "site/_footer.html"])

// Simple templating
// _header.html + page + _footer.html
var template = Fn.new { |srcf|
  var src = IO.run(["cat", srcf])

  var page = "
  %(header)
  %(src)
  %(footer)
  "

  var dstf = "%(outdir)/%(srcf)"
  IO.run(["rm", "-f", dstf])
  IO.run(["touch", dstf])
  IO.Process(["echo", page]).stdout(dstf).run()
}

// Template each of these files
var files = [
  "advisors.html",
  "contact.html",
  "index.html",
  "news.html",
  "newsletter.html",
  "resources.html",
  "supporters.html",
  "who-we-are.html",
]

var build = Fn.new {
  // Setup output directories
  IO.run("rm -rf %(outdir)")
  IO.run("mkdir -p %(outdir)")
  IO.chdir(srcdir)

  for (f in files) {
    System.print(f)
    template.call(f)
  }

  // Copy in other files
  IO.run("cp browserconfig.xml %(outdir)")
  IO.run("cp favicon.ico %(outdir)")
  IO.run("cp -r assets %(outdir)")

  // All done
  System.print("ok")
}

build.call()
