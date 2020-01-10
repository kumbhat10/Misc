Str1='YL8_MU';
Str2='YL1_V1';
Str3='YL1_V2';
Str4='YL1_V3';
Str5='YL1_V4';
Str6='YL1_V5';
VEHICLEYL1 = 'YL1';
VEHICLEYL8 = 'YL8';
Staff_ID = '253200';

for i=2:6         %%%%5 please do not forget to change this next time (changed)
FoldName=sprintf('Str%d',i);
Folder = eval(FoldName);
ATapto = ['C:\Users\' Staff_ID '\Desktop\MDF2MAT\YL1'];
cd(ATapto)
clear ATapto
an = sprintf ('%d',i);
reportname1 = sprintf('%d',i-1);
chec = uint16(Folder);


MATDIR = ['C:\Users\' Staff_ID '\Desktop\MDF2MAT\' Folder];
cd(MATDIR);
Mat_File_Name1=dir('*.mat') ;
if isempty(Mat_File_Name1) == 0
    
for i = 1 : length(Mat_File_Name1);
copytomat = ['copy ' Mat_File_Name1(i).name ' C:\Users\' Staff_ID '\Desktop\MDF2MAT\YL1'];
system(copytomat)
end
end
clear t*
clear CAN*
end 









