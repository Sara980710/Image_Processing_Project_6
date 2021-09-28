function play_video(color, images, delay,  max_steps)
% Plays the frames contained in images as a video.
% input: color, images, delay, max_steps)
    height = size(images,1)/5;
    width = size(images,2)/3;
    count = 0;
    row = 1; 
    column = 2;
    if ~exist('max_steps', 'var')
        max_steps = 100;
    end
    if ~exist('delay', 'var') || delay == 0
        delay = 0.025*2;
    end
    while(1 && count < max_steps) 
        count = count + 1;
        rows_i = 1+(row - 1)*height : row * height;
        cols_j = 1+(column - 1)*width  : column * width;
        img_out = images(rows_i, cols_j, color);
        imshow(img_out, [])
        pause(delay)
        row = row + 1;
        if row == 6
            row = 1;
        end
    end
    close;
end