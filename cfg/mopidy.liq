#!/usr/bin/liquidsoap
set("log.file.path", "/dev/null")
set("log.stdout", true)
set("server.telnet", false)
set("harbor.bind_addr","0.0.0.0")
set("frame.duration",0.04)
set("root.max_latency",60.)

live = mksafe(input.udp(host="127.0.0.1", port=5004, "audio/mpeg"))
output.harbor(%mp3(bitrate=192), port=8800, mount="/mopidy", live)
