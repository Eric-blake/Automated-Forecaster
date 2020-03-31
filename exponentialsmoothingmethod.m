function [res] = exponentialsmoothingmethod(data)
  n = size(data,1);
  sc = 0.2;
  ft = data(1);
  f = 0;
  for i=1 : n
    f =ft + sc*(data(i)-ft);
  endfor
  res = f;
endfunction
