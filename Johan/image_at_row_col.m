function img_out = image_at_row_col(row, column, images, colors)
% Function that will return image in the specified row and column of original image.
% Does only work for our image.
    height = size(images,1)/5;
    width = size(images,2)/3;
    rows_i = 1+(row - 1)*height : row * height;
    cols_j = 1+(column - 1)*width  : column * width;
    img_out = images(rows_i, cols_j, colors); 
end