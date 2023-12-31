%xlong=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LON173_180');
%lat=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LAT180_187');
temp=ncread('temp.nc','TEMP');
%depth=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LEV1_19');

matrix_3d = squeeze(temp(:,:,1,:));
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
groupedAverages_temp = zeros(1, numGroups);

% Loop through the groups and calculate the averages
for i = 1:numGroups
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_temp(i) = mean(averages(startIndex:endIndex));
end

% Display the grouped averages
disp(groupedAverages_temp);

%xlong=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LON173_180');
%lat=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LAT180_187');
%depth=ncread('0DF3190B977775AEA1DE9BDDD53E192F_ferret_listing.nc','LEV1_19');
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
groupedAverages_sal = zeros(1, numGroups);

% Loop through the groups and calculate the averages
for i = 1:numGroups
    startIndex = (i - 1) * groupSize + 1;
    endIndex = i * groupSize;
    groupedAverages_sal(i) = mean(averages(startIndex:endIndex));
end

% Display the grouped averages
disp(groupedAverages_sal);
% Plot groupedAverages_sal vs groupedAverages_temp as individual points
figure;
hold on;

% Plot the points for salinity in blue
plot(groupedAverages_sal, groupedAverages_temp, 'bo', 'MarkerSize', 8, 'DisplayName', 'Salinity');

% Customize the appearance of the plot
xlabel('Average Salinity');
ylabel('Average Temperature (\circC)');
title('Salinity vs Temperature');

grid on;
set(gca, 'FontName', 'Arial', 'FontSize', 12);

% Apply the background color to the figure
set(gcf, 'color', 'w');
set(gca, 'color', 'none');
set(gca, 'XColor', 'k', 'YColor', 'k');

% Add a legend to label the points
legend('Location', 'Northwest');


