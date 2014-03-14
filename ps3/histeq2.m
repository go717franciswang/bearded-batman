% image I is expected to be grayscaled with dimension (m,n,1)
function J = histeq2(I)

L = 256;
[NN XX] = hist(I(:), L);
integral = 0;
n = sum(NN);
tranformer = zeros(L);

for i = 1:L
    integral += NN(i)/n;
    s = round(integral * (L-1));
    tranformer(i) = s;
end

J = uint8(arrayfun(@(color) tranformer(color+1), I));

end
