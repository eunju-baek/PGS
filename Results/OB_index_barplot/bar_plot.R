## Save for settings of index names and ggplot.

library(ggplot2)

library(data.table)

f <- fread("ob_ratio_F.txt")

> f
        Index          NG          HR    Ratio
 1:    p48_i0  83.0000000  88.0000000 1.060241
 2:    p49_i0 102.0000000 106.0000000 1.039216
 3: p23099_i0  36.8000000  39.6000000 1.076087
 4: p23127_i0  34.5000000  37.3000000 1.081159
 5: p23123_i0  36.4000000  40.6000000 1.115385
 6: p23119_i0  35.5000000  39.6000000 1.115493
 7: p22408_i2   7.4143000   8.7297000 1.177414
 8: p22407_i2   2.3473000   2.7382000 1.166532
 9: p23115_i0  40.4000000  42.8000000 1.059406
10: p23111_i0  40.4000000  42.8000000 1.059406
11:       whr   0.8105263   0.8265306 1.019746

f$Index <- c('Waist circumference','Hip circumference','Body fat percentage','Trunk fat percentage','Arm fat percentage(L)','Arm fat percentage(R)','VAT','ASAT','Leg fat percentage(L)','Leg fat percentage(R)','WHR')
> f
                    Index          NG          HR    Ratio
 1:   Waist circumference  83.0000000  88.0000000 1.060241
 2:     Hip circumference 102.0000000 106.0000000 1.039216
 3:   Body fat percentage  36.8000000  39.6000000 1.076087
 4:  Trunk fat percentage  34.5000000  37.3000000 1.081159
 5: Arm fat percentage(L)  36.4000000  40.6000000 1.115385
 6: Arm fat percentage(R)  35.5000000  39.6000000 1.115493
 7:                   VAT   7.4143000   8.7297000 1.177414
 8:                  ASAT   2.3473000   2.7382000 1.166532
 9: Leg fat percentage(L)  40.4000000  42.8000000 1.059406
10: Leg fat percentage(R)  40.4000000  42.8000000 1.059406
11:                   WHR   0.8105263   0.8265306 1.019746
ggplot(f,aes(y=Index,x=Ratio,color=Index,fill=Index))+geom_bar(stat='identity',position='dodge',width = 0.5)+coord_cartesian(xlim=c(1.02,1.2))+theme(axis.text.x = element_text(size=30,angle=45,hjust=1,face='bold'),axis.text.y=element_text(face='bold'))+theme_bw()
