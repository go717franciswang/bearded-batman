function J = nonlocal(I, box_size)

J = blockproc(I, [box_size, box_size], @(block)get_avg_similar_block(I, box_size, block));
J = uint8(J);

end
