% Juan Carlos Martinez
% Last modified: 3/18/2015
% This function plots the data.

function [] = sensorplots(sensor,timestr,timeindex)


date='26-Nov-2014 ';

n=1;
while ~(strcmpi(timestr(n,1:12),date))
    n=n+1;
end 
c=n;
while strcmpi(timestr(c,1:12),date)
    c=c+1;
end 

timeindex=timeindex(n:c-1);


figure (1)
plot(timeindex,sensor(:,1),'b')
title('Speed Data: November 26 2015');
xlabel('Date and Time');
ylabel('Speed');
hold on


%figure (2)
%plot(timeindex,sensor(:,2))
%title('Count Data: November 26 2015');
%xlabel('Date and Time');
%ylabel('Count');
%hold on




end

