%% Load data 
clc; clear; close all;
addpath('Image_Processing_Project_6\');
addpath('Johan');
dwtmode('per');
[imgs, height, width, col_index, row_index, image] = loadData();

%% Processing 
clc; close all
imgN = 1;
img = imgs(:,:,:,imgN);
imgR = imgs(:,:,1,imgN);
imgG = imgs(:,:,2,imgN);
imgB = imgs(:,:,3,imgN);
imgA = rgb2gray(imgs(:,:,:,imgN));

for i = 1:1
    img(:,:,1) =  medfilt2(img(:,:,1),[10,10]);
end

tiledlayout(3,3,'padding' ,'compact', 'tilespacing', 'compact');
nexttile; imshow(img,[]);
% nexttile; imshow(imgA,[]);

img_median = medfilt2(imgR,[3,3]);
nexttile; imshow(img_median,[0,1]);  % median filter with 3x3 window

%
img_median = imgA;
%

n = 20;
filt = 1/n*[-ones(n,1), ones(n,2), -ones(n,1)];
img_filt = imfilter(img_median, filt, 'corr', 'symmetric');
img_filt(img_filt > 0) = 0;
img_filt = -img_filt;
nexttile; imshow(img_filt,[]);

img_mask = img_filt > 2*std(img_filt);
nexttile; imshow(img_mask,[]);

nexttile; imshow(blur.*img_mask + imgs(:,:,1:3,imgN).*~img_mask,[]);


%% 


canny = edge(img_median,'canny',[],2.5);
nexttile; imshow(canny,[]);

tmp = sum(canny, 2);
nexttile; plot(row_index(5:end-5), tmp(5:end-5));

wavelet = 'haar';
level = 2;
[C, S] = wavedec2(img_median, level, wavelet);
[H1,V1,D1] = detcoef2('all',C,S,1);
A1 = appcoef2(C,S,wavelet,1);
nexttile; imshow(V1,[])

tmp = sum(V1, 2);
nexttile; plot(row_index(1:2:end), tmp(1:end))




























































