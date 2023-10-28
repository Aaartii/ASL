xlong=ncread('temp.nc','LON173_180');
lat=ncread('temp.nc','LAT180_187');
depth=ncread('temp.nc','LEV1_19');
salinity=ncread('sss.nc','SALT');

matrix_3d = squeeze(salinity(:,:,1,:));
%disp(matrix_3d);

% Create an array to store the averages
averages = zeros(1, size(matrix_3d, 3));
%disp(averages);

% Loop through each 2D matrix in the 3D matrix and compute the average
for i = 1:size(matrix_3d, 3)
    averages(i) = mean(mean(matrix_3d(:,:,i)));
end

% Define the number of elements in each group
groupSize = 12;

% Calculate the number of groups
numGroups = numel(averages) / groupSize;

% Initialize an array to store the grouped averages
groupedAverages = zeros(1, numGroups);

% Loop through the groups and calculate the averages
for i = 1:numGroups
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages(i) = mean(averages(startIndex:endIndex));
end

% Display the grouped averages
disp(groupedAverages);

time = 1870:2010;

% Resample the 'groupedAverages' vector to match the length of 'time'
resampledAverages = interp1(1:numel(groupedAverages), groupedAverages, linspace(1, numel(groupedAverages), numel(time)));

% Create a line plotc_
plot(time, resampledAverages, 'r'); % 'b' specifies a blue line

% Label the axes
xlabel('Year');
ylabel('Salinity ');

% Title for the plot
title('Salinity from Feb-April (1870-2010)');

% Add grid lines (optional)
grid on;

% Show the plot
legend('Salinity');

