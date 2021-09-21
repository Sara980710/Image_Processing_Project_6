close all
clc
clear

im = imread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');
im = imcrop(im, [383 0 383 290]); %    First image in the second column
figure, imshow(im, [])
title('original image')

% Greyscale
grey = rgb2gray(im);
figure, imshow(grey, [])
title('greyscale image')

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

% try determine the color of the screatches
area = GmagBinary;
area = im2uint8(area);
area(area > 0) = 1;
predScratchArea = im .* area;
figure, imshow(predScratchArea, [])
title('Scratch area in color')

% Smooth image
maskImage = GmagBinary;
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
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


