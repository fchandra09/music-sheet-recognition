% Calculate segmentation boundaries for a single row of musical notations
%
% INPUT:
%   row_image (matrix): Image of a single row of musical notations.
%
% OUTPUT:
%   boundaries (matrix): X-by-4 matrix of the segmentation boundaries.
%       The matrix columns contain the following values in this order:
%       min x, max x, min y, and max y.
%   notation_images (cell array): Collection of notation images.
%   center_points (matrix): X-by-2 matrix of the center points. The matrix
%       columns contain the following values in this order: x and y.

function [boundaries, notation_images, center_points] = segmentRow(row_image)

row_image_height = size(row_image, 1);
row_pixel_sum = sum(row_image, 1);

boundaries = double.empty;
notation_images = {};
center_points = double.empty;
black_pixel_found = false;

for column = 1 : size(row_pixel_sum, 2)
    % Start of black pixels - calculate min x
    if row_pixel_sum(column) < row_image_height && black_pixel_found == false
        black_pixel_found = true;

        min_x = column;
    end

    % End of black pixels - calculate max x, min y and max y
    if row_pixel_sum(column) == row_image_height && black_pixel_found == true
        black_pixel_found = false;

        max_x = column - 1;
        min_y = 1;
        max_y = row_image_height;

        notation_image = row_image(:, min_x : max_x);
        notation_image_width = size(notation_image, 2);
        column_pixel_sum = sum(notation_image, 2);

        % Calculate min y
        for row = 1 : size(column_pixel_sum, 1)
            if column_pixel_sum(row) < notation_image_width
                min_y = row;
                break;
            end
        end

        % Calculate max y
        for row = size(column_pixel_sum, 1) : -1 : 1
            if column_pixel_sum(row) < notation_image_width
                max_y = row;
                break;
            end
        end

        notation_image = notation_image(min_y : max_y, :);

        % TODO: If the segment contains more than one notes, separate them.

        % Calculate center point
        [center_point_x, center_point_y] = calculateCenterPoint(notation_image);

        % Adjust the center point coordinate corresponding to the row image
        % coordinate.
        center_point(1) = center_point(1) + min_x - 1;
        center_point(2) = center_point(2) + min_y - 1;

        boundaries = [boundaries; min_x max_x min_y max_y];
        notation_images{end + 1} = notation_image;
        center_points = [center_points; center_point_x center_point_y];
    end
end