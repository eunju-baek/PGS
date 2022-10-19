#!/bin/bash/sh
#!usr/bin/python


for FILE in `ls *.txt`
do
        python score.py $FILE
done
