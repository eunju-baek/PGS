on <- function(x){
if(length(x)>1){
return(apply(x,1,min))}else{
return(x)}
}



ll <- list()
for(i in 1:nrow(a1)){
ll[[i]] <-  on(b1[i, grep(a1[i, ], pattern = paste(dc, collapse = "|"))])}


ll2 <- as.data.frame(ll)

id <- b1$eid
                     
rmind <-which(sapply(ll,function(x) inherits(x,"data.frame")))
id2 <- id[-rmind]
