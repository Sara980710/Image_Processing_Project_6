close all
original_picture_full = imread('film1_big.jpg');
% The whole image
figure()
imshow(original_picture_full,[])    

% First image in the second column. DONT CHANGE VALUES!
original_picture_1 = imcrop(original_picture_full, [383 0 383 290]); %    First image in the second column
original_picture_2 = imcrop(original_picture_full, [383 290 383 287]); %    Second image in the second column
original_picture_3 = imcrop(original_picture_full, [383 577 383 287]); %    Third image in the second column
original_picture_4 = imcrop(original_picture_full, [383 864 383 287]); %    Fourth image in the second column
original_picture_5 = imcrop(original_picture_full, [383 1151 383 287]); %    Fifth image in the second column

% 2D Median filter on the different color channels (Can insert a different kernel size for the filters)
median_filter_image1 = medfilt2(original_picture_1(:,:,1), 'zeros');
median_filter_image2 = medfilt2(original_picture_1(:,:,2), 'zeros');
median_filter_image3 = medfilt2(original_picture_1(:,:,3), 'zeros');

% Difference in original picture and the filtered version
difference1 = imabsdiff(original_picture_1(:,:,1), median_filter_image1);
difference2 = imabsdiff(original_picture_1(:,:,2), median_filter_image2);
difference3 = imabsdiff(original_picture_1(:,:,3), median_filter_image3);

% Figure showing the different steps
figure()
montage([original_picture_1(:,:,1),original_picture_1(:,:,2),original_picture_1(:,:,3); median_filter_image1, median_filter_image2, median_filter_image3;...
    difference1, difference2, difference3], 'size', [1 NaN]);

% Have the median filter only contain black and white fixels and use it as
% a mask (Can change variables of the imbinarize)
median_filter_image1_bw = imcomplement(imbinarize(median_filter_image1,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4));

% Show the mask
figure()
imshow(median_filter_image1_bw,[])

% Use the mask in the inpaint function to remove masked areas
res = inpaintExemplar(original_picture_1, median_filter_image1_bw,'FillOrder','tensor','PatchSize',7);

% Show difference in original and obtained picture
figure()
imshowpair(original_picture_1, res, 'montage')


