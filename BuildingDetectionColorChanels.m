close all
clc
clear

im = imread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
im = imcrop(im, [383 0 383 290]); %    First image in the second column
figure, imshow(im, [])
title('original image')

% Wavelet decomposition
% Get color channels
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% Detect buidlings/background
im_subtracted_RB = R-B;
figure
title('Color subtracted image')
subplot(3,3,1),imshow(im_subtracted_RB, [])
title('R-B')
im_subtracted_RG = R-G;
subplot(3,3,2),imshow(im_subtracted_RG, [])
title('R-G')
im_subtracted = R-R;
subplot(3,3,3),imshow(im_subtracted, [])
title('R-R')
im_subtracted = G-B;
subplot(3,3,4),imshow(im_subtracted, [])
title('G-B')
im_subtracted = G-G;
subplot(3,3,5),imshow(im_subtracted, [])
title('G-G')
im_subtracted_GR = G-R;
subplot(3,3,6),imshow(im_subtracted_GR, [])
title('G-R')
im_subtracted = B-B;
subplot(3,3,7),imshow(im_subtracted, [])
title('B-B')
im_subtracted = B-G;
subplot(3,3,8),imshow(im_subtracted, [])
title('B-G')
im_subtracted = B-R;
subplot(3,3,9),imshow(im_subtracted, [])
title('B-R')

im_norm = im_subtracted_RB./max(max(im_subtracted_RB));
%figure, imhist(double(im_norm))
im_median = median(median(im_norm));
im_binary = im2bw(im_subtracted_RB, im_median);
figure, imshow(im_binary, [])
title('Color subtracted image thresholded R-B')
