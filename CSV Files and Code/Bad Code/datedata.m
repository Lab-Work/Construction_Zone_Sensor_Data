% Juan Carlos Martinez
% Last modified: 3/16/2015
% This function extracts the data of a given date.


function [sensordatamatrix] = datedata(timesensor,speedsensor,countsensor,date)

% Input the sensor times/dates.
timestr=datestr(timesensor);

% Find the row number of the first data of the given date.
n=1;
while ~(strcmpi(timestr(n,1:12),date))
    n=n+1;
end 

% Find the row number of the last data of the given date.
c=n;
while strcmpi(timestr(c,1:12),date)
    c=c+1;
end 

% Create matrix with only the data of the given date.
sensordatamatrix=[speedsensor(n:c-1),countsensor(n:c-1)];

end

