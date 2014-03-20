function avg_block = get_avg_similar_block(I, box_size, block, sorted_gray_vals, orig_idx)

% use lookup against sorted gray value to pull the original location of windows
block = double(block);
current_gray_val = mean(block(:));
search_width = 1.0;
i1 = max(1,lookup(sorted_gray_vals, current_gray_val - search_width));
in = lookup(sorted_gray_vals, current_gray_val + search_width);
idxes = orig_idx(i1:in);

% compare target window against windows with similar gray value
window_columns = size(I, 2)-box_size+1;
avg_block = zeros(box_size, box_size);
num_found = 0;
[height, width] = size(block); % block size might not be box_size x box_size near the edges
min_distance = height*width*5;
for window_idx = idxes
    i = floor((window_idx-1)/window_columns) + 1;
    j = mod(window_idx-1, window_columns) + 1;
    block2 = double(I(i:i+height-1, j:j+width-1));
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

end
