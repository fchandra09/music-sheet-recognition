% Input
input_folder = 'input/';
input_file_name = 'Twinkle Twinkle Little Star.jpg';
display_intermediate_result = true;

% Staff lines detection and removal
file_path = [input_folder input_file_name];
[cleaned_image, lines] = extractLines(file_path, display_intermediate_result);
