% http://en.wikipedia.org/wiki/YCbCr

function J = ycbcr2rgb(I)

J = zeros(size(I));
[m n d] = size(I);
for i = 1:m
    for j = 1:n
        ycbcr = I(i,j,:)(:);
        rgb = [298.082 0 408.583;
               298.082 -100.291 -208.120;
               298.082 516.412 0] * ycbcr ./ 256 + [-222.921; 135.576; -276.836];
        J(i,j,:) = rgb;
    end
end

end
