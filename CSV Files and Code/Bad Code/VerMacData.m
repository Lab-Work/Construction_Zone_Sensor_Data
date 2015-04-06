
classdef VerMacData < handle
    
    properties
        
        all_data;
        
        data_day;
        
        config_file;
        
    end
    
    
    methods
        %===============================================================
        % initialize object properties with all the raw data
        function obj = VerMacData(config_file_name)
            
            obj.config_file = config_file_name;
            
            obj.all_data = struct;
            
            obj.data_day = struct;
            
        end
        
        
        function readAllFiles(obj)
            
            % read all files specified in config_file
            % num_files from config_file
            
            % readtable
            
            for i=1:num_files
                
                sensorID = 'a string read from config_file';
                
                obj.all_data.(sensorID) = dlmread('file_name.csv');
                
            end
            
            
        end
        
        
        function readOneDay(obj, one_day_file_name, name)
            
            obj.data_day.(name) = dlmread('one_day_file_name.csv');
            
        end
        
        
        
        function cleanData(obj)
            % NaN -> 3 mph for velocity
            % NaN -> 0 for volume
            
        end
        
        
        function aimsunFormat(obj)
            
            % make sure data is in aimsun format
            
            % save those data in files for calibration 
            
        end
        
        
        
        
    end
    
end













