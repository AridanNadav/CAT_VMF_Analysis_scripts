%% CAT canada analysis
% run from ../CAT_frontal_patients/Analysis

clear all

% patients: VMF: 105,116,128,129,501:503,507,508,509,510  EX: 130,108-DMF 127-FP
% control: 101:104,106,107,109:115,117:126,131,401:406

outpath=['./../Output/']; % Output folder location  patient or control
resultspath=['./../results/'];

subs2include.Patients=[105,116,128,129,501:503,507,508,509,510];
subs2include.Control=[101:104,106,107,109,113,115,117:126,131,401:406];
samplesName={'Control','Patients'};


allsubsRT=[]
for sample_cntr =1:2
    % subs to run
    ALLsubjects=subs2include.(samplesName{sample_cntr});
    subjects2EXclud= [];
    subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));%exclude:
    
    % get_transitivity_violations
    
    
    for subjInd=1:length(subjects)
        subjInd
        % get the Colley weights
         % get the rank by Colley 
    stopGoList_allstim_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_stopGoList_allstim_order' '*']);
    stopGoList_allstim_data=Get_stopGoList_allstim([outpath stopGoList_allstim_fileID(1).name]);
        % get the binary ranking
        BR_fileID=dir([outpath '*' num2str(subjects(subjInd)) '_binary_ranking' '*.txt']);
        BR_data=Get_binary_ranking([outpath BR_fileID(1).name]);
        % count violations and indecisions
        
        
        for i=1:height(BR_data)
                      RT(i,4)=sample_cntr;

            RT(i,1)=subjects(subjInd);
            % notice rank 1 is > than rank 2 so the <> signs are revered
            % left>rigth and choose left || right>left and choose right
            if (find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})>find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='u' )||( find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumLeft'})<find(stopGoList_allstim_data{:,'imagenum'} ==BR_data{i,'StimNumRight'}) && BR_data{i,'Response'}=='i'  )
                RT(i,2)  =1;
            else
                RT(i,2)  =0;
            end
            
            
            if   BR_data{i,'Response'}=='x'
                
            RT(i,3)=NaN;    
            else
            RT(i,3)  =  BR_data{i,'RT'};
            end
        end
        
        allsubsRT=[allsubsRT ; RT];
        
    end
    
    
    
end

T=array2table(allsubsRT,...
    'VariableNames',{'sub','isViolation','rt','sample'})


writetable(T,[resultspath '/CATcanadaRT' date '.csv']);

