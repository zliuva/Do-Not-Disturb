#!/bin/sh

ln -sf control.$1 control
ln -sf Makefile.$1 Makefile
unlink -f Themes
ln -sF Themes.$1 Themes

