% Create a world map
figure;
ax = worldmap([-40 30], [30 120]);

% Customize background color
bgcolor = [0.8 0.8 0.8]; % Light gray background
set(gcf, 'Color', bgcolor);
set(ax, 'Color', bgcolor);

% Customize grid, labels, and title
gridm on;
mlabel on;
plabel on;
setm(gca, 'FFaceColor', bgcolor); % Match grid and label background
title('Indian Ocean Basin with Region of Interest', 'FontSize', 14);

% Load coastlines
load coastlines

% Plot the coastline of the Indian Ocean Basin with a thicker blue line
geoshow(coastlat, coastlon, 'DisplayType', 'line', 'Color', 'b', 'LineWidth', 1.5);

% Define the latitude and longitude limits for the region of interest
latlim = [14 18];
lonlim = [86 90];

% Plot a red square to indicate the region of interest
square_lat = [latlim(1) latlim(1) latlim(2) latlim(2) latlim(1)];
square_lon = [lonlim(1) lonlim(2) lonlim(2) lonlim(1) lonlim(1)];
geoshow(square_lat, square_lon, 'DisplayType', 'polygon', 'FaceColor', 'none', 'EdgeColor', 'r', 'LineWidth', 2);

% Fill land areas with a light green color
landColor = [0.6 0.8 0.6]; % Adjust the RGB values for your desired shade of green
geoshow('landareas.shp', 'DisplayType', 'polygon', 'FaceColor', landColor);

% Fill ocean areas with a light blue color
oceanColor = [0.8 0.8 1]; % Light blue, you can adjust the RGB values
geoshow('worldoceans.shp', 'DisplayType', 'polygon', 'FaceColor', oceanColor);

% Add annotations
textm(16, 88, 'Region of Interest', 'Color', 'r', 'FontSize', 12);
textm(-35, 95, 'Indian Ocean Basin', 'Color', 'b', 'FontSize', 12);

% Adjust figure size (optional)
set(gcf, 'Position', [100, 100, 800, 600]);
