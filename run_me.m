%% Input
input_folder = 'input/';
input_file_name = 'Mary Had a Little Lamb.jpg';
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
notes_match = zeros(size(notation_images, 2));
for segment_index = 1 : size(notation_images, 2)
    notation_image = notation_images{segment_index};
    center_point = center_points(segment_index, :);
    [match, graph, rate] = calculateDistance(notation_image, training_images);
    notes_match(segment_index) = match;
%     if match ~= -1
%         if mod(segment_index, 25) == 0
%             figure
%         end
%         subplot(5, 5, mod(segment_index, 25)+1);
%         imshow([notation_image, graph]);
%         title([num2str(segment_index),' rate: ',sprintf('%.2f', rate)]);
%     else
%         if mod(segment_index, 25) == 0
%             figure
%         end
%         subplot(5, 5, mod(segment_index, 25)+1);
%         imshow(notation_image);
%         title('Not Note');
%     end
end

%% Convert notes to song
[song, note_length, c_count, g_count] = convert_song(notes_match, lines, center_points);
disp(c_count);
disp(g_count);