% Final graphs

%% Import data from csv file.
filename = '/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_VMF/results/CATcanadaSummary08-Feb-2018.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
DataTable = table(dataArray{1:end-1}, 'VariableNames', {'sub','sample__1isControl_2isPatients','sex__1isF__2isM','age','chooseGOvsNoGo','HighChooseGOvsNoGo','LowChooseGOvsNoGo','NoGo_Sanity','recognitionNewOld','recognitionGoNoGo','accuracy_Colley_L1Out','choice_indecisions','BRrRTnDRank','BRmRTnotViol','BRmRTall','BRmRTviol','probe_choseGo_rt_high','probe_choseNoGo_rt_high','probe_choseGo_rt_low','probe_choseNoGo_rt_low','probe_choseGo_rtSE','trainingRT','trainingRT_H','trainingRT_L','probe_choseGo_rt','probe_choseNoGo_rt','probe_rt_low','probe_rt_high','probe_rt_all','accuracy_SimpleCount_L1Out','training_image_RT','training_image_RT_H','training_image_RT_L','training_cue_RT','training_cue_RT_H','training_cue_RT_L'});
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%%
gray=[.5 .5 .5];
resultsfold='/Users/papanadipapanadi/Google Drive/Nadav/Tel_Aviv_University/Tom_LAB/Experiments/CAT_VMF/results/Figs/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                BR                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% accuracy_Colley_L1Out
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'accuracy_Colley_L1Out'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'accuracy_Colley_L1Out'};

bar(0.5,mean(conrolData),'FaceColor',gray,'EdgeColor','k','LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor','w','EdgeColor','k','LineWidth',2)

errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes
ax.YLim = [0 1.10]
ax.XTick = [0.5 ,1.5 ];

ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt='Figure 3. Choice consistency during binary ranking';
title(titletxt,'FontSize',16)
ylabel('Correct prediction ratio','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% reaction time during binary choices
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'BRmRTall'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'BRmRTall'};

bar(0.5,mean(conrolData),'FaceColor',gray,'EdgeColor','k','LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor','w','EdgeColor','k','LineWidth',2)

errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes


ax.XTick = [0.5 ,1.5 ];

ax.YLim = [0 1600]
ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt='Figure 4. Reaction time during binary choices';
title(titletxt,'FontSize',16)
ylabel('RT (ms) ','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% reaction time transitive and intransitive choices
% h=figure
% hold on
% 
% conrolData=DataTable{:,'BRmRTnotViol'};
% patientsData=DataTable{:,'BRmRTviol'};
% 
% bar(0.5,mean(conrolData),'FaceColor',[0.75 0.75 0.75],'EdgeColor',[0 0 0],'LineWidth',2)
% bar(1.5,mean(patientsData),'FaceColor',[0.25 0.25 0.25],'EdgeColor',[0 0 0],'LineWidth',2)
% 
% 
% 
% errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
% errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)
% 
% 
% ax = gca;  %% get handle to current axes
% 
% ax.YLim = [0 1600]
% % ax.XLim = [-2 2]
% 
% ax.XTick = [0.5 ,1.5 ];
% ax.YTick = [0:200:1800 ];
% 
% 
% ax.XTickLabel = {'transitive ','intransitive '};
% 
% ax.FontSize = 14;
% titletxt
% title('Reaction time during binary choices')
% ylabel('RT (ms) ','FontSize',16)
% savefig([resultsfold titletxt '.fig']) 

%% corr of reaction time during binary choices and delta rank
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'BRrRTnDRank'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'BRrRTnDRank'};

bar(0.5,mean(conrolData),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes


ax.XTick = [0.5 ,1.5 ];

ax.YLim = [-1 1]
ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt='Figure 5. Mean r of RT and \Delta rank - binary ranking';
title(titletxt,'FontSize',16)
ylabel('pearson r ','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                Training                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Reaction time for tone cue during training 
conrolDataGO=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'trainingRT'};
patientsDataGo=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'trainingRT'};
figure
hold on

bar(0.5,nanmean(conrolDataGO),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,nanmean(patientsDataGo),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)


errorbar(0.5,nanmean(conrolDataGO),nanstd(conrolDataGO)/sqrt(length(conrolDataGO)),'-k','LineWidth',2)
errorbar(1.5,nanmean(patientsDataGo),nanstd(patientsDataGo)/sqrt(length(patientsDataGo)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes
ax.YLim =[0 1600];
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];


ax.YTick = [0 :200:1600];

ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt='A. Mean reaction time to tone-cue during training';
title(titletxt,'FontSize',16)
ylabel('RT (ms)','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% Reaction time for tone cue during training shadedErrorBar
trainingRT


%% probe
control_high=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'chooseGOvsNoGo'};
patients_high=sort(DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'chooseGOvsNoGo'});
markersize=60;


