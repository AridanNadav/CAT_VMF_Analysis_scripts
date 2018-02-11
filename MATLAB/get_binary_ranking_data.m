% get_transitivity_violations


for subjInd=1:length(subjects)
    subjInd
    %     % get the Colley weights
    %     ItemRankingResults_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_ItemRankingResults' '*']);
    %     ItemRankingResults_data=Get_ItemRankingResults ([outpath ItemRankingResults_fileID(1).name]);
    %     SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'Colley_std'}=std(ItemRankingResults_data{:,'Rank'});
    
    
    % get the rank by Colley
    stopGoList_allstim_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_stopGoList_allstim_order' '*']);
    stopGoList_allstim_data=Get_stopGoList_allstim([outpath stopGoList_allstim_fileID(1).name]);
    
    % get the binary ranking
    BR_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_binary_ranking' '*.txt']);
    BR_data=Get_binary_ranking([outpath BR_fileID(1).name]);
    % count violations and indecisions
    % allBRdata4Log=[allBRdata4Log ; BR_data];
    
    Drank=NaN(height(BR_data),1);
    IsViolation=NaN(height(BR_data),1);
    
    Sub=BR_data{:,1};
    RT=BR_data{:,10};
    RT(RT==999000)=NaN;
    
    for i=1:height(BR_data) % if violation (chose rank low over rank high)
        
        % notice rank 1 is > than rank 2 so the <> signs are revered
        % left>rigth && choose left || right>left && choose right
        
        if (find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})>find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='u' )||( find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})<find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='i'  )
            
            IsViolation(i)=1;
            Drank(i)= -1*abs((find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'}))-(find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}))) ;
            
        elseif BR_data{i,'Response'}=='x' % no response
            
            IsViolation(i)=NaN;
            Drank(i)=NaN;
            
        else
            IsViolation(i)=0;
            Drank(i)=  abs((find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'}))-(find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'})))   ;
        end
        
    end
    
    
    % SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'num_of_transitivity_violations'}=sum(cnt_violations);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'choice_indecisions'}=sum(isnan(RT));
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRrRTnDRank'}=corr(RT,Drank,'rows' , 'complete' );
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRmRTnotViol'}=mean(RT(IsViolation==0));
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRmRTviol'}=mean(RT(IsViolation==1 ));
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRmRTall'}=nanmean(RT);

    Transitivity_leave_one_out
    
    isCorrect_ColleyL1out=NaN(length(RT),1);
    accuracy_ColleyCNT=1;
    for k=1:length(RT)
        if isnan(RT(k))
            isCorrect_ColleyL1out(k) =NaN;
        else
            isCorrect_ColleyL1out(k) = accuracy_Colley(accuracy_ColleyCNT);
            accuracy_ColleyCNT=accuracy_ColleyCNT+1;
        end
    end
    
    
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'accuracy_Colley_L1Out'}=mean(accuracy_Colley);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'accuracy_SimpleCount_L1Out'}=mean(accuracy_SimpleCount);
    
    Keep_BR_data=array2table([Sub Sub*0+sample_cntr Drank IsViolation RT isCorrect_ColleyL1out],'VariableNames',{'sub','sample__1isControl_2isPatients','Drank','IsViolation','RT','isCorrect_ColleyL1out'});

    BRdata=[BRdata ; Keep_BR_data];
end
