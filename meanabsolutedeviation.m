function [res] = meanabsolutedeviation(data1,data2)
  n = size(data1,1);
  sum = 0;
  for i=1 : n
    sum += abs(data1(i,1)-data2(i,1));
  endfor
  res = sum/n;
endfunction
