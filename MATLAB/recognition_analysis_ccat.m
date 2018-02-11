




for subjInd=1:length(subjects)
    
    %
    IsOldLogs=dir([outpath,'*',num2str(subjects(subjInd)),'_recognitionNewOld1*.txt']) ;
    IsGoLogs=dir([outpath,'*',num2str(subjects(subjInd)),'_recognitionGoNoGo1*.txt']) ;
    fid1=fopen(strcat(outpath,IsOldLogs(1).name));
    fid2=fopen(strcat(outpath,IsGoLogs(1).name));
    
    IsOldData=textscan(fid1, '%s %f %f %f %f %f %f %s %s %f %f %f' , 'HeaderLines', 1);     %read output file
    %       1 - subjectID       2 - order           3 - itemIndABC     4 - runtrial         5 - isOld?      6 - subjectAnswer
    %       7 - onsettime      8 - Name          9 - resp_choice    10 - RT             11 - bidInd     12 - isBeep?
    IsGoData=textscan(fid2, '%s %f %s %f %f %f %f %f %f %f %f %s %f', 'HeaderLines', 1);     %read output file
    %       1 - subjectID       2 - order           3 - stimName        4 - itemIndABC 5 - bidIND      6 - runtrial
    %       7 - IsOld?           8 -  subjectAnswerIsOld          9 -  isBeep?    10 - subjectAnswerIsBeep             11 - onsettime     12 - resp_choice 13 - RT
    fclose(fid1);
    fclose(fid2);
    
    IsOld=IsOldData{5};
    subjectAnswerOld=IsOldData{6};
    
    IsGo=IsGoData{9};
    subjectAnswerGo=IsGoData{10};
    
    IsOldCorrectResponse=IsOld==subjectAnswerOld;
    IsGoCorrectResponse=IsGo==subjectAnswerGo;
    
    
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'recognitionNewOld'}=sum(IsOldCorrectResponse)/length(IsOld);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'recognitionGoNoGo'}   =sum(IsGoCorrectResponse)/length(IsGo);
    
    
end




