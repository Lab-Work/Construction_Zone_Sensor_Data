% NB7, NB6, NB5, AND NB4.
% Juan Carlos Martinez
% February 8th, 2015
% Last Update: February 11th, 2015

nb7='NB7.csv';
nb6='NB6.csv';
nb5='NB5.csv';
nb4='NB4.csv';

nb7table=readtable(nb7);
nb6table=readtable(nb6);
nb5table=readtable(nb5);
nb4table=readtable(nb4);

speednb7=table2array(nb7table(:,2));
speednb6=table2array(nb6table(:,2));
speednb5=table2array(nb5table(:,2));
speednb4=table2array(nb4table(:,2));

timenb7array=table2array(nb7table(1:end,1));
timenb6array=table2array(nb6table(1:end,1));
timenb5array=table2array(nb5table(1:end,1));
timenb4array=table2array(nb4table(1:end,1));

timenb7=datetime(timenb7array,'InputFormat','M/dd/yy HH:mm');
timenb6=datetime(timenb6array,'InputFormat','M/dd/yy HH:mm');
timenb5=datetime(timenb5array,'InputFormat','M/dd/yy HH:mm');
timenb4=datetime(timenb4array,'InputFormat','M/dd/yy HH:mm');


figure
plot(timenb7,speednb7);
title('Speeds Sector N');
xlabel('Date and Time');
ylabel('Speed');
hold on
plot(timenb6,speednb6);
hold on
plot(timenb5,speednb5);
hold on
plot(timenb4,speednb4);


