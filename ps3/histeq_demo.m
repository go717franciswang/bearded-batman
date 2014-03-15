I = imread('jaguar.jpg');
I = I(:,:,1);
J = histeq2(I);

clf;

axes('position',[0 0.67 1 0.27]);
imshow(I);
title('Original');

axes('position',[0 0.33 0.5 0.27]);
imshow(J);
title('histeq reimplemented');

axes('position',[0.5 0.33 0.5 0.27]);
J2 = uint8(histeq(I)*256);
imshow(J2);
title('histeq Octave');

axes('position',[0 0 1 0.27]);
D = int8(abs(int16(J2) - int16(J)));
imshow(D);
title('Difference');

print('histeq_demo.jpg');
