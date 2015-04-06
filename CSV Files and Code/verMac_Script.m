% Juan Carlos Martinez
% This script is to be used with the verMac_Data class. 

clear

% Variables than can be replaced. 

% 1. replaced_speed replaces the NaN values of the speed columns of the
%    sensors read. This is saved in a different property within the same
%    class, so no information is lost.
% 2. replaced_speed replaces the NaN values of the count columns of the
%    sensors read. This is saved in a different property within the same
%    class, so no information is lost.
% 3. initial sets the beginning of the interval within which data is going
%    to be extracted. It MUST be in the format 'M/dd/yy HH:mm'. This is
%    saved in a different property within the same class, so no information
%    is lost.
% 4. final sets the end of the interval within which data is going
%    to be extracted. It MUST be in the format 'M/dd/yy HH:mm'. This is
%    saved in a different property within the same class, so no information
%    is lost.

replaced_speed=3;
replaced_count=0;
initial='11/26/14 00:00'; 
final='11/26/14 23:55'; 

% -------------------------------------------------------------------------

% Functions of verMac_Data are called. The configuration_file is called in
% the first function.

vermac_data = verMac_Data('verMac_Data_Description.txt');
vermac_data.read_all_files();
vermac_data.read_one_interval(initial,final);
vermac_data.clean_data(replaced_speed,replaced_count);
vermac_data.create_aimsun_file();



