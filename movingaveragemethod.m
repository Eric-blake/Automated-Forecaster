function [res] = movingaveragemethod(data , weight)
sum = 0;
n = size(data,1);
for i=1 : weight
  sum += data(28-weight+i);
endfor
res = sum/weight;
endfunction