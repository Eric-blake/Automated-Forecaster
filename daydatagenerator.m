function [data] = daydatagenerator(YLD)
  %data is 24*365 data for each hour in a daydatagenerator
  %YLD is year long data available
  %this function computes the individual hour data from year long data
  
  data = zeros(24,365);
   for i=0 : 23
     m=0,n=0;
     for m=0 : 365
       data(i ,m) = YLD(n ,1);
       n = n+24;
     end
   end
   