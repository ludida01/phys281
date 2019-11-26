

TITLE= 'Select the file with the data you want to bring into MATLAB';
[filename,filepath] = uigetfile('*.*', TITLE); %Prompts the user to select a data file
full_filename = fullfile( filepath, filename );

%T = readtable(full_filename,'ReadVariableNames',true);

[~,SheetNames] = xlsfinfo(full_filename);
nSheets = length(SheetNames);
Data = [];
for ii=1:nSheets
    Name =  SheetNames{ii};
    Data = [Data, xlsread(full_filename, Name)];
end


forward_voltage_V577 = Data(:,1);
forward_current_A577 = Data(:,2);
reverse_voltage_V577 = Data(:,4);
reverse_current_A577 = Data(:,5);

forward_voltage_V546 = Data(:,6);
forward_current_A546 = Data(:,7);
reverse_voltage_V546 = Data(:,9);
reverse_current_A546 = Data(:,10);

forward_voltage_V436 = Data(:,11);
forward_current_A436 = Data(:,12);
reverse_voltage_V436 = Data(:,14);
reverse_current_A436 = Data(:,15);

forward_voltage_V405 = Data(:,16);
forward_current_A405 = Data(:,17);
reverse_voltage_V405 = Data(:,19);
reverse_current_A405 = Data(:,20);

forward_voltage_V365 = Data(:,21);
forward_current_A365 = Data(:,22);
reverse_voltage_V365 = Data(:,24);
reverse_current_A365 = Data(:,25);


firstrun577 = forward_current_A577(1:301);
secondrun577 = forward_current_A577(302:602);
thirdrun577 = forward_current_A577(603:903);

averagecurrent577 = [];
for i = 1:301;
    averagecurrent577i = (firstrun577(i) + secondrun577(i) + thirdrun577(i))/3;
    averagecurrent577(i) =  averagecurrent577i;
end
voltagetouse577 = forward_voltage_V577(1:301);

plot(voltagetouse577, averagecurrent577, 'o');

