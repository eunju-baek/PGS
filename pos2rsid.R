#!/usr/bin/R

args = commandArgs(trailingOnly = T)

Input = args[1]

library(stringr)
library(data.table)
library(dplyr)

dir = getwd()


bim  <- fread("/BiO/00_original_data/2_2019_UK_biobank/download_imputation/binary_convert_no_QC/all_bim.txt",data.table=F)

bim['position'] <- paste(bim$V1,bim$V4,sep=":")

ll <- list.files(path = dir , pattern = "pos_")

for(i in ll){

	name = str_split(i,"\\.")[[1]][1]
	name2 = str_split(name,"_")[[1]][2]

	a <- fread(i,data.table=F)
	b <- left_join(a,bim,by='position')
	c <- b[,c("V2","effect_allele","effect_weight")]
	names(c)[1] <- "rsID"
	fwrite(c,paste("rsID_",name2,".txt",sep=''),quote=F,sep='\t',row.names=F,na="NA")
