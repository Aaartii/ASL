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

% Interpolate to create a smoother curve
x_temp = 1:numGroups_temp;
x_salinity = 1:numGroups_salinity;
smoothed_temp = interp1(x_temp, groupedAverages_temp, 1:0.1:max(x_temp), 'spline');
smoothed_salinity = interp1(x_salinity, groupedAverages_salinity, 1:0.1:max(x_salinity), 'spline');

% Plot the smoothed monthly average temperatures and salinity on the same graph
figure;
hold on;
h_temp = plot(1:0.1:max(x_temp), smoothed_temp, 'b-', 'LineWidth', 2, 'DisplayName', 'Temperature');
h_salinity = plot(1:0.1:max(x_salinity), smoothed_salinity, 'r-', 'LineWidth', 2, 'DisplayName', 'Salinity');
xlabel('Month Group');
ylabel('Average Temperature (\circC) / Salinity');
title('Monthly Average Temperature and Salinity');

% Customize the appearance of the plot
grid on;
set(gca, 'FontName', 'Arial', 'FontSize', 12);
set(h_temp, 'Color', 'b');
set(h_salinity, 'Color', 'r');
set(gca, 'XTickLabelRotation', 45);

% Apply the background color to the figure
set(gcf, 'color', 'w');
set(gca, 'color', 'none');
set(gca, 'XColor', 'k', 'YColor', 'k');

% Add a legend to label the curves
legend('Location', 'Northwest');
