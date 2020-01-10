function y = copypaste(w)

%%
[s,username] = dos('ECHO %USERNAME%');
[MM,NN]=size(username);
 newdata_UserName= {username(1:NN-1)};
 
 
[s,computername] = dos('ECHO %COMPUTERNAME%');
[MM,NN]=size(computername);
newdata_SrcPCNo= {computername(1:NN-1)};
sheetname      = 'Log';
Column_SNo     ='A'; 

if username(1:6) == '248800'
     name = ('Mr.Vibhor Jajoo San');
elseif username(1:6) == '253200'
     name = ('Mr.Dushyant Kumbhat San');
elseif username(1:6) == '228710'
     name = ('Mr.Imran san');
     elseif username(1:6) == '244260'
     name = ('Miss Mona-rona San');
     elseif username(1:6) == '254215'
     name = ('Mr.Rahul San');
     elseif username(1:6) == '204170'+
     name = ('Mr.Harish Chandra San');
     elseif username(1:6) == '252042'
     name = ('Mr.Suryakant San');
     elseif username(1:6) == '250678'
     name = ('Mr.Prateek Farzi San :P');
     elseif username(1:6) == '252948'
     name = ('Mr.Mayank San');
      elseif username(1:6) == '249874'
     name = ('Mr.Ram San :P');
      elseif username(1:6) == '251054'
     name = ('Mr.Rakshit San');
else 
    name= ('dushyant');
end
%%
pause on
disp('     ')
disp(['Hello ',name,'.......'])
pause(1)
disp('     ')
disp('Welcome to EN-2X Calibration and testing team at Maruti Suzuki Engineering division ')
pause(1)
disp('........   ')
[s,r] = dos(['wmic logicaldisk where drivetype=2 get deviceid, volumename, description']);
disp('     ')
disp('Please wait initializing program......   ')
pause(1)
disp('.........   ')
pause(1)
disp('      ')
disp('Scanning for removable disk drive.........')
pause(1)
if length(r)<40
    disp('     ')
    disp('No removable disk inserted. Please check and re-insert removable disk and then re-run the program')
    pause(2)
    disp('     ')
    disp(['Exiting program ..byeeee  ',name,'   Have a nice day :)'])
         errordlg(['No removable disk inserted. Please check and re-insert removable disk and then re-run program....Have a nice day ',name])
    pause(4)     
     return
end
if length(r)==82 
    disp('')
    attempt=1; 
    if r(57)=='E'
     source= ('E:\media');
     disp('   ')
     disp ('Found removable disk (E:\)')
      pause(1)
     elseif r(57)=='F'
     source= ('F:\media'); 
     disp('   ')
     disp ('Found removable disk (F:\)')
      pause(1)
     end
