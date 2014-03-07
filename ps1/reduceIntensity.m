#! /usr/bin/octave -qf

arg_list = argv();
image_file_name = arg_list{1};
new_intensity = str2num(arg_list{2});

I = imread(image_file_name);
d = floor(256/new_intensity);
J = floor(I / d) * d;

[dir, name, ext, ver] = fileparts(image_file_name);
outname = sprintf("%s_%d%s", name, new_intensity, ext);

imwrite(J, outname);
exit;


