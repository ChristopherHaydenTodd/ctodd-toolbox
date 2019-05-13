#!/bin/sh
ls | xargs -P10 -I{} git -C {} pull
