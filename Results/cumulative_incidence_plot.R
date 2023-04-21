
library(dplyr)
library(Hmisc)
library(ggplot2)


> mt <- m %>% filter(per10 != 'none') %>% group_by(per10,onset) %>% summarise(total = n()) %>% na.omit()


> mt <- mt %>% mutate(cum = cumsum(total))
> mt$est <-  as.data.frame(binconf(mt$cum,(18765+mt$cum),method='exact'))[1]
> mt$upper <-  as.data.frame(binconf(mt$cum,(18765+mt$cum),method='exact'))[3]
> mt$lower <-  as.data.frame(binconf(mt$cum,(18765+mt$cum),method='exact'))[2]



> ggplot(mt,aes(x=onset,y=est$PointEst,color=per10,fill=per10))+geom_step(size=1.5)+geom_ribbon(aes(ymin=lower$Lower,ymax = upper$Upper),alpha=.1,linetype=0)+theme_bw()+ylab("Incidence")+xlab("Onset age")+ylim(0,0.01)+theme(legend.position='none')
