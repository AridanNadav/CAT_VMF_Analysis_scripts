
% ~~~~~~~~~~~ Script for analyzing binary ranking results ~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~ Written by Tom Salomon, May 2015 ~~~~~~~~~~~~~~~~~
%

subjects=[101:102,104:112,114:128]; % Define here your subjects' codes.
%exclude:
% 103 - did probe part twice
% 107 - had poor sanity results - decide later if you want it
% 113 - did the probe part too many times (due to bad code modification)

analysis_path=pwd; % Analysis folder location
outpath=[analysis_path(1:end-8),'Output/']; % Output folder location
all_subjs_data{length(subjects)}={};
% Rankings matrix: Each row is a subject and each column is one of 60 stimuli. First column is subject's id
rankings=zeros(length(subjects),61); 
stdevs=zeros(length(subjects),2);
stdevs(:,1)=subjects;
rankings(:,1)=subjects;

for subjInd=1:length(subjects)
    
    data_file=dir(strcat(outpath,'BMI_*',num2str(subjects(subjInd)),'*ItemRankingResults','*.txt')) ;
    subject_data=[];
    fid=fopen(strcat(outpath,data_file.name));
    data=textscan(fid, '%s%s%f%f%f%f%f' , 'HeaderLines', 1);     %read in Binary Ranking output file;
    % 1-subjectID       2-StimName	 3-StimNum (by name)        4-Rank from Colley
    % 5-Wins            6-Loses        7-Total
    fid=fclose(fid);
    
    rankings(subjInd,2:end)=data{4}'; 
    all_subjs_data{subjInd}=data; %All subjects' data
    stdevs(subjInd,2)=std(data{4}); % Standard deviations of the rankings. Small STD indicates ranking were 
    % similar to one each other due to poor trasitivity of choices.
end
