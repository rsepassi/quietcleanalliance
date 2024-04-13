#!/usr/bin/env wrensh

// A script that builds the site

var rootdir = IO.cwd()
var srcdir = "%(rootdir)/site"
var outdir = "%(rootdir)/built"

// Simple templating
// _header.html + page + _footer.html
class Templater {
  construct new(outdir) {
    _outdir = outdir
    _header = IO.run(["cat", "site/_header.html"])
    _footer = IO.run(["cat", "site/_footer.html"])
  }

  template(srcf) {
    var src = IO.run(["cat", srcf])

    var page = "
    %(_header)
    %(src)
    %(_footer)
    "

    var dstf = "%(_outdir)/%(srcf)"
    IO.run(["rm", "-f", dstf])
    IO.run(["touch", dstf])
    IO.Process(["echo", page]).stdout(dstf).run()
  }
}

// Template each of these files
var files = [
  "advisors.html",
  "contact.html",
  "index.html",
  "news.html",
  "resources.html",
  "supporters.html",
  "who-we-are.html",
]

var build = Fn.new {
  var t = Templater.new(outdir)
  // Setup output directories
  IO.run("mkdir -p %(outdir)")
  IO.chdir(srcdir)

  for (f in files) {
    System.print(f)
    t.template(f)
  }

  // Copy in other files
  IO.run("rm -rf %(outdir)/browserconfig.xml %(outdir)/favicon.ico %(outdir)/assets")
  IO.run("cp browserconfig.xml %(outdir)")
  IO.run("cp favicon.ico %(outdir)")
  IO.run("cp -r assets %(outdir)")

  // All done
  System.print("ok")
}

var main = Fn.new {
  var args = IO.args()
  var cmd = args.count > 2 ? args[2] : "build"
  if (cmd == "loop") {
    X.async(Fn.new {
      IO.run("./do/serve.wren")
    })
    IO.Process(["notify", "-c", "wrensh do/build.wren", "site"]).stdout(1).run()
  } else if (cmd == "build") {
    build.call()
  } else {
    System.print("unrecognized command %(cmd)")
    IO.exit(1)
  }
}

main.call()
