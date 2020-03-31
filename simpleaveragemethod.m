function [res] = simpleaveragemethod(data)
  n= sizeof(data);
  res = (sum(data)/n);
  