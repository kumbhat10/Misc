clc
%% 
actual_subject_to_search = 'Indian';         %% please  type your subject here  
%%
outlook = actxserver('Outlook.Application');
mapi=outlook.GetNamespace('mapi');
INBOX=mapi.GetDefaultFolder(6); %the code for the inbox being '6'.
count = INBOX.Items.Count; %index of the most recent email.
email=INBOX.Items.Item(count-1);
subject = email.get('Subject');
go=1;i=count+1;
while(go==1)
i=i-1;
email =    INBOX.Items.Item(i); 
subject = email.get('Subject');   
disp(['Reading currently ',int2str(count-i),' of ',int2str(count),' mail with subject:-   ',subject])   
if isempty( strfind(subject,actual_subject_to_search)) ==0  
attachments = email.get('Attachments');
    if attachments.Count >=1
        disp('');disp(' ')
    disp(['Found Mail with  ',int2str(attachments.Count),'  attachment in the mail with subject ',subject ]);    disp(' ');
    disp('Downloading attachments and saving.......')
    dir = pwd;   
    for i = 1:attachments.Count
        fname = attachments.Item(i).Filename;
        disp(fname)
    full = [pwd,'\',fname];
    attachments.Item(i).SaveAsFile(full);
    end
    go=2;
    end
end
end
disp(' ')
% sh = fopen('Indian Auto Industry Update 05th May 20161.doc','r');
sh = fopen(fname,'r');
wfile = fread(sh,'*char')';
fclose('all');
