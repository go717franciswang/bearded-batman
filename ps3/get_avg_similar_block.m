function avg_block = get_avg_similar_block(I, box_size, block)

block = double(block);
min_distance = box_size*box_size*5;
avg_block = zeros(box_size, box_size);
[m, n, d] = size(I);
num_found = 0;

for i = 1:m-box_size+1
    for j = 1:n-box_size+1
        block2 = double(I(i:i+box_size-1, j:j+box_size-1));
        distance = norm(block - block2, 2);
        if distance <= min_distance
            avg_block .+= block2;
            num_found++;
        end
    end
end

if num_found > 1
    % disp('similar block found');
end

avg_block = round(avg_block / num_found);

end
