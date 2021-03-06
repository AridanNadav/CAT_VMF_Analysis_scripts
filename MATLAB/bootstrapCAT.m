%%%%%%%%%%%%%%% independent

rng(1)

alpha = .05;        %alpha value
numOfiterations=10000;


control=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_rt_all'};
VMF=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_rt_all'};


control=DataTable{:,'probe_rt_high'};
VMF=DataTable{:,'probe_rt_low'};
dnanmean=[]
realD=nanmean(control)-nanmean(VMF)
for itr=1:numOfiterations
    
Cvec=ceil(rand([length(control),1])*length(control));
VMFvec=ceil(rand([length(VMF),1])*length(VMF));
dnanmean(itr)=nanmean(control(Cvec))-nanmean(VMF(VMFvec));
end

Sdnanmean=sort(dnanmean);
% k=find(Sdnanmean>0);
% 1-(k(1)/numOfiterations)

% CI
LowCI=Sdnanmean((0.025*numOfiterations))
HighCI=Sdnanmean((0.975*numOfiterations))




%%%%%%%%%%%%%%% dependent
rng(1)

alpha = .05;        %alpha value
numOfiterations=10000;


a1=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==1,'probe_rt_all'};
a2=DataTable{DataTable{:,'sample__1isControl_2isPatients'}==2,'probe_rt_all'};


a1=DataTable{:,'BRmRTnotViol'};
a2=DataTable{:,'BRmRTviol'};

dvec=a1-a2;

dnanmean=[]
realD=nanmean(dvec)
dvecvec=[]
for itr=1:numOfiterations

dvecvec=ceil(rand([length(dvec),1])*length(dvec));
dnanmean(itr)=nanmean(dvec(dvecvec));
end

Sdnanmean=sort(dnanmean);
% k=find(Sdnanmean>0);
% 1-(k(1)/numOfiterations)

% CI
Sdnanmean((0.025*numOfiterations))
Sdnanmean((0.975*numOfiterations))


% % %%%%%%%%%%%%
% % 
% % myStatistic = @(control,VMF) nanmean(control)-nanmean(VMF);
% % 
% % sampStat = myStatistic(control,VMF);
% % bootstrapStat = zeros(numOfiterations,1);
% % for i=1:numOfiterations
% %     sampX1 = control(ceil(rand(length(control),1)*length(control)));
% %     sampX2 = VMF(ceil(rand(length(VMF),1)*length(VMF)));
% %     bootstrapStat(i) = myStatistic(sampX1,sampX2);
% % end
% % 
% % CI = prctile(bootstrapStat,[100*alpha/2,100*(1-alpha/2)]);
% % H = CI(1)>0 | CI(2)<0;
% % 
% % clf
% % xx = min(bootstrapStat):.01:max(bootstrapStat);
% % hist(bootstrapStat,xx);
% % hold on
% % ylim = get(gca,'YLim');
% % h1=plot(sampStat*[1,1],ylim,'y-','LineWidth',2);
% % h2=plot(CI(1)*[1,1],ylim,'r-','LineWidth',2);
% % plot(CI(2)*[1,1],ylim,'r-','LineWidth',2);
% % h3=plot([0,0],ylim,'b-','LineWidth',2);
% % xlabel('Difference between nanmeans');
% % 
% % decision = {'Fail to reject H0','Reject H0'};
% % title(decision(H+1));
% % legend([h1,h2,h3],{'Sample nanmean',sprintf('%2.0f%% CI',100*alpha),'H0 nanmean'},'Location','NorthWest');
% % 
% % 
% % [bootstat,bootsam] = bootstrp(numOfiterations,myStatistic,control,VMF)
