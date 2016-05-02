%% Input
input_folder = 'input/';
input_file_name = 'Twinkle Twinkle Little Star.jpg';
training_data_folder = 'train_simple/';
display_intermediate_result = true;

%% Staff lines detection and removal
file_path = [input_folder input_file_name];
[cleaned_image, lines] = extractLines(file_path, display_intermediate_result);

%% Musical notation segmentation
[boundaries, notation_images, center_points] = segmentImage(cleaned_image, lines, display_intermediate_result);

%% Get training data
training_images = readTrainingData(training_data_folder);

%% Musical notation classification
figure
for segment_index = 1 : size(notation_images, 2)
    notation_image = notation_images{segment_index};
    center_point = center_points(segment_index, :);

    [match, graph, rate] = calculateDistance(notation_image, training_images);
    if match ~= -1
        if mod(segment_index, 25) == 0
            figure
        end
        subplot(5, 5, mod(segment_index, 25)+1);
        imshow([notation_image, graph]);
        title([num2str(segment_index),' rate: ',sprintf('%.2f', rate)]);
    else
        if mod(segment_index, 25) == 0
            figure
        end
        subplot(5, 5, mod(segment_index, 25)+1);
        imshow(notation_image);
        title('Not Note');
    end
end