function [res] = exponentialsmoothingmethod(data,sc)
  n = size(data,1);
  ft = data(1);
  f = 0;
  for i=1 : n
    f =ft + sc*(data(i)-ft);
  endfor
  res = f;
endfunction
