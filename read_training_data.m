function [simple_data, complex_data] = read_training_data()

imagefiles = dir('train_simple/*.jpeg');  
folder = 'train_simple/'; 
nfiles = length(imagefiles); 
for i = 1: nfiles
    target_img = im2double(rgb2gray(imread([folder, num2str(i), '.jpeg'])));
    target_img (target_img < 0.9) = 0;
    target_img (target_img >= 0.9) = 1;
    simple_data{i} = target_img;
end

imagefiles = dir('training_data/*.jpeg');  
folder = 'training_data/'; 
nfiles = length(imagefiles); 
for i = 1: nfiles
    target_img = im2double(rgb2gray(imread([folder, num2str(i), '.jpeg'])));
    target_img (target_img < 0.9) = 0;
    target_img (target_img >= 0.9) = 1;
    complex_data{i} = target_img;
end
end