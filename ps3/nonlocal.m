function J = nonlocal(I, box_size, search_width, err)

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
for i = 1:box_size:m
    printf('row %d/%d..\n', i, m);
    fflush(stdout);

    for j = 1:box_size:n
        i2 = min(i+box_size-1, m);
        j2 = min(j+box_size-1, n);

        % use lookup against sorted gray value to pull the original location of windows
        block = double(I(i:i2, j:j2, 1));
        current_gray_val = mean(block(:));
        i1 = max(1,lookup(sorted_gray_vals, current_gray_val - search_width));
        in = lookup(sorted_gray_vals, current_gray_val + search_width);
        idxes = orig_idx(i1:in);

        % compare target window against windows with similar gray value
        window_columns = size(I, 2)-box_size+1;
        [height, width] = size(block); % block size might not be box_size x box_size near the edges
        min_distance = height*width*err;
        avg_block = zeros(height, width);
        num_found = 0;
        for window_idx = idxes
            i3 = floor((window_idx-1)/window_columns) + 1;
            j3 = mod(window_idx-1, window_columns) + 1;
            block2 = double(I(i3:i3+height-1, j3:j3+width-1));
            distance = norm(block - block2, 2);
            if distance <= min_distance
                avg_block .+= block2;
                num_found++;
            end
        end

        if num_found > 1
            avg_block = round(avg_block / num_found);
        else
            avg_block = block;
        end

        J(i:i2, j:j2) = avg_block;
    end
end

J = uint8(J);

end
