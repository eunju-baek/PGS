#!/usr/bin/R

argv = commandArgs(trailingOnly = TRUE)

Input = argv[1]
Pheno = argv[2]


library(data.table)
library(stringr)
library(dplyr)
library(fmsb)

name = str_split(Input,pattern='\\.')[[1]][1]
name2 = str_split(name,pattern='_')[[1]][2]


a <- fread(Input,data.table=F)

for(i in 2:22){
	input <- paste0('nodup_',name2,'.txt.',i,'.profile')
	d <- fread(input,data.table=F)
	d2 <- data.frame(d$SCORESUM)
	names.input <- paste0(name2,'_chr',i)
	names(d2) <- names.input
	a <- cbind(a,d2)}

names(a)[6] <- paste0(name2,"_chr1")

a$score <- rowSums(a[,6:27])
a <- a[,c(1,28)]

pheno <- fread(Pheno,data.table=F)

p1 <- left_join(pheno,a,by="FID")
p1 <- p1 %>% mutate(st_score = scale(score)) 
p1 <- p1 %>% mutate(per = ntile(score,100))
p1 <- p1 %>% mutate(per1 = ifelse(per>99,'per1',ifelse(per>=40&per<60,"per40-60","none")))
p1 <- p1 %>% mutate(per3 = ifelse(per>97,'per3',ifelse(per>=40&per<60,"per40-60","none")))
p1 <- p1 %>% mutate(per5 = ifelse(per>95,'per5',ifelse(per>=40&per<60,"per40-60","none")))
p1 <- p1 %>% mutate(per10 = ifelse(per>90,'per10',ifelse(per>=40&per<60,"per40-60","none")))



per1 <- p1[p1$per1 !='none',]
per3 <- p1[p1$per3 !='none',]
per5 <- p1[p1$per5 !='none',]
per10 <- p1[p1$per10 !='none',]


mt0 <- glm(T2D ~ st_score +X31.0.0+X21022.0.0+X22009.0.1+X22009.0.2+X22009.0.3+X22009.0.4+X22009.0.5+X22009.0.6+X22009.0.7+X22009.0.8+X22009.0.9+X22009.0.10+array,data=p1,family = binomial)
mt1 <- glm(T2D ~ per1 +X31.0.0+X21022.0.0+X22009.0.1+X22009.0.2+X22009.0.3+X22009.0.4+X22009.0.5+X22009.0.6+X22009.0.7+X22009.0.8+X22009.0.9+X22009.0.10+array,data=per1,family = binomial)
mt3 <- glm(T2D ~ per3 +X31.0.0+X21022.0.0+X22009.0.1+X22009.0.2+X22009.0.3+X22009.0.4+X22009.0.5+X22009.0.6+X22009.0.7+X22009.0.8+X22009.0.9+X22009.0.10+array,data=per3,family = binomial)
mt5 <- glm(T2D ~ per5 +X31.0.0+X21022.0.0+X22009.0.1+X22009.0.2+X22009.0.3+X22009.0.4+X22009.0.5+X22009.0.6+X22009.0.7+X22009.0.8+X22009.0.9+X22009.0.10+array,data=per5,family = binomial)
mt10 <- glm(T2D ~ per10 +X31.0.0+X21022.0.0+X22009.0.1+X22009.0.2+X22009.0.3+X22009.0.4+X22009.0.5+X22009.0.6+X22009.0.7+X22009.0.8+X22009.0.9+X22009.0.10+array,data=per10,family = binomial)


sum0 <- NagelkerkeR2(mt0)
sum1 <- NagelkerkeR2(mt1)
sum3 <- NagelkerkeR2(mt3)
sum5 <- NagelkerkeR2(mt5)
sum10 <- NagelkerkeR2(mt10)

seq <- c(0,1,3,5,10)
summat <- matrix(nrow = 5,ncol=6)

for(i in seq){
	summat[which(seq == i),1:4] <- summary(get(paste0("mt",i)))$coef[2,1:4]
	summat[which(seq == i),5] <- get(paste0("sum",i))[[1]]
	summat[which(seq == i),6] <- get(paste0("sum",i))[[2]]
}

summat <- data.frame(summat)
rownames(summat) <- c("st_score","per1","per3","per5","per10")
colnames(summat) <- c("Beta","SE","Z","P","N","NagelkerkeR2")

fwrite(p1,paste('pheno_',name2,'.txt',sep=''),sep="\t",row.names=F,na="NA",quote=F)
fwrite(summat,paste('results_',name2,'.txt',sep=""),sep='\t',quote=F,row.names=T)
