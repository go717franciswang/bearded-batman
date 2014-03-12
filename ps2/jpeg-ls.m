arg_list = argv();
image_file_name = arg_list{1};

I = imread(image_file_name);
[m n d] = size(I);

J1 = zeros(m,n,d); % (-1, 0)
J2 = zeros(m,n,d); % (0, 1)
J3 = zeros(m,n,d); % (-1, 0), (-1, 1), (0, 1)

J1(:, 2:end, :) = I(:, 1:end-1, :);
J2(2:end, :, :) = I(1:end-1, :, :);

D3 = zeros(m,n,d); % keep track of number of earlier pixels used in this predictor
J3(:, 2:end, :) += int16(I(:, 1:end-1, :));
D3(:, 2:end, :) += ones(m, n-1, d);
J3(2:end, :, :) += int16(I(1:end-1, :, :));
D3(2:end, :, :) += ones(m-1, n, d);
J3(2:end, 2:end, :) += int16(I(1:end-1, 1:end-1, :));
D3(2:end, 2:end, :) += ones(m-1, n-1, d);
D3(1,1,:) = [1 1 1]; % avoid division-by-zero error
J3 = round(J3 ./ D3);

function plot(E, D, save_to)
    clf;

    subplot(1, 2, 1);
    imshow(D);
    title("Original / Difference");

    subplot(1, 2, 2);
    h = hist(E, 256);
    hist(E, 256);
    y = max(h);
    title("Histogram");
    text(20, y/2, sprintf("Std: %0.2f", std(E)));
    text(20, y/2.5, sprintf("Entropy: %0.2f", entropy(E)));
    xlabel("original intensity / prediction error");
    ylabel("Number of pixels");

    print(save_to);
end

E1 = (int16(J1) - int16(I))(:);
E2 = (int16(J2) - int16(I))(:);
E3 = (int16(J3) - int16(I))(:);
D1 = J1 - I;
D2 = J2 - I;
D3 = J3 - I;

plot(I(:), I, "J0.png");
plot(E1, D1, "J1.png");
plot(E2, D2, "J2.png");
plot(E3, D3, "J3.png");
