%% Mean Go-chioce reaction time and overall Go choice rate :


markersize=50;
figure
hold on

DataTable(isnan(DataTable{:,'RT'}),:)=[];
xRange=[-50 60];
subs2include.Patients=[105,116,128,129,501:503,507,508,509,510];
subs2include.Control=[101:104,106,107,109:113,115,117:126,131,401:406];
samplesName={'Control','Patients'};
sampleColor={[0 0 1 0.5],[1 0 0 0.5]};
cut.vals=[];
Yvar.vals=[]
for sample_cntr =1:2
    % subs to run
    ALLsubjects=subs2include.(samplesName{sample_cntr});
    subjects2EXclud= [];
    subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));%exclude:
    for subjInd=1:length(subjects)
        linearCoefficients = polyfit(DataTable{DataTable{:,'sub'}==subjects(subjInd),'Drank'}, DataTable{DataTable{:,'sub'}==subjects(subjInd),'RT'}, 1);
        b=linearCoefficients(1);
        a=linearCoefficients(2);
        cut(sample_cntr).vals(subjInd,1)=b*xRange(1)+a;
        cut(sample_cntr).vals(subjInd,2)=b*xRange(2)+a;
        
        for Xval=xRange(1):1:xRange(2)
            Yvar(sample_cntr).vals(subjInd,Xval+51)=b*Xval+a  ;
        end
        %     plot(xRange,[ cut(sample_cntr).vals(subjInd,1)  cut(sample_cntr).vals(subjInd,2)],'Color',sampleColor{sample_cntr},'LineWidth',.4)
    end
end

zz=plot(xRange,[ mean(cut(1).vals(:,1))  mean(cut(1).vals(:,2))],'Color',sampleColor{1}(1:3),'LineWidth',4)
[size1 q]=size(Yvar(1).vals);
shadedErrorBar(	(xRange(1):xRange(2)),mean(Yvar(1).vals), -1*std(Yvar(1).vals)/sqrt(size1)	,'lineprops',{'-b','markerfacecolor',[0,0,1]})


z=plot(xRange,[ mean(cut(2).vals(:,1))  mean(cut(2).vals(:,2))],'Color',sampleColor{2}(1:3),'LineWidth',4)
[size1 q]=size(Yvar(2).vals);
shadedErrorBar(	(xRange(1):xRange(2)),mean(Yvar(2).vals), -1*std(Yvar(2).vals)/sqrt(size1)	,'lineprops',{'-r','markerfacecolor',[1,0,0]})


ax = gca;  %% get handle to current axes
ax.XLim = [-50 60]


ax.FontSize = 14;
title('Mean correlation of binary ranking RT and \Delta rank ')
xlabel('\Delta rank (chosen-not chosen)')
ylabel('RT (ms)','FontSize',16)

