% Juan Carlos Martinez
% Last modified: 3/18/2015
% This script gives the time axis for the plots.


index=strcat('SB1','.csv');
indextable=readtable(index);
timeindexarray=table2array(indextable(1:end,1));
timestr=datestr(timeindexarray);
timeindex=datetime(timeindexarray,'InputFormat','M/dd/yy HH:mm');

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
