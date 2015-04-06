% Juan Carlos Martinez
% Last modified: 3/16/2015
% This function extracts the data and returns only the sensors that have 
% complete data for the day specified.

function [indexday] = dataextraction(sensor,date)


% For each sensor string, add .csv, read the data, and find the dimensions.
index=strcat(sensor,'.csv');
indextable=readtable(index);
dimensions=size(indextable);

% If there is no data missing (vehicle #), extract data. If not, make the
% matrix for that sensor be empty.
    if dimensions(1,2)==3;
        
      speedindex=table2array(indextable(:,2));
      countindex=table2array(indextable(:,3));
      timeindexarray=table2array(indextable(1:end,1));
      timeindex=datetime(timeindexarray,'InputFormat','M/dd/yy HH:mm');
      
      indexday=datedata(timeindex,speedindex,countindex,date); 
      
    else
       indexday=[];
       
    end

end

