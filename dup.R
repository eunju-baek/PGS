#!/usr/bin/R

argv = commandArgs(trailingOnly = T)

Input = argv[1]


library(data.table)
library(stringr)

name = str_split(Input,"/")[[1]][8]
name2 = str_split(name,'.score')[[1]][1]


a <- fread(Input,data.table=F)

dups <- unique(a[which(duplicated(a$rsID)),]$rsID)

if(length(dups)!=0){

        b <- a[ -which(a$rsID %in% dups),]

        fwrite(b,paste('nodup_',name2,'.txt',sep=""),row.names=F,na="NA",quote=F,sep='\t')

}else{
        fwrite(a,paste('nodup_',name2,'.txt',sep=""),row.names=F,na="NA",quote=F,sep='\t')
}
