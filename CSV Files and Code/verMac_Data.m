% Juan Carlos Martinez
% class verMac_Data

% This class holds the information of the sensors specified in the
% configuration file, with data loaded from .csv files named after the 
% sensor IDs. These files contain information regarding the date and time,
% speed, and count gathered by each sensor. The .csv files must be named 
% after each sensorID (e.g., 'SB3.csv', where SB3 is the sensorID.
classdef verMac_Data < handle
    
   % 1. config_table is the table containing the information in the 
   %    configuration file (.txt). The sensor names in this table must
   %    include the .csv extension.
   % 2. all_data is the .csv file loaded into Matlab, using the filenames
   %    from config_table.
   % 3. interval_data is the data of all_data within a specific time
   %    interval. Initial and final times must be set in 'M/dd/yy HH:mm' 
   %    format in the script that calls this class.
   % 4. interval_clean_data is the interval_data with the NaN values
   %    replaced with specified values for speed and count, set in the 
   %    script.
   % 5. The sensor information (each) in a single file (.csv), in order to
   %    be read by Aimsun.
   
   properties
       config_table;
       all_data;
       interval_data;
       interval_clean_data; 
       aimsun_data_files;
   end
   
   
  
   methods
       
       % Initialize object properties.
       function obj=verMac_Data(config_file)
           obj.config_table=readtable(config_file);
           obj.all_data=struct;
           obj.interval_data=struct;
           obj.interval_clean_data=struct;
           obj.aimsun_data_files=struct;
       end
      
       % Read the .csv file, and update the all_data structure. The columns
       % of the file MUST be in this order: 1. Date and Time in 'M/dd/yy
       % HH:mm' format, 2. Speed, 3. Count. No columns can 
       function read_all_files(obj)
           
           % Evaluate the all_data structure for each sensorID
           % structure. sensorID is loaded from the config_file and
           % converteed into a string, used to read the file and update
           % all_data.
           
           % Find the sensorIDs from config_table, and update without .csv
           % extension.
           for index=1:height(obj.config_table)
               sensorID=obj.config_table(index,1);
               sensorID=table2cell(sensorID);
               sensorID=sensorID{1};
               sensorID=sensorID(1:(find(sensorID=='.')-1));
               
               % Update all_data structure.
               obj.all_data.(sensorID).table=readtable(strcat(sensorID,'.csv')); 
               
               % Find the width of the table to load the appropiate number
               % of columns (width). Columns MUST be in the following order: 
               % Date and time, Speed, Count. There cannot be columns
               % missing in between. 
               w=width(obj.all_data.(sensorID).table);
               
               % If column 1 exists, update date_time. If not, set [].
               if w>=1
                   obj.all_data.(sensorID).date_time=datetime(table2array(obj.all_data.(sensorID).table(:,1)),'InputFormat','M/dd/yy HH:mm');
                   obj.all_data.(sensorID).date_num=datenum(obj.all_data.(sensorID).date_time);
               else
                   obj.all_data.(sensorID).date_time=[];
                   obj.all_data.(sensorID).date_num=[];
                  
               end
               
               % If column 2 exists, update speed. If not, set [].
               if w>=2
                   obj.all_data.(sensorID).speed=table2array(obj.all_data.(sensorID).table(:,2));
               else
                   obj.all_data.(sensorID).speed=[];
               end
               
               % If column 3 exists, update speed. If not, set [].
               if w>=3
                   obj.all_data.(sensorID).count=table2array(obj.all_data.(sensorID).table(:,3)); 
               else
                   obj.all_data.(sensorID).count=[];
               end
               
           end
       end  
       
      
       % Extract the data for a specific time interval given from the 
       % variables initial and final, based on the all_data property and the
       % time interval set in the script.
       function read_one_interval(obj,initial,final)
           
           % Update initial and final to datenum, to match with
           % corresponding rows.
           initial=datenum(initial);
           final=datenum(final);
           
           % See same block in read_all_files function.
           for index=1:height(obj.config_table)
               sensorID=obj.config_table(index,1);
               sensorID=table2cell(sensorID);
               sensorID=sensorID{1};
               sensorID=sensorID(1:(find(sensorID=='.')-1));
               
               % Match the rows of the required interval, using inital and
               % final.
               i=find(obj.all_data.(sensorID).date_num==initial);
               f=find(obj.all_data.(sensorID).date_num==final);
           
               % Evaluate the interval_data structure for the specified
               % interval, for each sensorID.
               
               % If the date_time column is not empty, update the interval 
               % date_time and date_num on interval_data structure. 
               % Else, set as [].
               if not(isempty(obj.all_data.(sensorID).date_time))
                   obj.interval_data.(sensorID).date_time=obj.all_data.(sensorID).date_time(i:f);
                   obj.interval_data.(sensorID).date_num=obj.all_data.(sensorID).date_num(i:f);
               else
                   obj.interval_data.(sensorID).date_time=[];
                   obj.interval_data.(sensorID).date_num=[];
               end
               
               % If the speed column is not empty, update the speed data
               % within the interval on interval_data. Else, set as [].
               if not(isempty(obj.all_data.(sensorID).speed))
                   obj.interval_data.(sensorID).speed=obj.all_data.(sensorID).speed(i:f);
               else
                   obj.interval_data.(sensorID).speed=[];
               end
               
               % If the count column is not empty, update the count data
               % within the interval on interval_data. Else, set as [].
               if not(isempty(obj.all_data.(sensorID).count))
                   obj.interval_data.(sensorID).count=obj.all_data.(sensorID).count(i:f);
               else
                  obj.interval_data.(sensorID).count=[]; 
               end
               
           end
       end
      
       
       % Evaluate the clean data, replacing the NaN by a specified speed
       % and count (found in the script).
       function clean_data(obj,speed_rep,count_rep)
           
           % See same block in read_all_files function.
           for index=1:height(obj.config_table)
               sensorID=obj.config_table(index,1);
               sensorID=table2cell(sensorID);
               sensorID=sensorID{1};
               sensorID=sensorID(1:(find(sensorID=='.')-1));
               
               % Initializing with unclean data. date_time and date_num are
               % the same. This is done even if structure has [].
               obj.interval_clean_data.(sensorID).date_time=obj.interval_data.(sensorID).date_time;
               obj.interval_clean_data.(sensorID).date_num=obj.interval_data.(sensorID).date_num;
               obj.interval_clean_data.(sensorID).speed=obj.interval_data.(sensorID).speed;
               obj.interval_clean_data.(sensorID).count=obj.interval_data.(sensorID).count;
               
               % For each row, find NaN and replace with specified value.
               for i=1:length(obj.interval_data.(sensorID).date_num)
                   
                   % Replace NaN in the speed column. This works even if column is [].
                   if not(isempty(obj.interval_data.(sensorID).speed)) && isnan(obj.interval_clean_data.(sensorID).speed(i))
                       obj.interval_clean_data.(sensorID).speed(i)=speed_rep;
                   end
                   
                   % Replace NaN in the count column. This works even if column is []. 
                   if not(isempty(obj.interval_data.(sensorID).count)) && isnan(obj.interval_clean_data.(sensorID).count(i))
                       obj.interval_clean_data.(sensorID).count(i)=count_rep;
                   end
                   
               end
           end
       end
          
       
       %
       function create_aimsun_file(obj)
           
           % See same block in read_all_files function.
           for index=1:height(obj.config_table)
               sensorID=obj.config_table(index,1);
               sensorID=table2cell(sensorID);
               sensorID=sensorID{1};
               sensorID=sensorID(1:(find(sensorID=='.')-1));
               
               % Create variables to use as headers for table.
               dt_num=obj.interval_clean_data.(sensorID).date_num;
               speed=obj.interval_clean_data.(sensorID).speed;
               count=obj.interval_clean_data.(sensorID).count;
               
               % Round the speeds to the nearest integer.
               speed=round(speed);
               
               % dt_num is MATLAB numerical time.
               % dt_8601 is the ISO8601 time.
               dt_8601=cell(length(dt_num),1); % as a cell
               if ~isempty(dt_num)
                   for i=1:length(dt_num)
                       dt_8601{i,1}=datestr8601(dt_num(i,1),'*ymdHMS');
                   end
               end
               
               % Modified to save files.
               if not(isempty(dt_num)) && not(isempty(speed)) && not(isempty(count))
                    obj.aimsun_data_files.(sensorID) = table(dt_8601,speed,count);
                    writetable(obj.aimsun_data_files.(sensorID),...
                        strcat('AIMSUN_',sensorID,'.csv'),...
                        'Delimiter', ',');
               end
                
           end

      end
       
   end
end