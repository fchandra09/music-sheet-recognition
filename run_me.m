%% Get Training data
[simple_train, complex_train] = read_training_data();

%% Input
input_folder = 'input/';
input_file_name = 'Mary Had a Little Lamb.jpg';
display_intermediate_result = true;

%% Staff lines detection and removal
file_path = [input_folder input_file_name];
[cleaned_image, lines] = extractLines(file_path, display_intermediate_result);

%% Musical notation segmentation
boundaries = segmentImage(cleaned_image, lines, display_intermediate_result);

%% Musical notation classification
width = ceil(sqrt(segment_index));
figure
for segment_index = 1 : size(boundaries, 1)
    min_x = boundaries(segment_index, 1);
    max_x = boundaries(segment_index, 2);
    min_y = boundaries(segment_index, 3);
    max_y = boundaries(segment_index, 4);
    notation_segment = cleaned_image(min_y : max_y, min_x : max_x);

    [match, graph, rate] = calculateDistance(notation_segment, simple_train);
    if match ~= -1
        if mod(segment_index, 25) == 0
            figure
        end
        subplot(5, 5, mod(segment_index, 25)+1);
        imshow([notation_segment, graph]);
        title([num2str(segment_index),' rate: ',sprintf('%.2f', rate)]);
    else
        if mod(segment_index, 25) == 0
            figure
        end
        subplot(5, 5, mod(segment_index, 25)+1);
        imshow(notation_segment);
        title('Not Note');
    end

    % notation_type = functionName(notation_segment);
end