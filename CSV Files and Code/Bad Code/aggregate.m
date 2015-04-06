% Juan Carlos Martinez
% Last modified: 3/17/2015
% This function aggregates the data into one hour intervals.

function [finalaggregatedmatrix] = aggregate(datamatrix)

% S is the number of intervals (24 intervals for 24 hours).

s=24;
aggregatedmatrix=zeros(s,2);
finalaggregatedmatrix=zeros(length(datamatrix),2);

w=1;
for i=1:s
    aggregatedmatrix(i,1)=mean(datamatrix((w:1:w+11),1));
    w=w+12;
end

w=1;
for i=1:s
    aggregatedmatrix(i,2)=sum(datamatrix((w:1:w+11),2));
    w=w+12;
end

w=1;
for i=1:s
    finalaggregatedmatrix(w:(w+11),1)=aggregatedmatrix(i,1);
    w=w+12;
end

w=1;
for i=1:s
    finalaggregatedmatrix(w:(w+11),2)=aggregatedmatrix(i,2);
    w=w+12;
end


end

