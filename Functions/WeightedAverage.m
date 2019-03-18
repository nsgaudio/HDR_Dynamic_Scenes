function output = WeightedAverage(weights, images, dzdx)

global param;

w1 = weights(:, :, 1:3, :);
w2 = weights(:, :, 4:6, :);
w3 = weights(:, :, 7:9, :);

images = CropImg(images, param.border);

im1 = images(:, :, 1:3, :);
im2 = images(:, :, 4:6, :);
im3 = images(:, :, 7:9, :);

tw = w1 + w2 + w3 + param.weps;

output = (w1.*im1 + w2.*im2 + w3.*im3) ./ tw;

if(exist('dzdx', 'var') && ~isempty(dzdx))
    output = cat(3, ((im1 - output) ./ tw) .* dzdx, ...
                    ((im2 - output) ./ tw) .* dzdx, ...
                    ((im3 - output) ./ tw) .* dzdx);
end

