% Juan Carlos Martinez
% Last modified: 3/16/2015
% This script creates the variable names and assigns them the data, using
% the data extraction functions.


% Input date in format '26-Nov-2014 '.
date='26-Nov-2014 ';

EB=[];
for i=1:1:9
   sensor = genvarname('EB', who);
   eval([sensor '=dataextraction(sensor,date);']);
end

SB=[];
for i=1:1:9
   sensor = genvarname('SB', who);
   eval([sensor '=dataextraction(sensor,date);']);
end

NB=[];
for i=1:1:7
   sensor = genvarname('NB', who);
   eval([sensor '=dataextraction(sensor,date);']);
end

% Cleanup
clear EB SB NB i sensor


