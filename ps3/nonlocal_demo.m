I = imread('jaguar-tiny.jpg');
figure(1);
imshow(I);

N = imnoise(I, 'salt and pepper', 0.05);
figure(2);
imshow(N);

J = nonlocal(N, 5);
figure(3);
imshow(J);
