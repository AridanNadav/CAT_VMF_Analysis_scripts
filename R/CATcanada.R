## logistic regression : 

rm(list = ls())
library(lme4)
library(lmerTest)
library(ggplot2)

DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_frontal_patients/results/CATcanadaLog04-Jan-2018.csv")    #set the path of your file   eva4choice_12_7_123.csv
CurrentData<-read.table(DataPath,header = TRUE, sep=',',na.strings = 999)#load data
CurrentData<-na.omit(CurrentData)
CurrentData$sample__1isControl_2isPatients<-as.factor(CurrentData$sample__1isControl_2isPatients)
CurrentData$sub<-as.factor(CurrentData$sub)
CurrentData$PairType<-as.factor(CurrentData$PairType)


gm1<-lmer(rt ~  PairType + (1|sub), data=(CurrentData[CurrentData$sample__1isControl_2isPatients==1,]), na.action=na.omit) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

gm1<-glmer(sample__1isControl_2isPatients ~ rt  +(1|sub), data=(CurrentData), na.action=na.omit, family=binomial) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

gm1<-glmer(outcome ~ sample__1isControl_2isPatients +(1|sub), data=(CurrentData), na.action=na.omit, family=binomial) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

gm1<-glmer(outcome ~ rt * sample__1isControl_2isPatients +(1|sub), data=(CurrentData), na.action=na.omit, family=binomial) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

cc <- confint(gm1,parm="beta_")  ## slow (~ 11 seconds)
ctab <- cbind(est=fixef(gm1),cc)
rtab <- exp(ctab)
print(rtab,digits=3)


confint(gm1, parm, level = 0.95,
        method = c("profile", "Wald", "boot"), zeta,
        nsim = 500,
        boot.type = c("perc","basic","norm"),
        FUN = NULL, quiet = FALSE,
        oldNames = TRUE, ...)
