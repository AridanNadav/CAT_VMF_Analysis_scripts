% get_transitivity_violations


for subjInd=1:length(subjects)
    subjInd
    % get the Colley weights
    ItemRankingResults_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_ItemRankingResults' '*']);
    ItemRankingResults_data=Get_ItemRankingResults ([outpath ItemRankingResults_fileID(1).name]);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'Colley_std'}=std(ItemRankingResults_data{:,'Rank'});
    
    
     % get the rank by Colley 
    stopGoList_allstim_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_stopGoList_allstim_order' '*']);
    stopGoList_allstim_data=Get_stopGoList_allstim([outpath stopGoList_allstim_fileID(1).name]);
    
    % get the binary ranking 
    BR_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_binary_ranking' '*.txt']);
    BR_data=Get_binary_ranking([outpath BR_fileID(1).name]);
    % count violations and indecisions
   % allBRdata4Log=[allBRdata4Log ; BR_data];
    cnt_violations=0;
    cnt_indecisions=0;
    RTnDrank=[];
    RTviol=[];

    cntRTnDrank=1;
    for i=1:height(BR_data)
                
        % notice rank 1 is > than rank 2 so the <> signs are revered
        % left>rigth and choose left || right>left and choose right 
        if (find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})>find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='u' )||( find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})<find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='i'  )
         
            RTviol=[RTviol  BR_data{i,'RT'}];
            cnt_violations=cnt_violations+1;
         
        elseif BR_data{i,'Response'}=='x'
            cnt_indecisions=cnt_indecisions+1;
        else
        RTnDrank(cntRTnDrank,1)=  BR_data{i,'RT'} ;
        RTnDrank(cntRTnDrank,2)=  abs((find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'}))-(find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'})))   ;
cntRTnDrank=cntRTnDrank+1;
        end
        
    end
    
     SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'num_of_transitivity_violations'}=sum(cnt_violations);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'choice_indecisions'}=sum(cnt_indecisions);
    r=corrcoef(RTnDrank(:,1),RTnDrank(:,2));
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRrRTnDRank'}=r(2);
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRmRT'}=mean(RTnDrank(:,1));
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'BRmRTviol'}=mean(RTviol);
    
    Transitivity_leave_one_out 
    
        results.accuracy_Colley=mean(accuracy_Colley);
        results.accuracy_SimpleCount=mean(accuracy_SimpleCount);
 
        
  SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'accuracy_Colley_L1Out'}=mean(accuracy_Colley);
  SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'accuracy_SimpleCount_L1Out'}=mean(accuracy_SimpleCount);

   
end
