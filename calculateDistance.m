function [output_args] = calculateDistance(img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imagefiles = dir('training_data/*.jpeg');  
folder = 'training_data'; 
nfiles = length(imagefiles); 
disp(nfiles); 
scores = zeros(nfiles, 1); 

for i = 1:nfiles
    filename = imagefiles(i).name; 
    %disp(filename); 
    target_img = imread(strcat(folder,'/', filename)); 
    %disp(target_img); 
    %[height, width] = size(target_img); 

    %target_img = rgb2gray(target_img);
    %disp(target_img);     
	target_img = im2double(target_img);
    %disp(target_img); 
    
    %input_resize = rgb2gray(img); 
    %input_resize = im2double(input_resize);
    input_resize = imread(img); 
    %disp(input_resize); 
    input_resize = im2double(input_resize);
    %disp(input_resize); 
    [h, w] = size(target_img); 
    input_resize = imresize(input_resize, [h, w]);    
    %disp(input_resize); 
    
    dist = 0; 
    for x = 1:h
        for y = 1:w
            dist = dist + abs(target_img(x, y) - input_resize(x, y)); 
        end 
    end 
    scores(i, 1) = dist/(h*w); 
    X = [filename, ' score is ', num2str(scores(i, 1))]; 
    %disp(X); 
end 
    [M, I] = min(scores); 
    %disp(M); disp(I); 
    %disp(scores); 
    X = [imagefiles(I).name, 'score is ', num2str(M)]; 
    disp(X); 
end

