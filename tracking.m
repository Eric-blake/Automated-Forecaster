function [res] = tracking(data1,data2)
   n = size(data1,1);
  sum = 0;
  for i=1 : n
    sum += (data1(i,1)-data2(i,1));
  endfor
  rsfe = sum;
  n = size(data1,1);
  sum = 0;
  for i=1 : n
    sum += abs(data1(i,1)-data2(i,1));
  endfor
  mad = sum/n;
  res = rsfe/mad;
endfunction
