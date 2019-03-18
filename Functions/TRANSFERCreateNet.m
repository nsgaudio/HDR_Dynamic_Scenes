function net = TRANSFERCreateNet(initial)

net.layers = {};

net.layers{end+1} = struct('type', 'conv', 'weights', {{cell2mat(initial{1,1}.weights(1)), cell2mat(initial{1,1}.weights(2))}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{cell2mat(initial{1,3}.weights(1)), cell2mat(initial{1,3}.weights(2))}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{cell2mat(initial{1,5}.weights(1)), cell2mat(initial{1,5}.weights(2))}}, 'stride', 1, 'pad', 0);

net.layers{end+1} = struct('type', 'relu', 'leak', 0);
net.layers{end+1} = struct('type', 'conv', 'weights', {{cell2mat(initial{1,7}.weights(1)), cell2mat(initial{1,7}.weights(2))}}, 'stride', 1, 'pad', 0);

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