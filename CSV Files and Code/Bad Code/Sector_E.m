% EB9, EB8, EB7, AND EB6.
% Juan Carlos Martinez
% February 8th, 2015
% Last Update: February 11th, 2015

eb9='EB9.csv';
eb8='EB8.csv';
eb7='EB7.csv';
eb6='EB6.csv';

eb9table=readtable(eb9);
eb8table=readtable(eb8);
eb7table=readtable(eb7);
eb6table=readtable(eb6);

speedeb9=table2array(eb9table(:,2));
speedeb8=table2array(eb8table(:,2));
speedeb7=table2array(eb7table(:,2));
speedeb6=table2array(eb6table(:,2));

timeeb9array=table2array(eb9table(1:end,1));
timeeb8array=table2array(eb8table(1:end,1));
timeeb7array=table2array(eb7table(1:end,1));
timeeb6array=table2array(eb6table(1:end,1));

timeeb9=datetime(timeeb9array,'InputFormat','M/dd/yy HH:mm');
timeeb8=datetime(timeeb8array,'InputFormat','M/dd/yy HH:mm');
timeeb7=datetime(timeeb7array,'InputFormat','M/dd/yy HH:mm');
timeeb6=datetime(timeeb6array,'InputFormat','M/dd/yy HH:mm');

figure
plot(timeeb9,speedeb9);
title('Speeds Sector E');
xlabel('Date and Time');
ylabel('Speed');
hold on
plot(timeeb8,speedeb8);
hold on
plot(timeeb7,speedeb7);
hold on
plot(timeeb6,speedeb6);
legend('EB9','EB8','EB7','EB6')