figure
hold on
DataTable=sortrows(DataTable,{'sample__1isControl_2isPatients','chooseGOvsNoGo'})
bar(0.5,nanmean(control_high),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,nanmean(patients_high),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.54,mean(control_high),std(control_high)/sqrt(length(control_high)),'-k','LineWidth',2)
errorbar(1.54,mean(patients_high),std(patients_high)/sqrt(length(patients_high)),'-k','LineWidth',2)

scatter(repmat(0.46,length(control_high),1),control_high,markersize,'filled','MarkerFaceColor','k')

patient_colors=[230, 0, 0;	60, 180, 75; 255,255,255;	255, 225, 25;	0, 130, 200;	245, 130, 48;	145, 30, 180;	70, 240, 240;	240, 50, 230;	170, 110, 40;	250, 190, 190]/255;

for i=[3 4 7 8 9 10 11]
scatter(1.46,patients_high(i),markersize,'filled','MarkerFaceColor',patient_colors(i,:),'MarkerEdgeColor','k')
end
offset=0.015;
scatter(1.46-offset,patients_high(5),markersize,'filled','MarkerFaceColor',patient_colors(5,:),'MarkerEdgeColor','k')
scatter(1.46+offset,patients_high(6),markersize,'filled','MarkerFaceColor',patient_colors(6,:),'MarkerEdgeColor','k')
scatter(1.46-offset,patients_high(1),markersize,'filled','MarkerFaceColor',patient_colors(1,:),'MarkerEdgeColor','k')
scatter(1.46+offset,patients_high(2),markersize,'filled','MarkerFaceColor',patient_colors(2,:),'MarkerEdgeColor','k')

line([-1 3],[.50 .50],'linewidth',3,'color','k','LineStyle','--')

ax = gca;  %% get handle to current axes
ax.XTick = [0.5 1.5 ];
ax.YTick = [0:.10:1.00];

set(gca,'FontSize', 16)

ax.XTickLabel = {'control','VMF patients',16};
titletxt='A. Ratio of Go over No-Go choice';
title(titletxt,'FontSize',16)
ylabel('choice ratio (%)','FontSize',16)
ax.XLim = [-1 3]
ax.YLim = [0 1.1]
savefig([resultsfold titletxt '.fig']) 

%% cdf
figure
hold on
h=cdfplot(control_high)
h.Color=[0 0 0]
h.LineStyle=':'
h.LineWidth=2
h=cdfplot(patients_high)
h.Color=[0 0 0]
h.LineWidth=2
set(gca,'FontSize', 16)
legend('control','VMF','Location','NW')
ax = gca;  %% get handle to current axes
ax.XLim = [0  1];
ax.XTick = [0:0.1:1  ];
ax.YLim = [0 1.1];
ax.YTick = [0:.10:1.00];

