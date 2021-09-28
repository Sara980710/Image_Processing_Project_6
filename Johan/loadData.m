function [imgs, height, width, col_index, row_index, image] = loadData()
% Load image and set generix indexing and width stuff 
    %image = im2double(imread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg')); 
    image = im2double(imread('film1_big.jpg'));
    height = size(image,1)/5;
    width = size(image,2)/3;

    col_index = [1:1:width];
    row_index = [1:1:height];
    colors = [1,2,3]; column = 2;

    imgs = zeros(height, width, 3, 5);

    for row = 1:5
        imgs(:,:,colors, row) = image_at_row_col(row, column, image, colors);
    end
end

