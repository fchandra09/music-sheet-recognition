%% Input
input_folder = 'input/';
input_file_name = 'Twinkle Twinkle Little Star.jpg';
training_data_folder = 'train_simple/';
display_intermediate_result = false;

%% Staff lines detection and removal
file_path = [input_folder input_file_name];
[cleaned_image, lines] = extractLines(file_path, display_intermediate_result);

%% Musical notation segmentation
[boundaries, notation_images, center_points] = segmentImage(cleaned_image, lines, display_intermediate_result);

%% Get training data
training_images = readTrainingData(training_data_folder);

%% Musical notation classification
notes_match = zeros(size(notation_images, 2));
for segment_index = 1 : size(notation_images, 2)
    notation_image = notation_images{segment_index};
    center_point = center_points(segment_index, :);
    [match, graph, rate] = calculateDistance(notation_image, training_images);
    notes_match(segment_index) = match;
end

%% Convert notes to song
[song, note_length, c_count, g_count] = convert_song(notes_match, lines, center_points);

if g_count == 0
    song_g = [];
    note_length_g = [];
else
    song_g = song(2,1:g_count);
    note_length_g = note_length(2,1:g_count);
end

playSong(song(1,1:c_count), note_length(1,1:c_count), song_g, note_length_g);