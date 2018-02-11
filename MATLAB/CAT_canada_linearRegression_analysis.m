%% CAT canada analysis
% run from ../CAT_frontal_patients/Analysis

clear all

% patients: VMF: 105,116,128,129,501:503,507,508,509,510  EX: 130,108-DMF 127-FP
% control: 101:104,106,107,109:113,115,117:126,131,401:406  EX 114

outpath=['./../Output/']; % Output folder location  patient or control
resultspath=['./../results/'];

subs2include.Patients=[105,116,128,129,501:503,507,508,509,510];
subs2include.Control=[101:104,106,107,109:113,115,117:126,131,401:406];
samplesName={'Control','Patients'};
tableheaders={'sub',['sample__1is' samplesName{1} '_2is' samplesName{2} ],'sex__1isF__2isM','age','chooseGOvsNoGo','HighChooseGOvsNoGo','LowChooseGOvsNoGo','NoGo_Sanity','recognitionNewOld','recognitionGoNoGo','Colley_std','num_of_transitivity_violations','accuracy_Colley_L1Out','accuracy_SimpleCount_L1Out','choice_indecisions','BRrRTnDRank','BRmRT','BRmRTviol','probe_choseGo_rt_high','probe_choseNoGo_rt_high','probe_choseGo_rt_low','probe_choseNoGo_rt_low','probe_choseGo_rtSE','trainingRT'};

for sample_cntr =1:2
% subs to run
ALLsubjects=subs2include.(samplesName{sample_cntr});
subjects2EXclud= [];
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));%exclude:

prealocateT=NaN(length(subs2include.(samplesName{sample_cntr})),length(tableheaders));
SampleSummeryTable=array2table(prealocateT,'VariableNames',tableheaders);

SampleSummeryTable{:,'sub'}=subs2include.(samplesName{sample_cntr})';
SampleSummeryTable{:,'sample__1isControl_2isPatients'}=sample_cntr;

%% demographics
get_demographics
%% Probe_analysis
%% binary ranking:rt,transitivity_violations 
get_transitivity_violations
%% training
get_trainingRT
%% probe
Probe_analysis_ccat
%% recognition
recognition_analysis_ccat

allSamplesSummeryTable.(samplesName{sample_cntr})=SampleSummeryTable;
end
jointSamplesSummeryTable = [allSamplesSummeryTable.Control ;  allSamplesSummeryTable.Patients];
writetable(jointSamplesSummeryTable,[resultspath '/CATcanadaSummary' date '.csv']);
