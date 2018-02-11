figure
hold on

conrolData=CATcanadaSummary01Jan2018a{CATcanadaSummary01Jan2018a{:,'sample__1isControl_2isPatients'}==1,'intransitivity_ratio'};
patientsData=CATcanadaSummary01Jan2018a{CATcanadaSummary01Jan2018a{:,'sample__1isControl_2isPatients'}==2,'intransitivity_ratio'};

bar(0.5,mean(conrolData),'FaceColor',[0 0 1],'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor',[1 0 0],'EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes

% ax.YLim = [0 1]
% ax.XLim = [-2 2]

ax.XTick = [0.5 ,1.5 ];
ax.YTick = [ ];


ax.XTickLabel = {'control','group'};
ax.YTickLabel = {''};

ax.FontSize = 16;

title('Choice inconsistency ')
ylabel('intransitivity ratio ','FontSize',16)
xlabel('My y-Axis Label','FontSize',12)


