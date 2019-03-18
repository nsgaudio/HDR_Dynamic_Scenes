function net = CreateNet()

net.layers = {};

net.layers{end+1} = struct('type', 'conv', 'weights', {{InitWeight(7,7,18,100), zeros(1,100,'single')}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{InitWeight(5,5,100,100), zeros(1,100,'single')}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{InitWeight(3,3,100,50), zeros(1,50,'single')}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{InitWeight(1,1,50,9), zeros(1,9,'single')}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'sigmoid');

%%% needed for ADAM solver
for i = 1 : numel(net.layers)
    if (strcmp(net.layers{i}.type, 'conv') || strcmp(net.layers{i}.type, 'convt'))
        if (~exist('net.layers{i}.msq', 'var'))
        numWeights = numel(net.layers{i}.weights);
        net.layers{i}.msq = cell(1, numWeights);
        net.layers{i}.m = cell(1, numWeights);
        net.layers{i}.v = cell(1, numWeights);
        end
    end
end
