% Detect staff lines and remove them from the image
%
% INPUT:
%   file_path (string): Image file path
%   display_intermediate_result (boolean): Flag to display the image with
%       the staff lines removed.
%
% OUTPUT:
%   image (matrix): Image with the staff lines removed. The matrix contains
%       0 (black pixels) and 1 (white pixels) only.
%   staff_lines (matrix): X-by-5 matrix containing the y-coordinates of
%       staff lines.

function [image, staff_lines] = extractLines(file_path, display_intermediate_result)

% Read image
image = imread(file_path);
image = rgb2gray(image);
image = im2double(image);

[image_height, image_width] = size(image);

% Adjust image to be black and white only
image (image < 0.9) = 0;
image (image >= 0.9) = 1;

staff_lines = double.empty;
line_found = 0;

for row = 1 : image_height
    black_pixel_count = 0;

    % Count the number of black pixels on the row
    for column = 1 : image_width
        if (image(row, column) == 0)
            black_pixel_count = black_pixel_count + 1;
        end
    end  

    % If the black pixel count is larger than half of the image, assume
    % that it is a staff line
    if black_pixel_count > image_width * 0.5

        % Remove staff line
        for column = 1 : image_width
            image(row, column) = 1;
        end
        
        % Fill in the gap caused by the staff line removal
        for column = 1 : image_width
            if image(row - 1, column) == 0 && image(row + 1, column) == 0
                image(row, column) = 0;
            end
        end

        % Store the line only if the previous row is not a line. This is to
        % handle scenario where the line thickness is more than 1 pixel.
        if line_found == 0
            staff_lines = [staff_lines; row];
        end

        line_found = 1;
    else
        line_found = 0;
    end
end

% Reshape into X-by-5 matrix
staff_lines = reshape(staff_lines, [5, size(staff_lines, 1) / 5]);
staff_lines = staff_lines';

if display_intermediate_result
    figure('Name', 'Cleaned Image');
    imshow(image);
end