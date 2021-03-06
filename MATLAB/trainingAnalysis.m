function trainingAnalysis(subjects)



    mainPath = './..';


analysisOutputPath = [mainPath '/Output/'];

RT_Correct_all_HL1_allsubjects = 9999*ones(50,264);
RT_Correct_all_HL2_allsubjects = 9999*ones(50,264);

for subjectInd = 1:length(subjects)
    Ladder1alls = [];
    Ladder2alls = [];
    
    RT_Correct_all_HL1 = [];
    RT_Correct_all_HL2 = [];
 
    clear Ladder1 Ladder2 respInTime respTime incorrect
    
    mats_train = dir([analysisOutputPath '*' num2str(subjects(subjectInd)) '_training_run*.mat']);
    
    %    fid=fopen(strcat(outpath,logs(1).name));
    load([analysisOutputPath '/' mats_train(1).name]);
    
    
    for index = 1:runNum
        Ladder1alls = [Ladder1alls; Ladder1{index}(1:end)];
        Ladder2alls = [Ladder2alls; Ladder2{index}(1:end)];
        gos1(subjectInd,index) = size(find(respInTime{index}==110),1);
        gos2(subjectInd,index) = size(find(respInTime{index}==220),1);
        corrects(subjectInd,index) = correct{index};
        RT_Correct_all_HL1 = [RT_Correct_all_HL1 ; respTime{index}(find(respInTime{index}==12))];
        RT_Correct_all_HL2 = [RT_Correct_all_HL2 ; respTime{index}(find(respInTime{index}==24))];
        mean_RT_HL1(subjectInd,index) = mean(respTime{index}(find(respInTime{index}==12)));
        mean_RT_HL2(subjectInd,index) = mean(respTime{index}(find(respInTime{index}==24)));
        median_RT_HL1(subjectInd,index) = median(respTime{index}(find(respInTime{index}==12)));
        median_RT_HL2(subjectInd,index) = median(respTime{index}(find(respInTime{index}==24)));
        median_Ladders_HL1(subjectInd,index) = median(Ladder1{index});
        median_Ladders_HL2(subjectInd,index) = median(Ladder2{index});
        length_Ladders_HL1(subjectInd,index) = length(Ladder1{index});
        length_Ladders_HL2(subjectInd,index) = length(Ladder2{index});
        
    end
    
    
    median_SSRT_1 = median_RT_HL1*1000-median_Ladders_HL1;
    median_SSRT_2 = median_RT_HL2*1000-median_Ladders_HL2;
     
    Ladders1AllSubs(subjectInd,:) = Ladder1alls';
    Ladders2AllSubs(subjectInd,:) = Ladder2alls';
    
    RT_Correct_all_HL1_allsubjects(subjectInd,1:length(RT_Correct_all_HL1)) = RT_Correct_all_HL1';
    RT_Correct_all_HL2_allsubjects(subjectInd,1:length(RT_Correct_all_HL2)) = RT_Correct_all_HL2';
    
    
    figure(subjects(subjectInd))
    plot(Ladder1alls,'-')
    hold on
    plot(Ladder2alls,'r-')
    ylim([0 1000]);
end

figure;

sterhigh1 = std(Ladders1AllSubs)/sqrt(size(Ladders1AllSubs,1));
sterlow2 = std(Ladders2AllSubs)/sqrt(size(Ladders2AllSubs,1));
boundedline(1:length(Ladders1AllSubs),mean(Ladders1AllSubs),sterhigh1,'b','alpha');
hold on
boundedline(1:length(Ladders2AllSubs),mean(Ladders2AllSubs),sterlow2,'r','alpha');

ylabel('Go Signal Delay', 'fontsize',24);
xlabel('trials','fontsize',24);
title('Boost, SSD=start at 650 msec','fontsize',10);



figure;
stergos1 = std(gos1)/sqrt(size(gos1,1));
stergos2 = std(gos2)/sqrt(size(gos2,1));

boundedline(1:length(gos1),mean(gos1),stergos1,'b','alpha');
hold on
boundedline(1:length(gos2),mean(gos2),stergos2,'r','alpha');
xlabel ('runs','fontsize',24);
ylabel ('Number of correct Go out of 8 ', 'fontsize',24);
title('Average of Gos', 'fontsize',10);



% for shuffInd=1:50
%
% [shuffled_median_SSRT_1,indShuff1]=Shuffle(median_SSRT_1);
% shuffled_median_SSRT_2=median_SSRT_2(indShuff1);
%
%
% 'comparison of mean median SSRT blocks 1:6';
% [h,p1]=ttest(mean(shuffled_median_SSRT_1(1:5,1:6)),mean(shuffled_median_SSRT_2(1:5,1:6)));
%
% permshuffres_1_6(shuffInd,1)=p1;
%
% 'comparison of mean median SSRT blocks 7:12';
% [h,p2]=ttest(mean(shuffled_median_SSRT_1(1:5,7:12)),mean(shuffled_median_SSRT_2(1:5,7:12)));
%
% permshuffres_7_12(shuffInd,1)=p2;
% end
%
% [permshuffres_1_6 permshuffres_7_12]
%

end % end function