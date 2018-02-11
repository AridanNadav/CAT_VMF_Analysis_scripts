
rm(list = ls())
library(Deducer)
library(jmuOutlier)
  
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_frontal_patients/results/CATcanadaSummary14-Jan-2018.csv")    #set the path of your file   eva4choice_12_7_123.csv
CATcanadaData<-read.table(DataPath,header = TRUE, sep=',',na.strings =NaN)#load data


CATcanadaData$dBR_RT=CATcanadaData$BRmRTnotViol-CATcanadaData$BRmRTviol

CATcanadaData$dProbe_RT=CATcanadaData$probe_rt_high-CATcanadaData$probe_rt_low



CATcanadaData$sub<-as.factor(CATcanadaData$sub)
CATcanadaData$sample__1isControl_2isPatients<-as.factor(CATcanadaData$sample__1isControl_2isPatients)
CATcanadaData$sex__1isF__2isM<-as.factor(CATcanadaData$sex__1isF__2isM)

set.seed(1, kind = NULL, normal.kind = NULL)

# sub	sample__1isControl_2isPatients	sex__1isF__2isM	age	chooseGOvsNoGo	HighChooseGOvsNoGo	LowChooseGOvsNoGo	NoGo_Sanity	
# recognitionNewOld	recognitionGoNoGo	accuracy_Colley_L1Out	choice_indecisions	BRrRTnDRank	BRmRTnotViol    BRmRTall    BRmRTviol 	probe_choseGo_rt_high	
# probe_choseNoGo_rt_high	probe_choseGo_rt_low	probe_choseNoGo_rt_low	probe_choseGo_rtSE	trainingRT	accuracy_SimpleCount_L1Out
# probe_choseGo_rt	probe_choseNoGo_rt	probe_rt_low	probe_rt_high	probe_rt_all
#accuracy_Colley_L1Out
#BRmRTall
# BRmRTnotViol  BRmRTviol

# NoGo_Sanity
#	probe_choseGo_rt_high	probe_choseNoGo_rt_high	probe_choseGo_rt_low	probe_choseNoGo_rt_low
# probe_choseGo_rt,probe_choseNoGo_rt,probe_rt_low,probe_rt_high
set.seed(1, kind = NULL, normal.kind = NULL)
CATcanadaData$dBR_RT
control<-CATcanadaData[CATcanadaData$sample__1isControl_2isPatients==1,"dBR_RT"]
VMF<-CATcanadaData[CATcanadaData$sample__1isControl_2isPatients==2 ,"dBR_RT"]

control<-CATcanadaData[,"probe_choseGo_rt"]
VMF<-CATcanadaData[,"probe_choseNoGo_rt"]

perm.t.test(control, VMF,statistic=c("t","mean"), alternative= "two.sided", B=10000)
mean(control)
mean(VMF)

mean(control)-mean(VMF)

t.test(CATcanadaData[CATcanadaData$sample__1isControl_2isPatients==1 ,"BRrRTnDRank"],  mu = 0)