titletxt='B. CDFs of Go choices ratio distribution ';
title(titletxt,'FontSize',16)
ylabel('Cumulative probability','FontSize',16)
xlabel('Ratio of Go over No-Go choice','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% Probe RT  

conrolDataGO=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_rt_all'};
patientsDataGo=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_rt_all'};

figure
hold on

a=bar(0.5,nanmean(conrolDataGO),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)

b=bar(1.5,nanmean(patientsDataGo),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.5,nanmean(conrolDataGO),nanstd(conrolDataGO)/sqrt(length(conrolDataGO)),'-k','LineWidth',2)
errorbar(1.5,nanmean(patientsDataGo),nanstd(patientsDataGo)/sqrt(length(patientsDataGo)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];

ax.YLim = [0 1600]

ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt='Figure 8. Reaction time of choice during probe';
title(titletxt,'FontSize',16)
ylabel('RT (ms)','FontSize',16)
savefig([resultsfold titletxt '.fig']) 


%% Probe RT high low 

conrolDataGO=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_rt_high'};
patientsDataGo=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_rt_low'};

figure
hold on

a=bar(0.5,nanmean(conrolDataGO),'FaceColor',[.75 .75 .75],'EdgeColor',[0 0 0],'LineWidth',2)

b=bar(1.5,nanmean(patientsDataGo),'FaceColor',[.25 .25 .25],'EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.5,nanmean(conrolDataGO),nanstd(conrolDataGO)/sqrt(length(conrolDataGO)),'-k','LineWidth',2)
errorbar(1.5,nanmean(patientsDataGo),nanstd(patientsDataGo)/sqrt(length(patientsDataGo)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];

ax.YLim = [0 1600]

ax.XTickLabel = {'High value','Low value'};

ax.FontSize = 14;
titletxt
title('Reaction time of choice during probe')
ylabel('RT (ms)','FontSize',16)

savefig([resultsfold titletxt '.fig']) 

%% Mean Go-chioce reaction time and overall Go choice rate :

markersize=60

conrolchoseGO=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'chooseGOvsNoGo'};
conrolprobe_choseGo_rt=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_choseGo_rt'};

patients(:,1)=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'chooseGOvsNoGo'};
patients(:,2)=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_choseGo_rt'};
% conroltrErr_choseGo_rt=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_choseNoGo_rt'};
% patientstrErr=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_choseNoGo_rt'};

TomRT=	([858.3507031	943.3033735	826.9254545	785.41975	854.4179921	934.018252	860.3960159	675.7916206	603.1626563	850.2321344	825.5799605	810.7072727	810.1354365	875.0176068	684.8480556	656.4319922	825.2727559	752.1619531	710.8071094	757.6632157	747.3429804	784.2211382	840.8158498	844.6002372	725.8466008	803.9230496	934.1839007	891.5021481	833.5830986	722.2176056	827.6821831	843.7568794	818.7179861	766.7471127	688.4351408	941.0152482	876.9335211	868.5500714	875.0085417	673.3546528	740.3906294	885.5029927	724.9933566	842.395036	829.1282639	749.0528671	837.4388732	623.5682517	722.3523077]);	
TomGo=	([0.98828125	0.526104418	0.557312253	0.545833333	0.405511811	0.597560976	0.920318725	0.624505929	0.4609375	0.577075099	0.928853755	0.391304348	0.892857143	0.551282051	0.742063492	0.8828125	0.484251969	0.44921875	0.59375	0.588235294	0.878431373	0.68699187	0.442687747	0.731225296	0.470355731	0.453900709	0.354609929	0.696296296	0.971830986	0.654929577	0.838028169	0.375886525	0.6875	0.492957746	0.436619718	0.432624113	0.577464789	0.564285714	0.763888889	0.840277778	0.685314685	0.525547445	0.888111888	0.561151079	0.875	0.881118881	0.528169014	0.888111888	0.587412587]);	

figure
hold on
patients=sortrows(patients)
scatter(conrolprobe_choseGo_rt,conrolchoseGO,markersize,'filled','MarkerFaceColor',gray,'MarkerEdgeColor','k')
scatter(patients(:,2),patients(:,1),'filled','MarkerFaceColor','w')
scatter(TomRT(2:end),TomGo(2:end),markersize,'+','filled','MarkerFaceColor','k','MarkerEdgeColor','k')

lsLineb=lsline;
set(lsLineb(2),'color','k')
set(lsLineb(1),'color','k')


patient_colors=[230, 0, 0;	60, 180, 75; 255,255,255;	255, 225, 25;	0, 130, 200;	245, 130, 48;	145, 30, 180;	70, 240, 240;	240, 50, 230;	170, 110, 40;	250, 190, 190]/255;

for i=[1: 11]
scatter(patients(i,2),patients(i,1),markersize,'filled','MarkerFaceColor',patient_colors(i,:),'MarkerEdgeColor','k')
end




ax = gca;  %% get handle to current axes
ax.XLim = [590 1100]
ax.XTick = [600:100:1100];


ax.YLim = [0 1.1]
ax.YTick = [0:.10:1];

legend( 'control','VMF patients','r= -0.07','r= -0.66','Young, r= -0.20')

ax.FontSize = 14;
titletxt='Mean Go-chioce reaction time and overall Go choice rate ';
title(titletxt)
xlabel('RT (ms)','FontSize',16)
ylabel('choice ratio (%)','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% sanity
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'NoGo_Sanity'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'NoGo_Sanity'};


bar(0.5,mean(conrolData),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)


errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes

% ax.YLim = [0 1]
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];
ax.YTick = [0:.10:1 ];


ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt
title('Preference consistency after training')
ylabel('choice ratio of high vs. low value items  ','FontSize',16)

savefig([resultsfold titletxt '.fig']) 


%% recognition was 
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'recognitionNewOld'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'recognitionNewOld'};


bar(0.5,mean(conrolData),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)


errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes

% ax.YLim = [0 1]
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];
ax.YTick = [0:.10:1 ];


ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt
title('Memory of the experiment items (Old/New)')
ylabel('ratio of correct item recognition','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% recognition Go 
figure
hold on

conrolData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'recognitionGoNoGo'};
patientsData=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'recognitionGoNoGo'};


