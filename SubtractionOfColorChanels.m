close all
clc
clear


im = getImage(2,4);
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

[Gmag,Gdir] = imgradient(im_subtracted_GR, 'prewitt');
figure, imshow(Gmag, [])
title('Gradient magnitude')

% Convert to binary with thresholding: building
GmagBinary = Gmag > 0.2*max(Gmag(:));
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

% Smooth image
maskImage = GmagBinary
medfilimgR = medfilt2(R, [10,10]);
medfilimgG = medfilt2(G, [10,10]);
medfilimgB = medfilt2(B, [10,10]);
R(maskImage) = medfilimgR(maskImage);
G(maskImage) = medfilimgG(maskImage);
B(maskImage) = medfilimgB(maskImage);
im(:,:,1) = R;
im(:,:,2) = G;
im(:,:,3) = B;

figure, imshow(im, [])
title('Result')
