% Read and pre-process training images
%
% INPUT:
%   directory_path (string): Directory path which contains the training
%       images.
%
% OUTPUT:
%   training_images (cell array): Collection of training images

function training_images = readTrainingData(directory_path)

image_files = dir([directory_path '*.jpeg']);
file_count = length(image_files);
training_images = {};

for file_index = 1 : file_count
    % Read image
    training_image = imread([directory_path num2str(file_index) '.jpeg']);
    training_image = rgb2gray(training_image);
    training_image = im2double(training_image);

    % Adjust image to be black and white only
    training_image (training_image < 0.9) = 0;
    training_image (training_image >= 0.9) = 1;

    training_images{file_index} = training_image;
end