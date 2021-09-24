close all
clc
clear

im = imread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
im = imcrop(im, [383 0 383 290]); %    First image in the second column
figure, imshow(im, [])
title('original image')

% Greyscale
grey = rgb2gray(im);
%figure, imshow(grey, [])
%title('greyscale image')

% Gaussian filter
filterSize = 2;
gaussian = fspecial('gaussian',[filterSize,filterSize],filterSize/2);
grey = imfilter(grey,gaussian,'replicate');
figure, imshow(grey, [])
title('Gaussian filter applied')

% Sobel mask to find out gradients magnitude
[Gmag,Gdir] = imgradient(grey, 'prewitt');
figure, imshow(Gmag, [])
title('Gradient magnitude')

% Convert to binary with thresholding: building
GmagBinary = Gmag > 0.1*max(Gmag(:));
figure, imshow(GmagBinary, [])
title('binary')

% Try to close the objects with morpholgical operation Closing of binary image by a disk mask of 3 X 3.
GmagBinary = imclose(GmagBinary,strel('disk',1));
figure, imshow(GmagBinary, [])
title('morphological closing')

% delete all small noise
GmagBinary = bwareaopen(GmagBinary,10);
figure, imshow(GmagBinary, [])
title('Only big dotts')

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

% G-R since the scratches are visible
im_norm = im_subtracted_GR./max(max(im_subtracted_GR));
%figure, imhist(double(im_norm))
im_median = median(median(im_norm));
im_binary = im2bw(im_subtracted_GR, im_median);
figure
subplot(1,3,1),imshow(im_binary, [])
title('Color subtracted image thresholded G-R')

% R-B
im_norm = im_subtracted_RB./max(max(im_subtracted_RB));
%figure, imhist(double(im_norm))
im_median = median(median(im_norm));
im_binary = im2bw(im_subtracted_RB, im_median/2);
figure
subplot(1,3,1),imshow(im_binary, [])
title('Color subtracted image thresholded R-B')

% R-G
im_norm = im_subtracted_RG./max(max(im_subtracted_RG));
%figure, imhist(double(im_norm))
im_median = median(median(im_norm));
im_binary_2 = im2bw(im_subtracted_RG, im_median);
subplot(1,3,2), imshow(im_binary_2, [])
title('Color subtracted image thresholded R-G')

% Combine and dilate
im_binary = im_binary_2 | im_binary;
se = strel('diamond',6);
im_binary = imdilate(im_binary,se);
subplot(1,3,3), imshow(im_binary, [])
title('Color subtracted image thresholded combined')

maskImage = ~im_binary & GmagBinary;
figure, imshow(maskImage, [])
title('Mask')

% try determine the color of the screatches
area = maskImage;
area = im2uint8(area);
area(area > 0) = 1;
predScratchArea = im .* area;
figure, imshow(predScratchArea, [])
title('Mask in color')

% Smooth image
medfilimgR = medfilt2(R, [10,10]);
medfilimgG = medfilt2(G, [10,10]);
medfilimgB = medfilt2(B, [10,10]);
R(maskImage) = medfilimgR(maskImage);
G(maskImage) = medfilimgG(maskImage);
B(maskImage) = medfilimgB(maskImage);
im(:,:,1) = R;
im(:,:,2) = G;
im(:,:,3) = B;

%blurredImage = conv2(im, ones(15)/15^2, 'same');
%im(maskImage) = blurredImage(maskImage);
figure, imshow(im, [])
title('Result')


