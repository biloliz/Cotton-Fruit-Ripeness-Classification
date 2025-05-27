% Cotton Fruit Ripeness Classification & Harvesting Recommendation
% Mariell Mae Corpiz
% BSECE 3B

clc; clear; close all;

% Load cotton fruit image (palitan mo nalang to ng file name ng pic)
img = imread('cotton_fruit.jpg');
figure; imshow(img); title('Original Cotton Fruit Image');

% Convert image to HSV for better color segmentation
hsv_img = rgb2hsv(img);
H = hsv_img(:,:,1);  % Extract Hue component

% Define ripeness levels based on hue ranges
ripe_mask = (H >= 0.08 & H < 0.15);
semi_ripe_mask = (H >= 0.15 & H < 0.22);
unripe_mask = (H >= 0.22 & H <= 0.40);

% Step 4: Clean masks using morphological operations
se = strel('disk', 3);
ripe_mask = imopen(ripe_mask, se);
semi_ripe_mask = imopen(semi_ripe_mask, se);
unripe_mask = imopen(unripe_mask, se);

% Step 5: Apply masks to extract segmented fruit regions
ripe_img = img .* uint8(repmat(ripe_mask, [1, 1, 3]));
semi_ripe_img = img .* uint8(repmat(semi_ripe_mask, [1, 1, 3]));
unripe_img = img .* uint8(repmat(unripe_mask, [1, 1, 3]));

% Step 6: Display results
figure; imshow(ripe_img); title('Fully Ripe Cotton Fruit');
figure; imshow(semi_ripe_img); title('Semi-Ripe Cotton Fruit');
figure; imshow(unripe_img); title('Unripe Cotton Fruit');

% Step 7: Calculate average RGB in ripe region
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);

mean_r = mean2(R(ripe_mask));
mean_g = mean2(G(ripe_mask));
mean_b = mean2(B(ripe_mask));

% Step 8: Ripeness Classification Based on Dominant Color
if mean_r > mean_g && mean_r > mean_b
    ripeness = 'Fully Ripe';
    harvesting_status = '✅ Ready for Harvesting';
elseif mean_g > mean_r && mean_g > mean_b
    ripeness = 'Unripe';
    harvesting_status = '❌ Not Ready for Harvesting';
else
    ripeness = 'Semi-Ripe';
    harvesting_status = '⏳ May Need More Time Before Harvest';
end

% Step 9: Display Results
fprintf('\nCotton Fruit Ripeness Classification: %s\n', ripeness);
fprintf('Harvesting Status: %s\n', harvesting_status);
