arg_list = argv();
image_file_name = arg_list{1};
multiplier = str2num(arg_list{2});

I = imread(image_file_name);
[m n d] = size(I);
I = rgb2ycbcr(I);
Q = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62;
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
Q *= multiplier;

J = zeros(size(I));

for k = 1:3
    % 8x8
    for i = 1:8:m
        for j = 1:8:n
            i2 = min([i+7 m]);
            j2 = min([j+7 n]);
            B = I(i:i2, j:j2, k);

            % FFT
            G = fft2(B);

            % quantize
            B = round(G ./ Q);

            % invert quantization
            G2 = B .* Q;

            % invert FFT
            B2 = round(real(ifft2(G2)));

            J(i:i2, j:j2, k) = B2;
        end
    end
end

% visualize
J = ycbcr2rgb(J);
J = uint8(J);
% imshow(J);
% pause;

[dir, name, ext, ver] = fileparts(image_file_name);
outname = sprintf("%s_jpeg_fft_%0.2f%s", name, multiplier, ext);
imwrite(J, outname);
