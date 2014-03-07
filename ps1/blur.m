#! /usr/bin/octave -qf

arg_list = argv();
image_file_name = arg_list{1};
dimension = str2num(arg_list{2});

l = round((dimension - 1) / 2);
I = imread(image_file_name);
I = uint16(I);
[m, n, d] = size(I);
J = zeros(m, n, d);

sample_size = 0;
for i = -l:l
    horizontal_shift = shift(I,i,2);

    for j = -l:l
        vertical_shift = shift(horizontal_shift,j,1);
        J += vertical_shift;
        sample_size ++;
    end
end

J = uint8(round(J / sample_size));

[dir, name, ext, ver] = fileparts(image_file_name);
outname = sprintf("%s_blurred_%d%s", name, dimension, ext);
imwrite(J, outname);
