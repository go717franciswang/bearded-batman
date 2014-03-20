function J = nonlocal(I, box_size)

% preprocess the image:
% evaluate each sliding window of box_size and store the average gray value in an array
% sort the array and preserve the change in order of idx
% use lookup against sorted gray value to pull the original location of windows
% compare target window against windows with similar gray value

J = blockproc(I, [box_size, box_size], @(block)get_avg_similar_block(I, box_size, block));
J = uint8(J);

end
