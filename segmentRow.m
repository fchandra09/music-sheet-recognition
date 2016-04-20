% Calculate segmentation boundaries for a single row of musical notations
%
% INPUT:
%   row_image (matrix): Image of a single row of musical notations.
%
% OUTPUT:
%   boundaries (matrix): X-by-4 matrix of the segmentation boundaries.
%       The matrix columns contain the following values in this order:
%       min x, max x, min y, and max y.

function boundaries = segmentRow(row_image)

row_image_height = size(row_image, 1);
row_pixel_sum = sum(row_image, 1);

boundaries = double.empty;
black_pixel_found = false;

for column = 1 : size(row_pixel_sum, 2)
    % Start of black pixels - calculate min x
    if row_pixel_sum(column) < row_image_height && black_pixel_found == false
        black_pixel_found = true;

        min_x = column - 1;
        if min_x < 1
            min_x = 1;
        end
    end

    % End of black pixels - calculate max x, min y and max y
    if row_pixel_sum(column) == row_image_height && black_pixel_found == true
        black_pixel_found = false;

        % TODO: If the segment contains more than one notes, separate them.

        max_x = column;
        min_y = 1;
        max_y = row_image_height;

        notation_segment = row_image(:, min_x : max_x);
        notation_segment_height = size(notation_segment, 1);
        notation_segment_width = size(notation_segment, 2);
        column_pixel_sum = sum(notation_segment, 2);

        % Calculate min y
        for row = 1 : size(column_pixel_sum, 1)
            if column_pixel_sum(row) < notation_segment_width
                min_y = row - 1;
                if min_y < 1
                    min_y = 1;
                end
                break;
            end
        end

        % Calculate max y
        for row = size(column_pixel_sum, 1) : -1 : 1
            if column_pixel_sum(row) < notation_segment_width
                max_y = row + 1;
                if (max_y > notation_segment_height)
                    max_y = notation_segment_height;
                end
                break;
            end
        end

        boundaries = [boundaries; min_x max_x min_y max_y];
    end
end