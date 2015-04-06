% SB9, SB8, SB7, AND SB6.
% Juan Carlos Martinez
% February 8th, 2015
% Last Update: February 11th, 2015

sb9='SB9.csv';
sb8='SB8.csv';
sb7='SB7.csv';
sb6='SB6.csv';

sb9table=readtable(sb9);
sb8table=readtable(sb8);
sb7table=readtable(sb7);
sb6table=readtable(sb6);

speedsb9=table2array(sb9table(:,2));
speedsb8=table2array(sb8table(:,2));
speedsb7=table2array(sb7table(:,2));
speedsb6=table2array(sb6table(:,2));

timesb9array=table2array(sb9table(1:end,1));
timesb8array=table2array(sb8table(1:end,1));
timesb7array=table2array(sb7table(1:end,1));
timesb6array=table2array(sb6table(1:end,1));

timesb9=datetime(timesb9array,'InputFormat','M/dd/yy HH:mm');
timesb8=datetime(timesb8array,'InputFormat','M/dd/yy HH:mm');
timesb7=datetime(timesb7array,'InputFormat','M/dd/yy HH:mm');
timesb6=datetime(timesb6array,'InputFormat','M/dd/yy HH:mm');

figure
plot(timesb9,speedsb9);
title('Speeds Sector S');
xlabel('Date and Time');
ylabel('Speed');
hold on
plot(timesb8,speedsb8);
hold on
plot(timesb7,speedsb7);
hold on
plot(timesb6,speedsb6);
legend('SB9','SB8','SB7','SB6')
