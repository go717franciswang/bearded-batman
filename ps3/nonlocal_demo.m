I = imread('jaguar.jpg');
figure(1);
imshow(I);

N = imnoise(I, 'salt and pepper', 0.05);
% N = imnoise(I, 'gaussian', 0.05);
figure(2);
imshow(N);

J = nonlocal(N, 3);
figure(3);
imshow(J);
