%get_demographics


for subjInd=1:length(subjects)
filename=dir([outpath '/ccat_' num2str(subjects(subjInd)) '_personalDetails*.txt']);
if length(filename)>1
    warning(['sub ' num2str(subjects(subjInd)) ' has more than one "personalDetails" files '])
end

filename = filename.name;

delimiter = '\t';
startRow = 2;
formatSpec = '%s%f%s%f%f%f%s%[^\n\r]';

fileID = fopen([outpath filename],'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'sex__1isF__2isM'}=dataArray{4};
SampleSummeryTable{SampleSummeryTable{:,'sub'}==subjects(subjInd),'age'}=dataArray{5};


clearvars filename delimiter startRow formatSpec fileID dataArray ans;
end