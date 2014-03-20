arglist = argv();
box_size = str2num(arglist{1});

I = imread('jaguar.jpg');
subplot(3,2,1:2);
imshow(I);
title('Original');

N = imnoise(I, 'salt and pepper', 0.05);
% N = imnoise(I, 'gaussian', 0.05);
subplot(3,2,3);
imshow(N);
title('Noisy');

subplot(3,2,4);
imshow(imsubtract(I, N));
title('Delta');

search_width = 1;
err = 15;
J = nonlocal(N, box_size, search_width, err);
subplot(3,2,5);
imshow(J);
title(sprintf('Non-local, boxSize=%d', box_size));

subplot(3,2,6);
imshow(imsubtract(I, J));
title('Delta');

print(sprintf('nonlocal_demo_%d.jpg', box_size));
