function song_matrix = generateSongMatrix(song, length)

available_notes = {'--C' '--C#' '--D' '--D#' '--E' '--F' '--F#' '--G' '--G#' '--A' '--A#' '--B' ...
    '-C' '-C#' '-D' '-D#' '-E' '-F' '-F#' '-G' '-G#' '-A' '-A#' '-B' ...
    'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' ...
    '+C' '+C#' '+D' '+D#' '+E' '+F' '+F#' '+G' '+G#' '+A' '+A#' '+B'};

single_duration = 3072;
song_matrix = [];

for song_index = 1 : size(song, 2)
    note = song(song_index);
    note_length = length(song_index);
    duration = note_length * single_duration;

    if strcmp(note, 'Q') == 1
        note_matrix = zeros(duration, 1);
    else
        note_index = strcmp(note, available_notes);
        note_index = find(note_index);

        note_matrix = generateNoteMatrix(note_index, duration);
    end

    song_matrix = [song_matrix; note_matrix; zeros(note_length * 72, 1)];
end