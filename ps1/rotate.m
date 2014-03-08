#! /usr/bin/octave -qf

arg_list = argv();
image_file_name = arg_list{1};
degrees = str2num(arg_list{2});
rad = degrees * pi / 180;
M = [cos(rad) -sin(rad); sin(rad) cos(rad)];
I = imread(image_file_name);
[m, n, d] = size(I);
center = round([n/2, m/2]);

function r = rotate(M, center, point)
    r = M * (point - center)' + center';
end

% compute the new size of the rotated image
%   compute new location of the 4 corners
c1 = rotate(M, center, [0 0]);
c2 = rotate(M, center, [0 m-1]);
c3 = rotate(M, center, [n-1 0]);
c4 = rotate(M, center, [n-1 m-1]);

%   get max and min of x and y, and compute offset for later use
corners = [c1 c2 c3 c4];
mins = min(corners, [], 2);
xmin = mins(1);
ymin = mins(2);
maxs = max(corners, [], 2);
xmax = maxs(1);
ymax = maxs(2);

width = xmax - xmin;
height = ymax - ymin;

J = ones(height, width, 3)*255;

% iterate over every pixel by position
for y = 1:m
    for x = 1:n
        colors = I(y,x,:);
        % compute new position and copy the colors of this pixel to the new position (make sure to apply offset)
        p = rotate(M, center, [x-1 y-1]) - [xmin; ymin] + [1; 1];
        if p(1) <= 0
            p(1) = 1;
        end
        if p(2) <= 0
            p(2) = 1;
        end
        if p(1) > width
            p(1) = width;
        end
        if p(2) > height
            p(2) = height;
        end

        p = round(p);
        J(p(2), p(1), :) = colors;
    end
end

J = uint8(J);
[dir, name, ext, ver] = fileparts(image_file_name);
outname = sprintf("%s_rotated_%d%s", name, degrees, ext);
imwrite(J, outname);
