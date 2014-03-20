function J = nonlocal(I, box_size)

% preprocess the image:
% evaluate each sliding window of box_size and store the average gray value in an array
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
[sorted_gray_vals, orig_idx] = sort(avg_gray_vals);

J = blockproc(I, [box_size, box_size], ...
    @(block)get_avg_similar_block(I, box_size, block, sorted_gray_vals, orig_idx));
J = uint8(J);

end
