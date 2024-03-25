#!/usr/bin/env wrensh

var auth = IO.env("AUTH")
var url = "https://api.netlify.com/api/v1/sites/quietcleanalliance.netlify.app/deploys"

if (auth == null) {
  System.print("error: must set AUTH=")
  IO.exit(1)
}

IO.run("rm -rf built")
IO.run(["wrensh", "./do/build.wren"])

IO.run("rm -f built.zip")
IO.run("bsdtar -c --format zip -f built.zip built")

System.print(IO.run([
  "curl",
  "-H", "Content-Type: application/zip",
  "-H", "Authorization: Bearer %(auth)",
  "--data-binary", "@built.zip",
  url
]))

IO.run("rm -f built.zip")

System.print("ok")
