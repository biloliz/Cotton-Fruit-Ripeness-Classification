% Cotton Fruit Ripeness Classification & Harvesting Recommendation
% Mariell Mae Corpiz
% BSECE 3B

clc; clear; close all;

% Load cotton fruit image (palitan mo nalang to ng file name ng pic)
img = imread('cotton_fruit.jpg');
figure; imshow(img); title('Original Cotton Fruit Image');

% Convert image to HSV for better color segmentation
hsv_img = rgb2hsv(img);
h_channel = hsv_img(:,:,1);  % Extract Hue component

% Define ripeness levels based on hue ranges
ripe_mask = (h_channel > 0.08 & h_channel < 0.18);  % Yellow-orange hues (pangdetermine kung fully ripe)
semi_ripe_mask = (h_channel > 0.18 & h_channel < 0.25); % Light green-yellow hues (pangdetermine kung semi-ripe)
unripe_mask = (h_channel > 0.25 & h_channel < 0.40); % Green hues (pangdetermine kung unripe)

% Apply masks to extract segmented cotton fruit regions
ripe_img = img .* uint8(repmat(ripe_mask, [1, 1, 3]));
semi_ripe_img = img .* uint8(repmat(semi_ripe_mask, [1, 1, 3]));
unripe_img = img .* uint8(repmat(unripe_mask, [1, 1, 3]));

% Display segmented results
figure; imshow(ripe_img); title('Fully Ripe Cotton Fruit');
figure; imshow(semi_ripe_img); title('Semi-Ripe Cotton Fruit');
figure; imshow(unripe_img); title('Unripe Cotton Fruit');

% Histogram analysis for classification
r_channel = img(:,:,1);
g_channel = img(:,:,2);
b_channel = img(:,:,3);

mean_r = mean(r_channel(ripe_mask));
mean_g = mean(g_channel(ripe_mask));
mean_b = mean(b_channel(ripe_mask));

% Shape & Texture Analysis (ina-analyze nya ung edge ng prutas)
gray_img = rgb2gray(img);
edges = edge(gray_img, 'Canny');

% Determine classification and harvesting recommendation
if mean_r > mean_g && mean_r > mean_b
    ripeness = 'Fully Ripe';
    harvesting_status = 'Ready for Harvesting';
elseif mean_g > mean_r && mean_g > mean_b
    ripeness = 'Unripe';
    harvesting_status = 'Not Ready for Harvesting';
else
    ripeness = 'Semi-Ripe';
    harvesting_status = 'May Need More Time Before Harvest';
end

% Display classification and harvesting status
figure; imshow(edges); title('Edge Detection for Texture Analysis');
disp(['Cotton Fruit Ripeness Classification: ', ripeness]);
disp(['Harvesting Status: ', harvesting_status]);
