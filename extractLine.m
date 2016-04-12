function [ret] = extractLine(img)
%Detect lines for a sheet music
%  INPUT: (img)
%  img:         name of the image
%  OUTPUT: [ret]
%  ret:       A X by 5 matrix containing the line coordinates of each line.
%
image = imread(img);
image = rgb2gray(image);
image = im2double(image);
[h, w] = size(image);

for i = 1:h
    for j = 1:w
        if (image(i, j) <0.9)
            image(i, j) = 0;
        else
            image(i, j) = 1;
        end
    end
end
figure, imshow(image), hold on
lines = zeros(h);
check = 0;
line_count = 1;
for i = 1:h
    count = 0;
    for j = 1:w
        
        if (image(i, j) == 0)
            count = count+1;
        end
    end
    
    if count > w*0.5
        for j = 1:w
            image(i, j) = 1;
        end     
        if check == 0
            lines(line_count) = i;
            line_count = line_count+1;
        end
        check = 1;
    else
        check = 0;
    end
end
display(line_count)
ret = zeros(line_count-1, 1);
count = 1;
for i = 1:size(lines)
    if lines(i) > 0
        xy = [[w, lines(i)]; [0, lines(i)]];
        plot(xy(:,1),xy(:,2),'LineWidth',1,'Color','green');
        ret(count) = lines(i);
        count = count+1;
    end
end
ret = reshape(ret, [5, size(ret, 1)/5]);
ret = ret.';
display(ret);
