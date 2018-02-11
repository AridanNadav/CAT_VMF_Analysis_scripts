for subjInd=1:length(subjects)
    subRT=[];
    subjects(subjInd)
    trainingRuns = dir([outpath '*' num2str(subjects(subjInd)) '_training_run*.txt']);
    jointTable={};
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
        
%         getRunRT=[runtable{runtable{:,'RT'}~=999000,'RT'}' ] ;
%         subRT=[subRT getRunRT];
        
        jointTable=[jointTable ; runtable];
    end
    %get rid of NOGO trials
    jointTable(jointTable{:,'RT'}==999000 | jointTable{:,'AudioTime'}==999000,:)=[];

    Keep_Training_data=[jointTable(:,[1 7 14]) array2table(jointTable{:,'RT'}-jointTable{:,'AudioTime'}, 'VariableNames',{'RT_cue'})];
    sample= ones(height(Keep_Training_data),1)*sample_cntr;
    Keep_Training_data= [Keep_Training_data table(sample)];
    Keep_Training_data.Properties.VariableNames{'bidIndex'} = 'Value_1high_2low';
    Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}<30,'Value_1high_2low'}=1;
    Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}>30,'Value_1high_2low'}=2;
    Keep_Training_data.Properties.VariableNames{'RT'} = 'RT_image';

    TrainingData=[TrainingData ; Keep_Training_data];
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_image_RT'}=mean(Keep_Training_data{:,'RT_image'});
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_image_RT_H'}=mean(Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}==1,'RT_image'});
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_image_RT_L'}=mean(Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}==2,'RT_image'});
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_cue_RT'}=mean(Keep_Training_data{:,'RT_cue'});
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_cue_RT_H'}=mean(Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}==1,'RT_cue'});
    SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'training_cue_RT_L'}=mean(Keep_Training_data{Keep_Training_data{:,'Value_1high_2low'}==2,'RT_cue'});

end