end      
if length(r)==122
disp('      ')
    disp('Found 2 Removable disk drives inserted :-  E:\ and F:\')
     pause(2)
attempt=2;
end
%%

cur=cd;
des=('\\multad\EN2X_Fleet\07_Vbox_files');
LOGFILEDIR= ('\\multad\EN2X_Fleet\07_Vbox_files');
cd(LOGFILEDIR);
disp('    ')
disp(['Checking if LogFiles are present at ',LOGFILEDIR,'.........'])
pause(1)
checklog = exist('YL8_FileLog.xls');
if checklog == 2
    checklog1 = exist('YL1_FileLog.xls');
    if checklog1 == 2
      disp('   ')
        disp(['Both  YL8_FileLog.xls and  YL1_FileLog.xls  were found successfully at ',LOGFILEDIR])
     pause(2)
    else 
    disp(['YL1_FileLog.xls was not found at ',LOGFILEDIR])
    return
    end
else
     disp(['YL8_FileLog.xls was not found at ',LOGFILEDIR])
end

%%
for xx = 1:attempt
   
    if xx==1 && attempt==2
        source= ('E:\media');
    elseif xx==2 && attempt==2
        source= ('F:\media');
    end
    
cd(source);
disp(['Checking if data at ',source,' is of YL8 or YL1']) 
pause(1)

check8 = exist ('yl8');
if check8 ==7
    model='YL8_ISG';
    LOGFILENAME='YL8_FileLog.xls';
    disp('     ')
    disp(['YL8 data was found at ',source])
    pause(1)
else
    check1 = exist('yl1');
    if check1 == 7
    model='YL1_ISG';
    LOGFILENAME='YL1_FileLog.xls';
    disp('   ')
     disp(['YL1 data was found at ',source])
    pause(1)
    else 
        disp('    ')
        disp(['Cannot find YL8 or YL1 named folder .Please ensure yl8 or yl1 named folder is present at ',source,' folder.....'])
        errordlg(['Please ensure yl8 or yl1 named folder is present at ',source,' folder'])
        pause(2)
        disp('   ')
        disp(['Exiting program.....bye ',name,' Have a nice day.......'])        
        pause(2)
        return
    end
end

FILE_TYPE1= ('.vbo');
j=0;

newdata_SrcLoc={source};

for x= 1:2
    
disp('  ')
cd(source);
z=['*',FILE_TYPE1];
FileType1 = dir(z);
N= length(FileType1);
pause(1)
disp(['Scanning ',source,' for ',FILE_TYPE1,' files........'])
pause(1)
if N==0
    errordlg(['No',FILE_TYPE1,' Files found at ',source,' to Copy!'])
    disp('   ')
    disp(['No ',FILE_TYPE1,'files found at ',source])
    pause(1)
    cd(cur);
   j=1;
else
    disp('    ')
    disp(['Total ', int2str(N),' ',FILE_TYPE1,' files found at ',source]);
pause(1)
    j=0;
end

if j==0
cd(source);
 
disp('   ')
disp(['renaming',FILE_TYPE1,' files present at ',source,'........']);
pause(1)
for i= 1:N
[s, r] = dos(['rename "',FileType1(i).name,'" ',model,'_',FileType1(i).date(1:11),'_',FileType1(i).date(13:14),'_',FileType1(i).date(16:17),'_',FileType1(i).date(19:20),FILE_TYPE1], '-echo');
end

FileType1 = dir(z);
disp( '      ' )

disp(['Copying ',FILE_TYPE1,' files  from ',source,' to ',des,'..........']);
disp('    ')
if N >0
       [s, r] = dos(['copy *',FILE_TYPE1,' ',des], '-echo');
    if s==1 
        disp(' Error in copy to MULTAD. Operation aborted.')   
        errordlg('Error in copy to MULTAD. Operation aborted.')
            cd(cur);
            pause(1)
            return
    end
end
disp('    ')
disp(['Checking copied files at ',des,'.........'])
pause(1)
cd(des); 
CopyDateInfo=[];
CopyTimeInfo=[];
FileSizeInfo=[]; 

for i=1:N
        
         [s,r]=dos(['if exist "',FileType1(i).name,'" (echo OK) else (echo NG)']);
         result=strfind(r,'OK');
             if s==1 
            errordlg('Error in DOS command')
             elseif s == 0 &&  isempty(result)>0 
                disp('One or more file were not copied in destination directory. Aborting Script!')
                 errordlg('One or more file were not copied in destination directory. Aborting Script!')
                pause(1)
                cd(cur);
                return
             end
    CopyDateInfo=[CopyDateInfo;date];
    format shortg
    c = clock;
    fix(c);
    TimeString=[int2str(c(4)) ':' int2str(c(5)) ':' int2str(c(6))];
    CopyTimeInfo=[CopyTimeInfo;TimeString];
    DirInfo = dir(FileType1(i).name);
    FileSize = DirInfo.bytes/1024; %Convert bytes to kilo bytes
    FileSizeInfo=[FileSizeInfo;round(FileSize)];
    disp(' ')
end
disp('  ')
disp(['Finished copying and renaming ',FILE_TYPE1 ,' files !'])
disp(' ')
pause(1)
disp(['writing log in  ',LOGFILENAME,' file...........' ])

disp('  ' )
 
[~,~,Data]=xlsread(LOGFILENAME,sheetname);
SN=size(Data,1);
SN_New=SN;

for i=1:SN
    
x=Data(SN_New,1);
x=x{1,1};
    if isnan(x)
        SN_New=SN_New-1;
    end
end

SN=SN_New-1;
nextRow=SN_New+1;

for i = 1:N 
[s, r] = dos(['rename "',FileType1(i).name,'" ',model,'_',FileType1(i).date(1:11),'_',FileType1(i).date(13:14),'_',FileType1(i).date(16:17),'_',FileType1(i).date(19:20),FILE_TYPE1], '-echo');
range_SNo       = sprintf('%s%d',Column_SNo,nextRow); 

newdata_SNo     = SN+i;
newdata_Date    = {CopyDateInfo(i,:)};
newdata_Time    = {CopyTimeInfo(i,:)};
newdata_FileName= {[model,'_',FileType1(i).date(1:11),'_',FileType1(i).date(13:14),'_',FileType1(i).date(16:17),'_',FileType1(i).date(19:20)]};
newdata_FileSize= {FileSizeInfo(i,:)};
newdata_filetype = {FILE_TYPE1};

totaldata  = [newdata_SNo newdata_Date newdata_Time newdata_UserName model newdata_FileName newdata_filetype newdata_FileSize newdata_SrcPCNo newdata_SrcLoc];
xlswrite(LOGFILENAME,totaldata,sheetname,range_SNo);
nextRow=nextRow+1;
end


disp('   ')
disp(['Finished Writing log of ',FILE_TYPE1 ,' files of model ',model])
pause(1)
end
FILE_TYPE1 = ('.avi');
disp(' ')
end

if j==0
disp('   ')
    disp(['Deleting files from ',source,' .......'])
    pause(1)
cd(source);
recycle on;
delete *.avi
delete *.vbo
disp('     ')
disp(['Files deleted successfully from ',source,'...... '])
disp('    ')
pause(1)
end
end
%%


disp(['Finished all tasks successfully '])
disp('   ')
pause(1)
disp(['Exiting from program now......bye bye ',name,' Have a nice day '])
pause(2)
disp('   ')
disp('Opening destination folder and LOG Files.......')
pause(2)

cd(des);

if attempt==2
[s, r] = dos(['explorer ',des,'\YL8_FileLog.xls'], '-echo');
[s, r] = dos(['explorer ',des,'\YL1_FileLog.xls'], '-echo');

elseif attempt==1
    
    [s, r] = dos(['explorer ',des,'\',LOGFILENAME], '-echo');
    
end

[s, r] = dos(['explorer ',des], '-echo');

msgbox(['Finished all tasks successfully. Have a nice day ahead ',name])
pause(4)

