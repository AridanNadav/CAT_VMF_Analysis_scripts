%% CAT_canada_data_into_table_for_logistic_regression
% run from ../CAT_frontal_patients/Analysis

clear all

% patients: OFC/VMF: 105,116,128,129,501:503,507,508,509,510  EX: 130,108-DMF 127-FP
% control: 101:104,106,107,109:115,117:126,131,401:406

outpath=['./../Output/']; % Output folder location  patient or control
resultspath=['./../results/'];

subs2include.Control=[ 101:104,106,107,109:113,115,117:126,131,401:406];
subs2include.Patients=[105,116,128,129,501:503,507,508,509,510];
samplesName={'Control','Patients'};
sampledata=[];
allsubsdata=[];
for sample_cntr =1:2
ALLsubjects=subs2include.(samplesName{sample_cntr});
subjects2EXclud= [];
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));%exclude:
    % 1-subjectID       2-scanner	 3-order        4-block         5-run       6-trial	 7-onsettime    8-ImageLeft	 9-ImageRight	10-bidIndexLeft
    % 11-bidIndexRight	12-IsleftGo	 13-Response    14-PairType     15-Outcome  16-RT	 17-bidLeft     18-bidRight
for subjInd=1:length(subjects)
    subjInd
    subdata=[];
    subdata=Probe_recode(subjects(subjInd),outpath);
    subdata=subdata(subdata(:,14)~=4,:);
    subdata(find(subdata(:,15)==999),:)=[];
    subdata=[subdata(:,1),ones(length(subdata),1)*sample_cntr,subdata(:,15),subdata(:,14), (subdata(:,16))]; %zscore(subdata(:,16))
    sampledata=[sampledata; subdata];
end
allsubsdata=[allsubsdata; sampledata];

end
allsubsdata(:,5)=zscore((allsubsdata(:,5)));
CATcanadaLog=array2table(allsubsdata,'VariableNames',{'sub',['sample__1is' samplesName{1} '_2is' samplesName{2} ],'outcome','PairType','rt'});
writetable(CATcanadaLog,[resultspath '/CATcanadaLog' date '.csv']);
