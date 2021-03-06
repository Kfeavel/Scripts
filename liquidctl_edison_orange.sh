#!/usr/bin/env bash
/usr/local/bin/liquidctl initialize all
# Set pumps and fan speeds
/usr/local/bin/liquidctl --match Kraken set pump speed 90
/usr/local/bin/liquidctl --match Kraken set fan speed 20 30  30 50  34 80  40 90  50 100
/usr/local/bin/liquidctl --match Smart set fan1 speed 90
/usr/local/bin/liquidctl --match Smart set fan2 speed 90
# Set LED colors
/usr/local/bin/liquidctl --match Kraken set logo color fixed ff7b00
/usr/local/bin/liquidctl --match Kraken set ring color covering-marquee ff5000 ff7b00 ff9000
/usr/local/bin/liquidctl --match Smart set led1 color fixed ff5000
/usr/local/bin/liquidctl --match Smart set led2 color fixed ff5000
