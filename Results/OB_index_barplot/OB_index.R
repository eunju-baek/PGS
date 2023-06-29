
#!/bin/R


args = commandArgs(trailingOnly = T)


Pattern  = args[1]

dir = getwd()
ll <- list.files(path = dir, pattern= Pattern)
ll2 <- ll[grep("Followup",ll,invert=T)]


NG <- ll2[grep("NG",ll2)]
HR <- ll2[grep("HR",ll2)]

print(NG)
print(HR)


library(data.table)

ng <- fread(NG)
hr <- fread(HR)

ob <- fread("ob_index.txt")

library(dplyr)

ng1 <- left_join(ng,ob,by='eid')
hr1 <- left_join(hr,ob,by='eid')

ng1 <- ng1 %>% mutate(whr = p48_i0/p49_i0)
hr1 <- hr1 %>% mutate(whr = p48_i0/p49_i0)


library(data.table)

ng <- fread(NG)
hr <- fread(HR)

ob <- fread("ob_index.txt")

library(dplyr)

ng1 <- left_join(ng,ob,by='eid')
hr1 <- left_join(hr,ob,by='eid')

ng1 <- ng1 %>% mutate(whr = p48_i0/p49_i0)
hr1 <- hr1 %>% mutate(whr = p48_i0/p49_i0)
