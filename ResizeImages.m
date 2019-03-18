% Nicholas and Suzy
% Tobe ran after all images have been converted to .tif files
% Resizes .tif files for all folders specified by s

%%% Parameters ---------------
oldWidth = 2048;
oldHeight = 1536;
newWidth = 1500;
newHeight = 1000;

folder_numbers = 1:22;
%%% --------------------------

for s = folder_numbers
    if s <= 9
        files = dir(fullfile(['OurData/00',num2str(s),'/'], '*.tif'));
        pattern = '.tif';
        replacement = '';
        for f = 1:length(files)
            file = files(f).name;
            name = regexprep(file, pattern, replacement);
            img = imread(join(['OurData/00',num2str(s),'/', file]));
            % Crops for correst height/width = 2/3 ratio (so stretching doesn't occur)
            img = img(89:end-88, 5:end-4, :);
            % Resizes the image to the expected dimensions
            img = imresize(img, [newHeight  newWidth], 'bicubic');
            imwrite(img, ['OurData/00',num2str(s),'/', name, '.tif']);
        end
    else
        files = dir(fullfile(['OurData/0',num2str(s),'/'], '*.tif'));
        pattern = '.tif';
        replacement = '';
        for f = 1:length(files)
            file = files(f).name;
            name = regexprep(file, pattern, replacement);
            img = imread(join(['OurData/0',num2str(s),'/', file]));
            % Crops for correst height/width = 2/3 ratio (so stretching doesn't occur)
            img = img(89:end-88, 5:end-4, :);
            % Resizes the image to the expected dimensions
            img = imresize(img, [newHeight  newWidth], 'bicubic');
            imwrite(img, ['OurData/0',num2str(s),'/', name, '.tif']);
        end 
    end 
end

