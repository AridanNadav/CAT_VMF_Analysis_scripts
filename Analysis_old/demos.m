%get_demographics

filename=dir([pwd '/EVA3_' '301' '_personalDetails*.txt']);
filename = filename.name;

delimiter = '\t';
startRow = 2;


formatSpec = '%s%f%s%f%f%f%s%[^\n\r]';

fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

sex= dataArray(4);

clearvars filename delimiter startRow formatSpec fileID dataArray ans;