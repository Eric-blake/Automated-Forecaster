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
  testdatax = X(((nod-1)*24):testday, 1);

%%%===========day data generator======%%%%
traindata = datafilter(xdata,28);
%%%===========time series forecasting =====%%%

fdata1 = zeros(24,1);
fdata2 = zeros(24,1);
fdata3 = zeros(24,1);
fdata4 = zeros(24,1);
fdata5 = zeros(24,1);

for i=1 : 24
  fdata1(i,1) = simpleaveragemethod(traindata(i,:));
  fdata2(i,1) = movingweightmethod(traindata(i,:),3);
  fdata3(i,1) = movingaveragemethod(traindata(i,:),3);
  fdata4(i,1) = exponentialsmoothingmethod(traindata(i,:));
  fdata5(i,1) = lineartrendregression(traindata(i,:));
end
%%%%=======accuraciescheck======%%%%

fprintf('Simpleaveragemethod \n    Mean Absolute Deviation : %f\n    Bias : %f\n    Running Sum Forecast Error : %f\n    Tracking Signal : %f\n',meanabsolutedeviation(fdata1,testdatax),bias(fdata1,testdatax),RSFE(fdata1,testdatax),tracking(fdata1,testdatax));
fprintf('Movingweightmethod \n    Mean Absolute Deviation : %f\n    Bias : %f\n    Running Sum Forecast Error : %f\n    Tracking Signal : %f\n',meanabsolutedeviation(fdata2,testdatax),bias(fdata2,testdatax),RSFE(fdata2,testdatax),tracking(fdata2,testdatax));
fprintf('Movingaveragemethod \n    Mean Absolute Deviation : %f\n    Bias : %f\n    Running Sum Forecast Error : %f\n    Tracking Signal : %f\n',meanabsolutedeviation(fdata3,testdatax),bias(fdata3,testdatax),RSFE(fdata3,testdatax),tracking(fdata3,testdatax));
fprintf('ExponentialSmoothingMethod \n    Mean Absolute Deviation : %f\n    Bias : %f\n    Running Sum Forecast Error : %f\n    Tracking Signal : %f\n',meanabsolutedeviation(fdata4,testdatax),bias(fdata4,testdatax),RSFE(fdata4,testdatax),tracking(fdata4,testdatax));
fprintf('Linear Trend Regression \n    Mean Absolute Deviation : %f\n    Bias : %f\n    Running Sum Forecast Error : %f\n    Tracking Signal : %f\n',meanabsolutedeviation(fdata5,testdatax),bias(fdata5,testdatax),RSFE(fdata5,testdatax),tracking(fdata5,testdatax));
