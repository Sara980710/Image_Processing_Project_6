close all
original_picture_full = imread('film1_big.jpg');
% The whole image
% figure()
% imshow(original_picture_full,[])    

% First image in the second column. DONT CHANGE VALUES!
original_picture_1 = imcrop(original_picture_full, [383 0 383 290]); %    First image in the second column
original_picture_2 = imcrop(original_picture_full, [383 290 383 287]); %    Second image in the second column
original_picture_3 = imcrop(original_picture_full, [383 577 383 287]); %    Third image in the second column
original_picture_4 = imcrop(original_picture_full, [383 864 383 287]); %    Fourth image in the second column
original_picture_5 = imcrop(original_picture_full, [383 1151 383 287]); %    Fifth image in the second column


figure()
imshow(original_picture_1,[])

difference = imabsdiff(original_picture_1(:,:,1), original_picture_1(:,:,3)+original_picture_1(:,:,2));
difference_bw = im2bw(difference);

mask = bwareaopen(difference_bw, 5);

res = inpaintExemplar(original_picture_1, mask,'FillOrder','tensor','PatchSize',7);

figure()
imshow(res,[])

horizontalEdgeImage = imfilter(res(:,:,1), [-1 0 1]);
figure()
imshow(horizontalEdgeImage,[]);

bw = (imbinarize(horizontalEdgeImage));
bw_med = medfilt2(bw,[5,2], 'zeros'); %Change size of the median filter to obtain different results.

figure()
imshowpair(bw, bw_med, 'montage')

%figure()
%imshow(bw_med,[]);
res2 = inpaintExemplar(res, bw_med,'FillOrder','tensor','PatchSize',7);

figure()
montage({original_picture_1, res, res2}, 'Size', [1,3]);


