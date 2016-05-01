function [match, graph] = calculateDistance(img, level)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if strcmp('simple', level)
imagefiles = dir('train_simple/*.jpeg');  
folder = 'train_simple/';     
else
imagefiles = dir('training_data/*.jpeg');  
folder = 'training_data/'; 
end

nfiles = length(imagefiles); 
scores = zeros(nfiles, 1); 
[img_h, img_w] = size(img);
%image = im2double(rgb2gray(imread(img)));
for i = 1:nfiles
	target_img = im2double(rgb2gray(imread([folder, num2str(i), '.jpeg'])));
    target_img (target_img < 0.9) = 0;
    target_img (target_img >= 0.9) = 1;
    [h, w] = size(target_img); 
    input_resize = imresize(img, [h, w]); 
    input_resize (input_resize < 0.9) = 0;
    input_resize (input_resize >= 0.9) = 1;  
    count = 0; 
    for x = 1:h
        for y = 1:w
            if target_img(x, y) == input_resize(x, y)
               count = count+1; 
            end
        end
    end
    scores(i, 1) = count/(h*w); 

end 
    [M, I] = max(scores); 
    %disp(scores);
    if I == 11 && img_h > img_w*3
        match = -1;
        disp('end of trunk');
        graph = 1;
    else
        disp(['The closest match is image number ', num2str(I), ' with score ', num2str(M)]); 
        match = I;
        corr = im2double(rgb2gray(imread([folder, num2str(I), '.jpeg'])));
        %figure (1), imshow([img, imresize(corr, [img_h, img_w])]);
        graph = imresize(corr, [img_h, img_w]);
    end
    
end

