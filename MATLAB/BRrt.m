%% CAT canada analysis
% run from ../CAT_frontal_patients/Analysis

clear all

% patients: VMF: 105,116,128,129,501:503,507,508,509,510  EX: 130,108-DMF 127-FP
% control: 101:104,106,107,109:115,117:126,131,401:406

outpath=['./../Output/']; % Output folder location  patient or control
resultspath=['./../results/'];

subs2include.Patients=[105,116,128,129,501:503,507,508,509,510];
subs2include.Control=[101:104,106,107,109:113,115,117:126,131,401:406];
samplesName={'Control','Patients'};

% NumOFcued=12;
% NumOFruns=16;
% controlRT=NaN(length(subs2include.Control),NumOFruns*NumOFcued);
% PatientsRT=NaN(length(subs2include.Patients),NumOFruns*NumOFcued);
AllsubRT(1).RTvec=[];
AllsubRT(2).RTvec=[];
    
for sample_cntr =1:2
    % subs to run
    ALLsubjects=subs2include.(samplesName{sample_cntr});
    subjects2EXclud= [];
    subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));%exclude:
    

    for subjectInd = 1:length(subjects)
        subjectInd
        trainingRuns = dir([outpath '*' num2str(subjects(subjectInd)) '_training_run*.txt']);
        if length(trainingRuns) ~=16
            warning(['wrong # of runs!!! sub: ' num2str(subjects(subjectInd)) ])
        end
        
        subRT=[];
        
        for currrun = 1:length(trainingRuns)
            %% get data
            
            delimiter = '\t';
            startRow = 2;
            endRow = inf;
            formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
            fileID = fopen([outpath trainingRuns(currrun).name],'r');
            dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
            for block=2:length(startRow)
                frewind(fileID);
                dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
                for col=1:length(dataArray)
                    dataArray{col} = [dataArray{col};dataArrayBlock{col}];
                end
            end
            fclose(fileID);
            raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
            for col=1:length(dataArray)-1
                raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
            end
            numericData = NaN(size(dataArray{1},1),size(dataArray,2));
            for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
                % Converts text in the input cell array to numbers. Replaced non-numeric
                % text with NaN.
                rawData = dataArray{col};
                for row=1:size(rawData, 1)
                    % Create a regular expression to detect and remove non-numeric prefixes and
                    % suffixes.
                    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
                    try
                        result = regexp(rawData(row), regexstr, 'names');
                        numbers = result.numbers;
                        
                        % Detected commas in non-thousand locations.
                        invalidThousandsSeparator = false;
                        if numbers.contains(',')
                            thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                                numbers = NaN;
                                invalidThousandsSeparator = true;
                            end
                        end
                        % Convert numeric text to numbers.
                        if ~invalidThousandsSeparator
                            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                            numericData(row, col) = numbers{1};
                            raw{row, col} = numbers{1};
                        end
                    catch
                        raw{row, col} = rawData{row};
                    end
                end
            end
            runtable = table;
            runtable.subjectID = cell2mat(raw(:, 1));
            runtable.order = cell2mat(raw(:, 2));
            runtable.runNum = cell2mat(raw(:, 3));
            runtable.itemName = cell2mat(raw(:, 4));
            runtable.onsetTime = cell2mat(raw(:, 5));
            runtable.shuff_trialType = cell2mat(raw(:, 6));
            runtable.RT = cell2mat(raw(:, 7));
            runtable.respInTime = cell2mat(raw(:, 8));
            runtable.AudioTime = cell2mat(raw(:, 9));
            runtable.response = cell2mat(raw(:, 10));
            runtable.fixationTime = cell2mat(raw(:, 11));
            runtable.ladder1 = cell2mat(raw(:, 12));
            runtable.ladder2 = cell2mat(raw(:, 13));
            runtable.bidIndex = cell2mat(raw(:, 14));
            runtable.itemNameIndex = cell2mat(raw(:, 15));
            runtable.bidValue = cell2mat(raw(:, 16));
            
            getRunRT=runtable{runtable{:,'RT'}~=999000,'RT'}';
            
            subRT=[subRT getRunRT];
            
            if length (getRunRT)~=12
                warning(['wrong # of Go!!! sub: ' num2str(subjects(subjectInd)) 'in run: '  num2str(currrun) ])
            end
        end
        if length (subRT)~=192
            warning(['wrong # of Go!!! sub: ' num2str(subjects(subjectInd)) 'there are'  num2str(length (subRT)) ' RTs'])
            
        end
        AllsubRT(sample_cntr).RTvec=[AllsubRT(sample_cntr).RTvec ; subRT(1:189) ];
        
    end
    
    
% allsubs(sample_cntr).meanRT(1,:)=mean(AllsubRT)    
% allsubs(sample_cntr).meanRT(2,:)=std(AllsubRT)/sqrt(length(AllsubRT(:,1)))    
% 
% allsubs(sample_cntr).GmeanRT(1,:)=mean(AllsubRT,2)    
% allsubs(sample_cntr).GmeanRT(2,:)=std(mean(AllsubRT,2))/sqrt(length(AllsubRT(:,1)))    

end


figfig=figure;
hold on
for i=1:29  
 ContRT(i) =  mean(AllsubRT(1).RTvec(i,:));
plot(	 AllsubRT(1).RTvec(i,:)	,'-b')
end

for i=1:11
plot(	 AllsubRT(2).RTvec(i,:)	,'-r')
end
'lineprops',{'r-o','markerfacecolor','r'}


shadedErrorBar(	(1:189),allsubs(1).meanRT(1,:),	allsubs(1).meanRT(2,:)	,'lineprops',{'-b','markerfacecolor',[0,0,1]})
shadedErrorBar(	(1:189),allsubs(2).meanRT(1,:), allsubs(2).meanRT(2,:)	,'lineprops',{'-r','markerfacecolor',[1,0,0]})


legend('control','VMF patients' ,'Location','northwest')


ax = gca;  %% get handle to current axes
ax.XTick =1:12:189;
ax.XTickLabel =    {'1'   '2'   '3'   '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16'};

ax.FontSize = 14;

title('Reaction time for tone cue during training')
ylabel('RT (ms)','FontSize',16)
xlabel('Run','FontSize',16)

close(figfig)

%%
figure
hold on

conrolData=allsubs(1).GmeanRT(1,:)
patientsData=allsubs(2).GmeanRT(1,:)

bar(0.5,mean(conrolData),'FaceColor',[0 0 1],'EdgeColor',[0 0 0],'LineWidth',2)
bar(1.5,mean(patientsData),'FaceColor',[1 0 0],'EdgeColor',[0 0 0],'LineWidth',2)

errorbar(0.5,mean(conrolData),std(conrolData)/sqrt(length(conrolData)),'-k','LineWidth',2)
errorbar(1.5,mean(patientsData),std(patientsData)/sqrt(length(patientsData)),'-k','LineWidth',2)


ax = gca;  %% get handle to current axes

ax.XTick = [0.5 ,1.5 ];

ax.XTickLabel = {'control','VMF patients'};

ax.FontSize = 16;

title('Reaction time to tone cue during training')
ylabel('RT (ms)','FontSize',16)

