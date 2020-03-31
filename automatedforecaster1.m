 clear ; close all; clc;

%%======Load data=====%%

data = load('kkwind.txt');
X = data(:, 1);

%%===========select date============
 
 promt=" Enter date[dd mm]:";
   date =input(promt);
   nod = 0;
      for i = 1:(date(2)-1)
         if(i==1||i==3||i==5||i==7||i==8||i==10||i==12)
           nod+=31;
         end
         if(i==4||i==6||i==9||i==11)
           nod+=30;
         end  
         if(i==2)
             nod+=28;
         end
       end 
    nod=nod+date(1);
    fprintf("Number of day:%d\n",nod);

%%===========data filter from entire data=============

maxd = (nod-1)*24;
mind = (nod-29)*24+1;
testday = nod*24; 
  xdata = X(mind:maxd, 1);
  testdatax = X(((nod-1)*24+1):testday, 1);

%%%===========day data generator======%%%%
traindata = datafilter(xdata,28);
%%%===========time series forecasting =====%%%

fdata1 = zeros(24,1);
fdata2 = zeros(24,1);
fdata2s = zeros(24,1);
fdata3 = zeros(24,1);
fdata3s = zeros(24,1);
fdata4 = zeros(24,1);
fdata5 = zeros(24,1);
fdata = zeros(24,1);


%%%%%%calculating and optimising the forecasts from various methods
wt1=[2:1:27];
wt2=[2:1:27];
sc =[00.01:0.01:0.99];
t = true;
pt = 3;
nt = -3;

 for i=1 :24
   fdata1(i,1) = simpleaveragemethod(traindata(i,:));
   fdata5(i,1) = lineartrendregression(traindata(i,:));
 endfor
 
 for i=1 : 24
    fdata2s(i,1) = movingweightmethod(traindata(i,:),wt1(i));
      if(tracking(fdata2s,testdatax)<pt&&tracking(fdata2s,testdatax)>nt)
        fdata2 = fdata2s; 
        break; 
      end
 endfor
 
 for i=1 : 24
    fdata3s(i,1) = movingaveragemethod(traindata(i,:),wt2(i));
      if(tracking(fdata3s,testdatax)<pt&&tracking(fdata3s,testdatax)>nt)
        fdata3 = fdata3s;
        break;
      end
 end
 
 for i=1 : length(sc)
   for j=1:24
    fdata4s(j,1) = exponentialsmoothingmethodmodified(traindata(j,:),sc(i));
   end
   if(tracking(fdata4s,testdatax)<pt&&tracking(fdata4s,testdatax)>nt)
     fdata4 = fdata4s;
     break; 
   end
 endfor
 %%%tracking of best methods among the 5 for the data
trackdata = zeros(24,6);
trackdata(:,1) = fdata1(:,1);
trackdata(:,2) = fdata2(:,1);
trackdata(:,3) = fdata3(:,1);
trackdata(:,4) = fdata4(:,1);
trackdata(:,5) = fdata5(:,1);
track =zeros(1,6);
track(1,1) = tracking(fdata1,testdatax);
track(1,2) = tracking(fdata2,testdatax);
track(1,3) = tracking(fdata3,testdatax);
track(1,4) = tracking(fdata4,testdatax);
track(1,5) = tracking(fdata5,testdatax);
track(1,6) = 0;
temp=max=-1;

for i=1 : 5
  for j=i : 5
    if(max<abs(track(1,j)))
      max = abs(track(1,j));
      temp = j;
    end
  endfor
  trackdata(:,6) = trackdata(:,i);
  track(1,6) = track(1,i);
  trackdata(:,i) = trackdata(:,temp);
  track(1,i) = track(1,temp);
  trackdata(:,temp) = trackdata(:,6);
  track(1,temp) = track(1,6);
  
endfor
%%%%setting up an infinite loop until the required approximations are met.
loop =1;
p0 = 1/15; p1 = 2/15; p2 = 3/15; p3 = 4/15; p4 = 5/15;
while(t)
  for i=1 : 24
    fdata(i,1) = p0*trackdata(i,1) + p1*trackdata(i,2) + p2*trackdata(i,3) + p3*trackdata(i,4) + p4*trackdata(i,5); 
  end
  p0 = p0+0.001;
  p1 = p1+0.001;
  if(p3>=0.001)
    p3 = p3-0.001;
  end
  if(p4>=0.001)
    p4 = p4-0.001;
  end
  if(tracking(fdata,testdatax)<+2&&tracking(fdata,testdatax)>=-2)
    t = false;
  end
 loop++
end
fdata