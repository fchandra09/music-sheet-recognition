% Use trining set to detect the actual notes
%
% INPUT:
%   img (matrix): Note Image
%   train_data (cell): a cell of X-by-X matrices of training images
%
% OUTPUT:
%   match (double): the matching notes
%   graph (matrix): the matching training image
%   rate (double): the matching rate
function [match, graph, rate] = calculateDistance(img, train_data)

nfiles = size(train_data, 2);
scores = zeros(nfiles, 1); 
[img_h, img_w] = size(img);

for i = 1:nfiles
    target_img = train_data{i};
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
    if I == 11 && img_h > img_w*3 || M < 0.8
        match = -1;
        %disp('not note');
        graph = 1;
        rate = 0;
    else
        %disp(['The closest match is image number ', num2str(I), ' with score ', num2str(M)]); 
        match = I;
        graph = imresize(train_data{I}, [img_h, img_w]);
        rate = M;
    end
    
end

