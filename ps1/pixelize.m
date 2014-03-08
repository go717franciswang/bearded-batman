#! /usr/bin/octave -qf

arg_list = argv();
image_file_name = arg_list{1};
pixel_size = str2num(arg_list{2});

I = imread(image_file_name);
[m, n, d] = size(I);

warning("off", "Octave:broadcast");

for i = 1:pixel_size:m
    for j = 1:pixel_size:n
        i2 = min([i+pixel_size-1, m]);
        j2 = min([j+pixel_size-1, n]);
        a = uint8(mean(mean(I(i:i2, j:j2, :), 1), 2));
        I(i:i2, j:j2, :) = ones(i2-i+1, j2-j+1, 1).*a;
    end
end

[dir, name, ext, ver] = fileparts(image_file_name);
outname = sprintf("%s_pixelized_%d%s", name, pixel_size, ext);
imwrite(I, outname);

