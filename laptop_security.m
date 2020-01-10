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
     elseif username(1:6) == '204170'
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
      elseif username(1:6) == '228560'
     name = ('Mr.Anil San');     
      elseif username(1:6) == '242039'
     name = ('Mr.Pranay San');
     elseif username(1:6) == '214760'
     name = ('Mr.vinay San');     
      elseif username(1:6) == '527335'
     name = ('Mr.Ravi San');     
      elseif username(1:6) == '227927'
     name = ('Mr.Amit San');      
      elseif username(1:6) == '247120'
     name = ('Mr.Kartik San');      
      elseif username(1:6) == '243590'
     name = ('Mr.Ankur garg San'); 
     
else 
    name= ('Unknown');
end




pause on
disp('     ')
disp(['Hello ',name,'.......'])
pause(1)
disp('     ')
disp('Welcome to EN-2X department')
disp('Maruti Suzuki Engineering division ')
pause(2)
disp('........   ')

 pause(2)
 disp('Your entry log has been registered.......')
 disp('  ')
    disp('     ')
    disp(['Exiting program....byeeee  ',name,'   Have a nice day :)'])


 CopyDateInfo=[CopyDateInfo;date];
    format shortg
    c = clock;
    fix(c);
    TimeString=[int2str(c(4)) ':' int2str(c(5)) ':' int2str(c(6))];
    CopyTimeInfo=[CopyTimeInfo;TimeString];

sheetname      = 'Log';
LOGFILENAME='userlog.xls';

[number_value, ~ , ~]= xlsread('userlog.xls','Log','A2:A20000');

range_read = max(number_value)+3;

xlswrite('Data_Analysis_Fleet.xls',data,'Fleet_data_analysis',['A',int2str(write_range)]);