bar(0.5,nanmean(conrolData),'FaceColor',gray,'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,nanmean(patientsData),'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',2)


errorbar(0.5,nanmean(conrolData),nanstd(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,nanmean(patientsData),nanstd(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes

 ax.YLim = [0 1]
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];
ax.YTick = [0:.10:1 ];


ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 14;
titletxt
title('Memory of the experiment items'' training condition (Go/NoGo)')
ylabel('ratio of correct item recognition','FontSize',16)
savefig([resultsfold titletxt '.fig']) 

%% Mean training reaction time and overall Go choice rate :

markersize=60


patients(:,1)=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'chooseGOvsNoGo'};
patients(:,2)=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'training_cue_RT'};
conrolchoseGO=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'chooseGOvsNoGo'};
conrolprobe_choseGo_rt=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'training_cue_RT'};
TomRT_image=	([964.953531756756	967.503087152778	960.063197569444	943.063597113402	938.617683219178	845.716709863946	853.669055102042	937.210876388889	957.832325342466	945.898158391608	934.041235314685	924.282449525424	929.782361520271	923.453662549668	853.989537229300	964.795766784452	913.560488698631	962.352861619719	966.338602090593	949.350499655172	958.176521724138	859.846148102893	957.032164948454	936.109583044983	947.658214576270	946.982292765958	943.603276954733	931.299453556485	814.166523886640	925.592860483871	958.469303797468	948.316338271604	968.733658974359	948.244900803213	959.445600851064	933.533925423729	969.009956016597	761.266615189873	918.996745204167	958.230632173913	883.518033333334	950.889661038961	950.847804184101	915.477471729958	957.427198734176	896.538160493828	899.561659259259	962.324667521368	917.601003765690	953.561677777778]);	
TomGo=	([ 0.98828125	0.524583817	0.55711786	0.539473684	0.404079861	0.598842975	0.920507937	0.623	0.4609375	0.577084114	0.929008874	0.39176353	0.893019153	0.551816514	0.740171371	0.8828125	0.483816964	0.44921875	0.59375	0.588275098	0.87832185	0.68699187	0.44288214	0.730377453	0.470441195 0.453502415458937 0.355633802816901 0.695895522388060 0.971830985915493 0.654929577464789 0.838028169014085 0.376358148893360 0.687500000000000 0.492957746478873 0.435714285714286 0.432595573440644 0.524354460093897 0.575793650793651 0.564285714285714 0.763888888888889 0.840277777777778 0.685543818466354 0.528915919760990 0.887715179968701 0.561180124223603 0.875000000000000 0.880672926447574 0.529761904761905 0.888399843505477 0.588028169014085]);	

TomRT_cue=[196.037848263889	349.817418055556	362.545007291667	320.968612237762	287.564486062718	291.986896099291	178.583138028169	296.010598939929	260.214937847222	280.217086267606	264.541225177305	255.879875209790	308.966574912892	276.309185679443	185.352975789474	210.746617375886	297.911899298245	261.964666666667	285.925803508772	267.464969718310	220.678824210526	236.355217173145	435.967447386760	325.470482394366	239.024445583039	279.059168534483	273.967285654008	371.423294642857	83.6320478813560	280.098345378151	334.774305907173	334.445877542373	266.168342857143	230.146993534483	364.770643776824	272.371360775862	403.834752301256	-77.8143756410257	244.162608004329	260.713228695652	156.171123728814	253.401590434783	359.355994092827	105.544122978723	350.785466244726	186.949313135593	248.518827966102	271.311038260870	204.545021518987	317.965665367965];


figure
hold on
patients=sortrows(patients)
scatter(patients(:,2),patients(:,1),'filled','MarkerFaceColor','w')
scatter(conrolprobe_choseGo_rt,conrolchoseGO,markersize,'d','filled','MarkerFaceColor',gray,'MarkerEdgeColor','k')
scatter(TomRT_cue(2:end),TomGo(2:end),markersize,'+','filled','MarkerFaceColor','k','MarkerEdgeColor','k')



lsLineb=lsline;
set(lsLineb(1),'color','k','LineWidth',2,'LineStyle',':')
set(lsLineb(2),'color','k','LineWidth',2,'LineStyle','-')
set(lsLineb(3),'color','k','LineWidth',2,'LineStyle','--')



patient_colors=[230, 0, 0;	60, 180, 75; 255,255,255;	255, 225, 25;	0, 130, 200;	245, 130, 48;	145, 30, 180;	70, 240, 240;	240, 50, 230;	170, 110, 40;	250, 190, 190]/255;

for i=[1: 11]
scatter(patients(i,2),patients(i,1),markersize,'filled','MarkerFaceColor',patient_colors(i,:),'MarkerEdgeColor','k')
end


ax = gca;  %% get handle to current axes
ax.XLim = [150 600]
ax.XTick = [150:50:600];


ax.YLim = [0 1.1]
ax.YTick = [0:.10:1];


ax.FontSize = 14;
titletxt='Mean training cue-reaction time and overall Go choice rate ';
title(titletxt)
xlabel('RT (ms)','FontSize',16)
ylabel('choice ratio (%)','FontSize',16)



legend( 'control','VMF patients','r= -0.07','r= -0.66','Young, r= -0.20')


savefig([resultsfold titletxt '.fig']) 