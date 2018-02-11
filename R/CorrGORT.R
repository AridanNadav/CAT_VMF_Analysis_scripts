library(lme4)
library(lmerTest)

rm(list = ls())

# BRdata
DataPath<-("/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_VMF/results/CATcanadaSummary14-Jan-2018.csv")    #set the path of your file   
CurrentData<-read.table(DataPath,header = TRUE, sep=',',na.strings = NaN)#load data
CurrentData$sub<-as.factor(CurrentData$sub)
CurrentData$sample__1isControl_2isPatients<-as.factor(CurrentData$sample__1isControl_2isPatients)
CurrentData$sex__1isF__2isM<-as.factor(CurrentData$sex__1isF__2isM)
# sub	sample__1isControl_2isPatients	sex__1isF__2isM	age	chooseGOvsNoGo	HighChooseGOvsNoGo	LowChooseGOvsNoGo	NoGo_Sanity	recognitionNewOld	recognitionGoNoGo	accuracy_Colley_L1Out	choice_indecisions	BRrRTnDRank	BRmRTnotViol	BRmRTall	BRmRTviol	probe_choseGo_rt_high	probe_choseNoGo_rt_high	probe_choseGo_rt_low	probe_choseNoGo_rt_low	probe_choseGo_rtSE	trainingRT	trainingRT_H	trainingRT_L	probe_choseGo_rt	probe_choseNoGo_rt	probe_rt_low	probe_rt_high	probe_rt_all	accuracy_SimpleCount_L1Out
gm1<-lm( chooseGOvsNoGo ~  probe_choseGo_rt+trainingRT  , data=(CurrentData[CurrentData$sample__1isControl_2isPatients==2,])) #[CurrentData$sample__1isControl_2isPatients==2,]
summary(gm1)

cor(CurrentData[CurrentData$sample__1isControl_2isPatients==2 ,"chooseGOvsNoGo"], CurrentData[CurrentData$sample__1isControl_2isPatients==2 ,"probe_choseGo_rt"]) 
