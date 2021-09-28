close all
clc
clear

im = getImage(1,2); % max: 4,3
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

% Convert to binary with thresholding
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

% Use the mask in the inpaint function to remove masked areas
res = inpaintExemplar(im, GmagBinary,'FillOrder','tensor','PatchSize',7);
figure
subplot(1,3,1), imshow(im, [])
title('Original')
subplot(1,3,2), imshow(res, [])
title('Result inpaint')

% Smooth image
maskImage = GmagBinary;
medfilimgR = R;
medfilimgG = G;
medfilimgB = B;
sizeR = 10;
sizeC = 10;
for i=1:1
medfilimgR = medfilt2(medfilimgR, [sizeR,sizeC]);
medfilimgG = medfilt2(medfilimgG, [sizeR,sizeC]);
medfilimgB = medfilt2(medfilimgB, [sizeR,sizeC]);
end
R(maskImage) = medfilimgR(maskImage);
G(maskImage) = medfilimgG(maskImage);
B(maskImage) = medfilimgB(maskImage);

im(:,:,1) = R;
im(:,:,2) = G;
im(:,:,3) = B;
subplot(1,3,3), imshow(im, [])
title('Result median inpaint')
