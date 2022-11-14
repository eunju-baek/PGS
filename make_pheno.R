#!/usr/bin/R

args = commandArgs(trailingOnly= T)

Input = args[1]
case_name = args[2]
Pheno = args[3]


library(data.table)
library(dplyr)



pheno <- fread("/BiO/hae/phase2/phase3/phase4/phase5/55_fff/__Data_Extract/33_2nd_validation_set_v3.csv",data.table=F)
a <- fread(Input,data.table=F)

a <- data.frame(a[,1])

names(a) <- "eid"

a$case <- 1

names(a)[2] <- case_name

b <- left_join(pheno,a)

b[,26] <- data.frame(sapply(b[,26],function(x)ifelse(is.na(x),0,x)))

fwrite(b,Pheno,quote=F,sep='\t',row.names=F,na="NA")
