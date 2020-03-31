function [res] = lineartrendregression(data)

  y = data;
  n = 28;
  x = zeros(n,1);
  a=0;
  b=0;
  for i=1 : n 
    x(i,1) = i;
  endfor
  sx = sum(x);
  sy = sum(y);
  sxs = sum(x.^2);
  sxy = sum(y*x);
  if(sx!=0||sy!=0||sxs!=0||sxy!=0)
  {
  a = (sy*sxs-sx*sxy)/(n*sxs-sx*sx);
  b = (n*sxy-sx*sy)/(n*sxs-sx*sx);
  } 
  endif
  res = a + b*(x(n,1)+1);