#!/usr/bin/env wren

import "os" for Process

var auth = Process.env("AUTH")
var url = "https://api.netlify.com/api/v1/sites/quietcleanalliance.netlify.app/deploys"

if (auth == null) {
  System.print("error: must set AUTH=")
  Process.exit(1)
}

Process.spawn("rm -rf built".split(" "))
Process.spawn(["wren", "./do/build.wren"])

Process.spawn("rm -f built.zip".split(" "))
Process.spawn("bsdtar -c --format zip -f built.zip built".split(" "))

Process.spawn([
  "curl",
  "-H", "Content-Type: application/zip",
  "-H", "Authorization: Bearer %(auth)",
  "--data-binary", "@built.zip",
  url
], null, [null, 1, 2])

Process.spawn("rm -f built.zip".split(" "))

System.print("ok")
