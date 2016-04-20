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

function boundaries = segmentImage(image, staff_lines, display_intermediate_result)

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

% Segment image into rows and get the boundaries for each row
for row = 1 : size(staff_lines, 1)
    row_min_y = staff_lines(row, 1) - (2 * line_height);
    if row_min_y < 1
        row_min_y = 1;
    end

    row_max_y = staff_lines(row, 5) + (2 * line_height);
    if row_max_y > size(image, 1)
        row_max_y = size(image, 1);
    end

    row_boundaries = segmentRow(image(row_min_y : row_max_y, :));

    % Adjust y-coordinates corresponding to the image coordinate
    row_boundaries(:, 3) = row_boundaries(:, 3) + row_min_y - 1;
    row_boundaries(:, 4) = row_boundaries(:, 4) + row_min_y - 1;

    boundaries = [boundaries; row_boundaries];
end

if display_intermediate_result
    figure('Name', 'Segmented Image'), imagesc(image), axis off, colormap(gray), truesize, hold on;
    plot([boundaries(:, 1) boundaries(:, 2)]', [boundaries(:, 3) boundaries(:, 3)]', 'r');
    plot([boundaries(:, 1) boundaries(:, 2)]', [boundaries(:, 4) boundaries(:, 4)]', 'r');
    plot([boundaries(:, 1) boundaries(:, 1)]', [boundaries(:, 3) boundaries(:, 4)]', 'r');
    plot([boundaries(:, 2) boundaries(:, 2)]', [boundaries(:, 3) boundaries(:, 4)]', 'r');
end