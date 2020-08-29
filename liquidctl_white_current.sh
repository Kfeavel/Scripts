#!/bin/bash
/usr/local/bin/liquidctl initialize all
# Set pumps and fan speeds
/usr/local/bin/liquidctl --match Kraken set pump speed 100
/usr/local/bin/liquidctl --match Kraken set fan speed 40 80  45 90  50 100
/usr/local/bin/liquidctl --match Smart set fan1 speed 90
/usr/local/bin/liquidctl --match Smart set fan2 speed 90
# Set LED colors
/usr/local/bin/liquidctl --match Kraken set logo color fixed ffffff
/usr/local/bin/liquidctl --match Kraken set ring color covering-marquee ffffff 7e99b4 e1e7ee
/usr/local/bin/liquidctl --match Smart set led1 color fixed ffffff
/usr/local/bin/liquidctl --match Smart set led2 color fixed ffffff
