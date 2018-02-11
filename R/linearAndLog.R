library(lme4)
library(lmerTest)

rm(list = ls())

# BRdata
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_VMF/results/CATcanadaBRdata14-Jan-2018.csv")    #set the path of your file   
CurrentData<-read.table(DataPath,header = TRUE, sep=',',na.strings = NaN)#load data
CurrentData<-na.omit(CurrentData)
CurrentData$sample__1isControl_2isPatients<-as.factor(CurrentData$sample__1isControl_2isPatients)
CurrentData$sub<-as.factor(CurrentData$sub)
CurrentData$isCorrect_ColleyL1out<-as.factor(CurrentData$isCorrect_ColleyL1out)
CurrentData$IsViolation<-as.factor(CurrentData$IsViolation)

gm1<-lmer(RT ~  Drank*sample__1isControl_2isPatients + (1|sub), data=(CurrentData)) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

gm1<-lmer(RT ~  Drank + (1|sub), data=(CurrentData[CurrentData$sample__1isControl_2isPatients==2,])) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

gm1<-glmer(IsViolation ~ sample__1isControl_2isPatients  +(1|sub), data=(CurrentData), na.action=na.omit, family=binomial) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)




# ProbeData
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_frontal_patients/results/CATcanadaProbeData10-Jan-2018.csv")    #set the path of your file   
CurrentData<-read.table(DataPath,header = TRUE, sep=',',na.strings = NaN)#load data
CurrentData<-na.omit(CurrentData)

# CATcanadaTrainingData10-Jan-2018.csv
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_frontal_patients/results/CATcanadaTrainingData10-Jan-2018.csv")    #set the path of your file   
CurrentData<-read.table(DataPath,header = TRUE, sep=',',na.strings = NaN)#load data
CurrentData<-na.omit(CurrentData)







