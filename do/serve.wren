#!/usr/bin/env wren

import "os" for Process

Process.chdir("built")
Process.spawn(["python3", "-m", "http.server"], null, [null, 1, 2])
