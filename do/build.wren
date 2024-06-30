#!/usr/bin/env wren

import "os" for Process
import "io" for File, Directory
import "scheduler" for Executor

// A script that builds the site

var rootdir = Process.cwd
var srcdir = "%(rootdir)/site"
var outdir = "%(rootdir)/built"

// Simple templating
// _header.html + page + _footer.html
class Templater {
  construct new(outdir) {
    _outdir = outdir
    _header = File.read("site/_header.html")
    _footer = File.read("site/_footer.html")
  }

  template(srcf) {
    var src = File.read(srcf)

    var page = "
    %(_header)
    %(src)
    %(_footer)
    "

    var dstf = "%(_outdir)/%(srcf)"
    File.write(dstf, page)
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
  Directory.mkdirs(outdir)
  Process.chdir(srcdir)

  for (f in files) {
    System.print(f)
    t.template(f)
  }

  // Copy in other files
  Process.spawn("rm -rf %(outdir)/browserconfig.xml %(outdir)/favicon.ico %(outdir)/assets".split(" "))
  Process.spawn("cp browserconfig.xml %(outdir)".split(" "))
  Process.spawn("cp favicon.ico %(outdir)".split(" "))
  Process.spawn("cp -r assets %(outdir)".split(" "))

  // All done
  System.print("ok")
}

var main = Fn.new { |args|
    if (args.count > 0 && args[0] == "loop") {
      var promises = []
      promises.add(Executor.async {
        Process.spawn(["wren", "do/serve.wren"], null, [null, 1, 2])
      })
      promises.add(Executor.async {
        Process.spawn(["notify", "-c", "wren do/build.wren", "site"], null, [null, 1, 2])
      })
      Executor.await(promises)
    } else {
      build.call()
    }
}
main.call(Process.arguments)
