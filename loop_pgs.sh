#!/bin/bash/sh
#!usr/bin/python


for entry in /BiO/enju07/0_md/3_PGS/0_CAD/*.txt

do
python score.py ${entry}

done
