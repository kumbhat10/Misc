

a = dir('*.asc');

for dush = 1:length(a)
    
filename = a(dush).name;


 %%Syntax 
% M_IMPORT(filename)
% Description
%This function import the file from ASCII to MATLAB workspace  
% Input- filename 
% Output- None
% User have to give the file name in single quato mark
% Eg.-   M_ASC_IMPORT('test_asc.asc')
%
% Created by- Mona Agrahari
% Date- 26-April-2014

%evalin('base', 'clear all; %clc;');

tic;

%% Initialize variables.
% filename = 'test_asc.asc';
delimiter = '\t';

%% Format string for each line of Ascii:
%   column1: text (%s)
%	column2: text (%s)
%   column3: text (%s)
%	column4: text (%s)
%   column5: text (%s)
%	column6: text (%s)
%   column7: text (%s)
%	column8: text (%s)
%   column9: text (%s)
%	column10: text (%s)
%   column11: text (%s)
%	column12: text (%s)
%   column13: text (%s)
%	column14: text (%s)
%   column15: text (%s)
%	column16: text (%s)
%   column17: text (%s)
%	column18: text (%s)
%   column19: text (%s)
%	column20: text (%s)
%   column21: text (%s)
%	column22: text (%s)
%   column23: text (%s)
%	column24: text (%s)
%   column25: text (%s)
%	column26: text (%s)
%   column27: text (%s)
%	column28: text (%s)
%   column29: text (%s)
%	column30: text (%s)
%   column31: text (%s)
%	column32: text (%s)
%   column33: text (%s)
%	column34: text (%s)
%   column35: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the Ascii file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. 
dataArray = textscan(fileID, formatSpec, 'Delimiter',delimiter,  'ReturnOnError', false);
assignin('base','dataArray',dataArray);
%% Close the text file.
fclose(fileID);


%% Allocate imported array to column variable names
MagnetiMarelli = dataArray{:, 1};
assignin('base','MagnetiMarelli',MagnetiMarelli);
HELIOS = dataArray{:, 2};
assignin('base','HELIOS',HELIOS);
Vers1276 = dataArray{:, 3};
assignin('base','Vers1276',Vers1276);
Date = dataArray{:, 4};
assignin('base','Date',Date);
size_of_dataarray_1 = size(dataArray);
assignin('base','size_of_dataarray_1',size_of_dataarray_1);

%% Clear temporary variables
%clearvars  delimiter formatSpec fileID dataArray ans;
%%

%%find number of data colums in data

size_1 = size(MagnetiMarelli);
size_1_L = size_1(1,1);
J1=-1;

for i1 = 1:size_1_L
  
     [token1,token2] = strtok(MagnetiMarelli(i1,1), '.');
    
     if (strcmp(token1{1,1},'Ch')==1)
         J1 =J1+1;
        Data_columns =  strtok(token2, '.');
        Data_columns =  strtok(Data_columns, ':');
        Data_columns = str2double(Data_columns);
        Data_columns = J1;
     end
    
end

str_formating_1 = '%f';
str_formating ='';

for i=1:J1
    
    str_formating = strcat(str_formating,str_formating_1);
    
end  

 str_formating = strcat(str_formating,'%[^\n\r]');

%assignin('base',' str_formating', str_formating);



%%
ax = size(HELIOS);
m=ax(1,1);
data_start_row =0;

for i=1:m
    
    if strcmp(HELIOS(i,1),'Ch. 2')
        data_start_row = i+1;
        break;
    end
    
end


HELIOS1 = HELIOS';
%assignin('base','HELIOS',HELIOS);

data_end_row = size(HELIOS);
data_end_row = data_end_row(1,1);
assignin('base','data_end_row',data_end_row);



%% Initialize variables.
%filename = 'test_asc.asc';
delimiter = '\t';
startRow = data_start_row;
%startRow = 79;
assignin('base','startRow',startRow);
endRow = data_end_row;
assignin('base','endRow',endRow);
% For more information, see the TEXTSCAN documentation.
%formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
formatSpec = str_formating;
assignin('base','formatSpec',formatSpec);
%% Open the text file.
fileID = fopen(filename,'r');
assignin('base','fileID',fileID);

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. 
textscan(fileID, '%[^\n\r]', startRow-1, 'ReturnOnError', false);

dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'ReturnOnError', false);
assignin('base','dataArray',dataArray);
%% Close the text file.
fclose(fileID);


%% Create output variable
testasc = [dataArray{1:end-1}];
assignin('base','testasc',testasc);
%% Clear temporary variables
%clearvars  delimiter startRow endRow formatSpec fileID dataArray ans;



%%


ax = size(MagnetiMarelli);
m=ax(1,1);
singal_name_start_row =0;

for i=1:m
    
    if strcmp(MagnetiMarelli(i,1),'Ch. 1:')
        singal_name_start_row = i;
        break;
    end
    
end

i=int8(singal_name_start_row);
j=int8(1);
%l = size(testasc);
%testasc1 = testasc(2:l(1),:);
%% This will find the signal names in a row till that time when it do not get any space

while(strcmp(HELIOS(i,1),'') == 0)

str_test = HELIOS(i,1);

[str_test,str_test2]=  strtok(str_test, '_');
[str_test2,str_test3]=  strtok(str_test2, '_');
    
    if (strcmp(str_test(1,1),'@')==1)
    
    Str_2 = strcat(str_test2,str_test3);
   assignin('base','Str_2',Str_2);
    Str_1 = strcat(Str_2,'=testasc','(:,',num2str((j)),');');
%     evalin('base',char(Str_1(1,1)));
%    assignin('base','char(Str_1(1,1))',char(Str_1(1,1)));
    
    j=j+1;
    i=i+1;
        
    else
    
    Str_2 = strcat('HELIOS(',num2str((i)),',1);');
%     evalin('base',Str_2);
     assignin('base','Str_2',Str_2);
    Str_1 = strcat(HELIOS(i,1),'=testasc','(:,',num2str((j)),');');
   evalin('base',char(Str_1(1,1)));
    %assignin('base','char(Str_1(1,1))',char(Str_1(1,1)));
    j=j+1;
    i=i+1;
    end
    
end


evalin('base', 'clearvars testasc size_of_dataarray_1 fileID formatSpec startRow endRow Date Str_2 MagnetiMarelli HELIOS Vers1276 dataArray ans ax Data_columns data_end_row data_start_row Date HELIOS HELIOS1 i i1 j J1 m MagnetiMarelli singal_name_start_row size_1 size_1_L size_of_dataarray_1 Str_1 Str_2 str_formating str_formating_1 str_test str_test2 str_test3 testasc token1 token2 Vers1276')


% ff = [int2str(dush),'_18.mat'];
ff = [filename,'.mat'];
save(ff)
clear ff
toc;
end