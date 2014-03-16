arglist = argv();
noise_level = str2num(arglist{1}); % ranges from 0 to 100
median_size = str2num(arglist{2}); % min val 3

I = imread('jaguar.jpg');
clf;

subplot(3,2,1);
imshow(I);
title('#1 Original');

subplot(3,2,2);
N = imnoise(I, 'salt & pepper', noise_level/100);
imshow(N);
title(sprintf('#2 Noise level: %0.2f', noise_level/100));

subplot(3,2,3);
R1 = imsmooth(N, 'median', median_size);
imshow(R1);
title(sprintf('#3 native immedian, size: %d', median_size));

subplot(3,2,4);
R2 = immedian(N, median_size);
imshow(R2);
title(sprintf('#4 immedian2, size: %d', median_size));

subplot(3,2,5);
imshow(imsubtract(I, R1));
title('#1 - #3');

subplot(3,2,6);
imshow(imsubtract(I, R2));
title('#1 - #4');

ofile = sprintf('immedian_demo_%d_%d.jpg', noise_level, median_size);
print(ofile);
