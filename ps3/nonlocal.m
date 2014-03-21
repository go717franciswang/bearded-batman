function J = nonlocal(I, search_width, sigma)

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

% preprocess the image:
% evaluate each sliding window of box_size and store the average gray value in an array
disp('Preprocessing..');
fflush(stdout);
[m, n, d] = size(I);
window_columns = n-box_size+1;
window_rows = m-box_size+1;
windows_count = window_rows * window_columns;
avg_gray_vals = zeros(1, windows_count);
for i = 1:window_rows
    for j = 1:window_columns
        window_pixels = I(i:i+box_size-1, j:j+box_size-1, 1)(:);
        avg_gray_vals((i-1)*window_columns+j) = mean(window_pixels);
    end
end

% sort the array and preserve the change in order of idx
disp('Sorting..');
fflush(stdout);
[sorted_gray_vals, orig_idx] = sort(avg_gray_vals);

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

        % use lookup against sorted gray value to pull the original location of windows
        block = double(I(i:i2, j:j2, 1));
        current_gray_val = mean(block(:));
        i1 = max(1,lookup(sorted_gray_vals, current_gray_val - search_width));
        in = lookup(sorted_gray_vals, current_gray_val + search_width);
        idxes = orig_idx(i1:in);

        % compare target window against windows with similar gray value
        window_columns = size(I, 2)-box_size+1;
        avg_block = zeros(box_size, box_size);
        num_found = 0;
        for window_idx = idxes
            i3 = floor((window_idx-1)/window_columns) + 1;
            j3 = mod(window_idx-1, window_columns) + 1;

            if i3 < i-r || i3 > i+r || j3 < j-r || j3 > j+r
                continue;
            end

            block2 = double(I(i3:i3+box_size-1, j3:j3+box_size-1, 1));
            d2 = sum(((block - block2).^2)(:)) / box_size^2;
            weight = exp(- max(d2-2*sigma^2, 0)/h^2);
            avg_block += block2*weight;
            num_found += weight;
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
