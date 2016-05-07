% Calculate the center point of a notation image
%
% INPUT:
%   notation_image (matrix): Image of a musical notation.
%
% OUTPUT:
%   center_point_x (double): X-coordinate of the center point.
%   center_point_y (double): Y-coordinate of the center point.

function [center_point_x, center_point_y] = calculateCenterPoint(notation_image)

[notation_image_height, notation_image_width] = size(notation_image);

% Try to remove the vertical line on a musical notation
if notation_image_height > notation_image_width*2
    for row = 1 : notation_image_height
        black_pixel_count = 0;

        % Count the number of black pixels on the row
        for column = 1 : notation_image_width
            if notation_image(row, column) == 0
                black_pixel_count = black_pixel_count + 1;
            end
        end

        % If the black pixel count is smaller than a fifth of the image, assume
        % that it is a vertical line
        if black_pixel_count < notation_image_width / 2

            % Remove vertical line
            notation_image(row, 1 : notation_image_width) = 1;
        end
        
    end
end
%figure, imshow(notation_image);
min_y = 1;
max_y = notation_image_height;
column_pixel_sum = sum(notation_image, 2);

% Recalculate min y
for row = 1 : size(column_pixel_sum, 1)
    if column_pixel_sum(row) < notation_image_width
        min_y = row;
        break;
    end
end

% Recalculate max y
for row = size(column_pixel_sum, 1) : -1 : 1
    if column_pixel_sum(row) < notation_image_width
        max_y = row;
        break;
    end
end

center_point_x = notation_image_width / 2;
center_point_y = (min_y + max_y) / 2;