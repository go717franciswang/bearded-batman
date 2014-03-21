% arglist = argv();
% box_size = str2num(arglist{1});

I = imread('jaguar-medium.jpg');
subplot(3,2,1:2);
imshow(I);
title('Original');

N = imnoise(I, 'salt and pepper', 0.05);
% N = imnoise(I, 'gaussian', 0.05);
subplot(3,2,3);
imshow(N);
title('Noisy');

subplot(3,2,4);
D1 = imsubtract(I, N);
e1 = sum(double((D1.^2)(:))/prod(size(D1)))^0.5;
imshow(D1);
title(sprintf('Noise, std: %0.2f', e1));

search_width = 2;
sigma = 35;
%J = NLmeansfilter(N, 10, 3, 5);
J = nonlocal(N, search_width, sigma);
%J = nonlocal2(N, sigma);
subplot(3,2,5);
imshow(J);
title(sprintf('Recovered, sigma=%d', sigma));

subplot(3,2,6);
D2 = imsubtract(N, J);
imshow(D2);
title('Noise removed');

print(sprintf('nonlocal_demo_%d.jpg', sigma));
