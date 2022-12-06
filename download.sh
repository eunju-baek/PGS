#!/bin/bash

a="PGS003091	PGS003090	PGS003119	PGS003114	PGS003118	PGS003101	PGS003094	PGS003109	PGS003100	PGS003116
"

link1="https://ftp.ebi.ac.uk/pub/databases/spot/pgs/scores/"
link2="/ScoringFiles/"
link3=".txt.gz"

for i in $a
do
	l="${link1}$i${link2}$i${link3}"
	`wget ${l}`
done
