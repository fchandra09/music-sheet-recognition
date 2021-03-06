% Calculate segmentation boundaries for an image of musical notations
%
% INPUT:
%   image (matrix): Image with the staff lines removed. The matrix contains
%       0 (black pixels) and 1 (white pixels) only.
%   staff_lines (matrix): X-by-5 matrix containing the y-coordinates of
%       staff lines.
%   display_intermediate_result (boolean): Flag to display the image with
%       the staff lines removed.
%
% OUTPUT:
%   boundaries (matrix): X-by-4 matrix of the segmentation boundaries.
%       The matrix columns contain the following values in this order:
%       min x, max x, min y, and max y.
%   notation_images (cell array): Collection of notation images.
%   center_points (matrix): X-by-2 matrix of the center points. The matrix
%       columns contain the following values in this order: x and y.

function [boundaries, notation_images, center_points] = segmentImage(image, staff_lines, display_intermediate_result)

[image_height, image_width] = size(image);

% Get the line height using the max value
line_height = 0;
for column = 1 : (size(staff_lines, 2) - 1)
    column_diff = staff_lines(:, column + 1) - staff_lines(:, column);

    current_line_height = max(column_diff);
    if current_line_height > line_height
        line_height = current_line_height;
    end
end

boundaries = double.empty;
notation_images = {};
center_points = double.empty;

% Segment image into rows and get the boundaries for each row
for row = 1 : size(staff_lines, 1)
    row_min_y = staff_lines(row, 1) - (2 * line_height);
    if row_min_y < 1
        row_min_y = 1;
    end

    row_max_y = staff_lines(row, 5) + (2 * line_height);
    if row_max_y > image_height
        row_max_y = image_height;
    end

    [row_boundaries, row_notation_images, row_center_points] = segmentRow(image(row_min_y : row_max_y, :));

    % Adjust y-coordinates corresponding to the image coordinate
    row_boundaries(:, 3) = row_boundaries(:, 3) + row_min_y - 1;
    row_boundaries(:, 4) = row_boundaries(:, 4) + row_min_y - 1;
    row_center_points(:, 2) = row_center_points(:, 2) + row_min_y - 1;

    boundaries = [boundaries; row_boundaries];
    notation_images = cat(2, notation_images, row_notation_images);
    center_points = [center_points; row_center_points];
end

if display_intermediate_result
    min_x_boundaries = boundaries(:, 1) - 1;
    min_x_boundaries (min_x_boundaries < 1) = 1;

    max_x_boundaries = boundaries(:, 2) + 1;
    max_x_boundaries ( max_x_boundaries > image_width) = image_width;

    min_y_boundaries = boundaries(:, 3) - 1;
    min_y_boundaries (min_y_boundaries < 1) = 1;

    max_y_boundaries = boundaries(:, 4) + 1;
    max_y_boundaries (max_y_boundaries > image_height) = image_height;

    figure('Name', 'Segmented Image'), imagesc(image), axis off, colormap(gray), truesize, hold on;
    plot([min_x_boundaries max_x_boundaries]', [min_y_boundaries min_y_boundaries]', 'r');
    plot([min_x_boundaries max_x_boundaries]', [max_y_boundaries max_y_boundaries]', 'r');
    plot([min_x_boundaries min_x_boundaries]', [min_y_boundaries max_y_boundaries]', 'r');
    plot([max_x_boundaries max_x_boundaries]', [min_y_boundaries max_y_boundaries]', 'r');

    figure('Name', 'Musical Notation Center Points'), imagesc(image), axis off, colormap(gray), truesize, hold on;
    plot(center_points(:, 1), center_points(:, 2), 'xr', 'LineWidth', 2);
end