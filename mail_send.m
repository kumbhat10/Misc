%pause(10)



for i = 1 : 10

h = actxserver('outlook.Application');
mail = h.CreateItem('olMail');
 
mail.To = 'kumbhat10@gmail.com';
mail.BodyFormat = 'olFormatHTML';
mail.HTMLBody = datestr(clock);    %'mona rona san';
% Add attachments, if specified.

mail.Send;
pause(900)
end