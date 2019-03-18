function output = ColorAugmentation(input, ind)

if (ind == 1)
    order = [1, 2, 3];
end

if (ind == 2)
   order = [1, 3, 2];
end

if (ind == 3)
    order = [2, 1, 3];
end

if (ind == 4)
    order = [2, 3, 1];
end

if (ind == 5)
    order = [3, 2, 1];
end

if (ind == 6)
    order = [3, 1, 2];
end

output = input(:, :, order, :);
