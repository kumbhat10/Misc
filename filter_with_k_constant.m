
%k=  0.5;

k = input('Enter the numerical value of filter constant k (from 0 to 1) :-  ');
xstring = input('Drag the Variable you want to apply filter to :- ','s');

x = eval(xstring);
%x(1) = 0;

for i=2:length(x)      %%ONLY FOR DIFFERENCE

x(i) = (x(i-1)*(1-k) )+(k * x(i)) ;

end
