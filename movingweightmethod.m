function [res] = movingweightmethod(data,weight)
  sigma = 0;
  sum = 0;
  for i=1 : weight
    sigma += i;
  endfor
  for i=1 : weight
    sum += (data(1,28-weight+i)*i/sigma);
  endfor
  res = sum/weight;
endfunction
