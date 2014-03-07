function product = cardProd(v1, v2)

l1 = length(v1);
l2 = length(v2);
product = zeros(l1*l2, 2);

for i = 1:l1
    for j = 1:l2
        k = i*l1+j-l1;
        product(k, 1) = v1(i);
        product(k, 2) = v1(j);
    end
end

end
