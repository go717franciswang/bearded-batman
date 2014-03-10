% http://en.wikipedia.org/wiki/YCbCr

function J = rgb2ycbcr(I)

I = double(I);
J = zeros(size(I));
[m n d] = size(I);
for i = 1:m
    for j = 1:n
        rgb = I(i,j,:)(:);
        ycbcr = [65.738 129.057 25.064;
                 -37.945 -74.494 112.439;
                 112.439 -94.154 -18.285;] * rgb ./ 256 + [16; 128; 128;];
        J(i,j,:) = ycbcr;
    end
end

end
