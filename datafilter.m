function [resdata] = datafilter(data,n)
% this method is used to filter the data and split the data into 24 by n days format

resdata = zeros(24,n);
t=1;
for i=1 : n
  for j=1 : 24
    resdata(j,i) = data(t++);
  endfor
endfor
