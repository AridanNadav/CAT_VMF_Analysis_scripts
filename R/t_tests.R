rm(list = ls())
library(lme4)
library(lmerTest)
library(ggplot2)
library('TOSTER')
library(psych)
library(perm)




#load table
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_frontal_patients/results/CATcanadaSummary08-Jan-2018.csv")    #set the path of your file   eva4choice_12_7_123.csv
CATcanadaData<-read.table(DataPath,header = TRUE, sep=',',na.strings =NaN)#load data

#set categorial variables
rtGOorNO <- c(1, 2)
rtGOorNOfactor<- as.factor(rtGOorNO)
ageFrame <- data.frame(rtGOorNOfactor)
ageBind <- cbind(CATcanadaData$probe_choseGo_rt, CATcanadaData$probe_choseNoGo_rt )

CATcanadaData$sub<-as.factor(CATcanadaData$sub)
CATcanadaData$sample__1isControl_2isPatients<-as.factor(CATcanadaData$sample__1isControl_2isPatients)
CATcanadaData$sex__1isF__2isM<-as.factor(CATcanadaData$sex__1isF__2isM)

t.test(CATcanadaData[,"intransitivity_ratio"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"BRmRT"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"BRmRT"],CATcanadaData[,"BRmRTviol"],paired=TRUE)
t.test(CATcanadaData[,"NoGo_Sanity"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"recognitionNewOld"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"recognitionGoNoGo"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"probe__rt"]~CATcanadaData[,"sample__1isControl_2isPatients"])
t.test(CATcanadaData[,"RT_training"]~CATcanadaData[,"sample__1isControl_2isPatients"])

model<-(lm(chooseGOvsNoGo ~ probe_choseGo_rt*sample__1isControl_2isPatients  , data=CATcanadaData, na.action=na.omit) )     #[CATcanadaData$sample__1isControl_2isPatients==2,]
summary(model) 

paired=TRUE
BRmRT
BRmRTviol

wilcox.test(CATcanadaData[,"accuracy_SimpleCount_L1Out"]~CATcanadaData[,"sample__1isControl_2isPatients"])
wilcox.test(CATcanadaData[,"BR_RT"]~CATcanadaData[,"sample__1isControl_2isPatients"])
wilcox.test(CATcanadaData[,"chooseGOvsNoGo"]~CATcanadaData[,"sample__1isControl_2isPatients"]) 

permTS(


