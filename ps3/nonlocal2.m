function J = nonlocal2(I, sigma)

I = double(I);

if sigma <= 0 || sigma > 100
    error('sigma must be within (0, 100]');
elseif sigma <= 15
    h = 0.4*sigma;
    box_size = 3;
    r = 10;
elseif sigma <= 30
    h = 0.4*sigma;
    box_size = 5;
    r = 10;
elseif sigma <= 45
    h = 0.35*sigma;
    box_size = 7;
    r = 17;
elseif sigma <= 75
    h = 0.35*sigma;
    box_size = 9;
    r = 17;
else
    h = 0.3*sigma;
    box_size = 11;
    r = 17;
end

[m, n, d] = size(I);
window_columns = n-box_size+1;
window_rows = m-box_size+1;

disp('Main..');
fflush(stdout);
J = zeros(size(I));
Estimated = zeros(size(I));
for i = 1:m-box_size+1
    printf('row %d/%d..\n', i, m);
    fflush(stdout);

    for j = 1:n-box_size+1
        i2 = i+box_size-1;
        j2 = j+box_size-1;

        block = double(I(i:i2, j:j2, 1));
        avg_block = zeros(box_size, box_size);
        num_found = 0;
        for i3 = max(i-r, 1):min(i+r, m-box_size+1)
            for j3 = max(j-r, 1):min(j+r, n-box_size+1)
                block2 = double(I(i3:i3+box_size-1, j3:j3+box_size-1, 1));
                distance = norm(block - block2, 2);
                d2 = sum(((block - block2).^2)(:)) / box_size^2;
                weight = exp(- max(d2-2*sigma^2, 0)/h^2);
                avg_block += block2*weight;
                num_found += weight;
            end
        end

        if num_found > 1
            avg_block = avg_block / num_found;
        else
            avg_block = block;
        end

        J(i:i2, j:j2) += avg_block;
        Estimated(i:i2, j:j2) += ones(size(avg_block));
    end
end

J = uint8(round(J ./ Estimated));

end
