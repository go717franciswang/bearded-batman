### histogram equalization
```
% load grayscaled image
I = imread('grizzly.jpg');
I = I(:,:,1);
J = histeq2(I);
imshow(J);
```
