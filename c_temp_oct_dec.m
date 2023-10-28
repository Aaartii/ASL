xlong=ncread('temp.nc','LON173_180');
lat=ncread('temp.nc','LAT180_187');
temp=ncread('temp.nc','TEMP');
depth=ncread('temp.nc','LEV1_19');

matrix_3d = squeeze(temp(:,:,1,:));
%disp(matrix_3d);

% Create an array to store the averages
averages = zeros(1, size(matrix_3d, 3));
%disp(averages);

% Loop through each 2D matrix in the 3D matrix and compute the average
for i = 1:size(matrix_3d, 3)
    averages(i) = mean(mean(matrix_3d(:,:,i)));
end

% Define the number of groups
numGroups = 140;

% Initialize an array to store the grouped averages
groupedAverages = zeros(1, numGroups);

% Loop through the groups and calculate the averages
for i = 1:numGroups
    startIndex = ((i-1) * 12) + 10;
    endIndex = ((i-1) * 12) + 12;
    groupedAverages_oct(i) = mean(averages(startIndex:endIndex));
end

% Display the grouped averages
disp(groupedAverages_oct);

% Assuming 'groupedAverages' contains your temperature data
% Make sure 'groupedAverages' has a different number of data points

% Define the time range for October to December from 1870 to 2010
time = 1870:2010;

% Resample the 'groupedAverages' vector to match the length of 'time'
resampledAverages = interp1(1:numel(groupedAverages_oct), groupedAverages_oct, linspace(1, numel(groupedAverages_oct), numel(time)));

% Create a line plotc_
plot(time, resampledAverages, 'b'); % 'b' specifies a blue line

% Label the axes
xlabel('Year');
ylabel('Temperature ');

% Title for the plot
title('Temperature from October-December (1870-2010)');

% Add grid lines (optional)
grid on;

% Show the plot
legend('Temperature');
