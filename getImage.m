
function im = getImage(imRow, imCol)
im = imread('http://fy.chalmers.se/~romeo/RRY025/mfiles/film1_big.jpg');

width = 383;
wPadding = 1;
height = 287;
hPadding = 2;
if imRow == 1
    if imCol == 1
        im = imcrop(im, [0 0 width height]);
    elseif imCol == 2
        im = imcrop(im, [width+wPadding 0 width height]); 
    elseif imCol == 3
        im = imcrop(im, [2*(width+wPadding) 0 width height]); 
    end
elseif imRow == 2
    if imCol == 1
        im = imcrop(im, [0 height+hPadding width height]);
    elseif imCol == 2
        im = imcrop(im, [width+wPadding height+hPadding width height]); 
    elseif imCol == 3
        im = imcrop(im, [2*(width+wPadding) height+hPadding width height]); 
    end
elseif imRow == 3
    if imCol == 1
        im = imcrop(im, [0 2*(height+hPadding) width height]);
    elseif imCol == 2
        im = imcrop(im, [width+wPadding 2*(height+hPadding) width height]); 
    elseif imCol == 3
        im = imcrop(im, [2*(width+wPadding) 2*(height+hPadding) width height]); 
    end
elseif imRow == 4
    if imCol == 1
        im = imcrop(im, [0 3*(height+hPadding) width height]);
    elseif imCol == 2
        im = imcrop(im, [width+wPadding 3*(height+hPadding) width height]); 
    elseif imCol == 3
        im = imcrop(im, [2*(width+wPadding) 3*(height+hPadding) width height]); 
    end
end
end

