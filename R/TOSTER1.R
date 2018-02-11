library('TOSTER')
TOSTtwo(m1=	0.50273017,	m2=	0.589208543	,sd1=	0.150944439	,sd2=	0.132608253	,	n1=	11,	n2=	30,	low_eqbound_d=	-0.5,	high_eqbound_d=	0.5,	alpha=	0.05)
TOSTtwo(m1=	0.954545455,	m2=	0.898214286	,sd1=	0.060130712,	sd2=	0.150759839	,	n1=	11,	n2=	30,	low_eqbound_d=	-0.5,	high_eqbound_d=	0.5,	alpha=	0.05)
TOSTtwo(m1=	0.946280992	,m2=	0.904924242	,sd1=	0.035305801	,sd2=	0.107183584	,	n1=	11,	n2=	30,	low_eqbound_d=	-0.5,	high_eqbound_d=	0.5,	alpha=	0.05)
TOSTtwo(m1=	0.56477528	,m2=	0.637586178	,sd1=	0.142439666	,sd2=	0.169998163	,	n1=	11,	n2=	30,	low_eqbound_d=	-0.5,	high_eqbound_d=	0.5,	alpha=	0.05)
TOSTtwo(m1=	0.227169697	,m2=	0.223502517	,sd1=	0.016637163	,sd2=	0.023421074	,	n1=	11,	n2=	30,	low_eqbound_d=	-0.5,	high_eqbound_d=	0.5,	alpha=	0.05)








dataTOSTone(data, vars, mu = 0, low_eqbound = -0.5, high_eqbound = 0.5,
            eqbound_type = "d", alpha = 0.05, desc = FALSE, plots = FALSE,
            low_eqbound_d = -999999999, high_eqbound_d = -999999999)


TOSTone(m=50.2730, mu=50, sd=15.8312, n=11, low_eqbound_d=-0.6, high_eqbound_d=0.6, alpha=0.05)




Data<-BinaryData[intersect(which(BinaryData$sample==3),which(BinaryData$BeforeORafter_training==2)),]

summary(glmer(Response ~ sample_z_D_LminR_RE+sample_z_delta_bid_raw+sample_z_D_LminR_PE2 + (1|subjectID),data=Data, na.action=na.omit, family=binomial)) 

