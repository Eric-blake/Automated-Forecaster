% initializing the vector t
t = [-5:0.001:5];

% converting radians into degree by multiplying x with pi by 180
%initializing all the given functions
f1 = @(x) cos(2*(x*3.14/180));
f2 = @(x) x^2+2*x+5;
f3 = @(x) x/(x+2);
a=0;
b=0;
c=0;
%taking values of each function by substituting t 
for i=1:length(t)
  a(i) = [f1(t(i))];
  b(i) = [f2(t(i))];
  if(t(i)!=-2)   %As the function becomes undefined due to dividion by zero
  c(i) = [f3(t(i))];
  end
endfor 
 plot(t,c); % Plot the data
 ylabel('Function'); % Set the y??axis label
 xlabel('t');
 
 
