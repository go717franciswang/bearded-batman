function J = immedian(I, box_size)

s = round((box_size-1) / 2);
[m n d] = size(I);
J = zeros(m,n,d);

for k = 1:d
    for i = 1:m
        for j = 1:n
            ymin = max(1,i-s);
            ymax = min(m,i+s);
            xmin = max(1,j-s);
            xmax = min(n,j+s);

            med = median(I(ymin:ymax, xmin:xmax, k)(:));
            J(i,j,k) = med;
        end
    end
end

J = uint8(J);
