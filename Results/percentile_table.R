#!/usr/bin/R


args = commandArgs(trailingOnly = T)

library(data.table)
library(dplyr)
library(reshape2)

dir = getwd()

ll <- list.files(path = dir , pattern ="360K")
print(ll)

for(i in 1:length(ll)){
	assign(paste0("a",i),fread(ll[i]))
}


# Make percentile score label

label  <- function(x){
	x <-x %>% mutate(per = ntile(SCORESUM,100))
	min <- x %>% group_by(per) %>% summarise(min = format(round(min(SCORESUM),4)))
	return(min)
}



for(i in 1:length(ll)){
	assign(paste0("b",i),label(get(paste0("a",i))))
	print(head(get(paste0("b",i))))
	b1 <- left_join(b1,get(paste0("b",i)))
	names(b1)[2:ncol(b1)] <- ll
	b1 <- data.frame(b1)
	


}

fwrite(b1,'table.txt',quote=F,sep='\t',row.names=F,na="NA")
