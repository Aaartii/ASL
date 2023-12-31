% Your existing code for temperature data
xlong_temp = ncread('temp.nc', 'LON173_180');
lat_temp = ncread('temp.nc', 'LAT180_187');
temp = ncread('temp.nc', 'TEMP');
depth_temp = ncread('temp.nc', 'LEV1_19');

matrix_3d_temp = squeeze(temp(:, :, 1, :));

% Your existing code for salinity data
xlong_salinity = ncread('temp.nc', 'LON173_180');
lat_salinity = ncread('temp.nc', 'LAT180_187');
salinity = ncread('sss.nc', 'SALT');
depth_salinity = ncread('sss.nc', 'LEV1_19');
% Your existing code for temperature data
xlong_temp = ncread('temp.nc', 'LON173_180');
lat_temp = ncread('temp.nc', 'LAT180_187');
temp = ncread('temp.nc', 'TEMP');
depth_temp = ncread('temp.nc', 'LEV1_19');

matrix_3d_temp = squeeze(temp(:, :, 1, :));

% Your existing code for salinity data
xlong_salinity = ncread('temp.nc', 'LON173_180');
lat_salinity = ncread('temp.nc', 'LAT180_187');
salinity = ncread('sss.nc', 'SALT');
depth_salinity = ncread('sss.nc', 'LEV1_19');

matrix_3d_salinity = squeeze(salinity(:, :, 1, :));

% Initialize arrays to store the averages
averages_temp = zeros(1, size(matrix_3d_temp, 3));
averages_salinity = zeros(1, size(matrix_3d_salinity, 3));

% Loop through each 2D matrix in the 3D matrix and compute the averages for temperature
for i = 1:size(matrix_3d_temp, 3)
    averages_temp(i) = mean(mean(matrix_3d_temp(:, :, i)));
end

% Loop through each 2D matrix in the 3D matrix and compute the averages for salinity
for i = 1:size(matrix_3d_salinity, 3)
    averages_salinity(i) = mean(mean(matrix_3d_salinity(:, :, i)));
end

% Define the number of elements in each group
groupSize = 12;

% Calculate the number of groups
numGroups_temp = numel(averages_temp) / groupSize;
numGroups_salinity = numel(averages_salinity) / groupSize;

% Initialize arrays to store the grouped averages
groupedAverages_temp = zeros(1, numGroups_temp);
groupedAverages_salinity = zeros(1, numGroups_salinity);

% Loop through the groups and calculate the averages for temperature
for i = 1:numGroups_temp
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_temp(i) = mean(averages_temp(startIndex:endIndex));
end

% Loop through the groups and calculate the averages for salinity
for i = 1:numGroups_salinity
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_salinity(i) = mean(averages_salinity(startIndex:endIndex));
end

% Create time vector from 1 to 140 years
time = 1:numGroups_temp;

% Create a figure for the plot
figure;

% Plot groupedAverages_temp as blue points
subplot(2, 1, 1); % Two rows, one column, first subplot
plot(time, groupedAverages_temp, 'bo-', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Temperature');
xlabel('Years');
ylabel('Grouped Average Temperature (\circC)');
title('Grouped Average Temperature Over Time');

% Calculate the linear regression for temperature
coeff_temp = polyfit(time, groupedAverages_temp, 1); % Linear regression coefficients
linear_fit_temp = polyval(coeff_temp, time); % Values on the linear regression line

% Plot the linear regression line for temperature
hold on;
plot(time, linear_fit_temp, 'b-', 'LineWidth', 2, 'DisplayName', 'Temperature Regression');

% Add a legend to label the curves for temperature
legend('Location', 'Northwest');

% Plot groupedAverages_salinity as red points
subplot(2, 1, 2); % Two rows, one column, second subplot
plot(time, groupedAverages_salinity, 'ro-', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Salinity');
xlabel('Years');
ylabel('Grouped Average Salinity');
title('Grouped Average Salinity Over Time');

% Calculate the linear regression for salinity
coeff_salinity = polyfit(time, groupedAverages_salinity, 1); % Linear regression coefficients
linear_fit_salinity = polyval(coeff_salinity, time); % Values on the linear regression line

% Plot the linear regression line for salinity
hold on;
plot(time, linear_fit_salinity, 'r-', 'LineWidth', 2, 'DisplayName', 'Salinity Regression');

% Add a legend to label the curves for salinity
legend('Location', 'Northwest');

matrix_3d_salinity = squeeze(salinity(:, :, 1, :));

% Initialize arrays to store the averages
averages_temp = zeros(1, size(matrix_3d_temp, 3));
averages_salinity = zeros(1, size(matrix_3d_salinity, 3));

% Loop through each 2D matrix in the 3D matrix and compute the averages for temperature
for i = 1:size(matrix_3d_temp, 3)
    averages_temp(i) = mean(mean(matrix_3d_temp(:, :, i)));
end

% Loop through each 2D matrix in the 3D matrix and compute the averages for salinity
for i = 1:size(matrix_3d_salinity, 3)
    averages_salinity(i) = mean(mean(matrix_3d_salinity(:, :, i)));
end

% Define the number of elements in each group
groupSize = 12;

% Calculate the number of groups
numGroups_temp = numel(averages_temp) / groupSize;
numGroups_salinity = numel(averages_salinity) / groupSize;

% Initialize arrays to store the grouped averages
groupedAverages_temp = zeros(1, numGroups_temp);
groupedAverages_salinity = zeros(1, numGroups_salinity);

% Loop through the groups and calculate the averages for temperature
for i = 1:numGroups_temp
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_temp(i) = mean(averages_temp(startIndex:endIndex));
end

% Loop through the groups and calculate the averages for salinity
for i = 1:numGroups_salinity
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_salinity(i) = mean(averages_salinity(startIndex:endIndex));
end

% Create time vector from 1 to 140 years
time = 1:numGroups_temp;

% Create a figure for the first plot
figure;
subplot(2, 1, 1); % Two rows, one column, first subplot
plot(time, groupedAverages_temp, 'b-', 'LineWidth', 2);
xlabel('Years');
ylabel('Grouped Average Temperature (\circC)');
title('Grouped Average Temperature Over Time');

% Create a figure for the second plot
subplot(2, 1, 2); % Two rows, one column, second subplot
plot(time, groupedAverages_salinity, 'r-', 'LineWidth', 2);
xlabel('Years');
ylabel('Grouped Average Salinity');
title('Grouped Average Salinity Over Time');
