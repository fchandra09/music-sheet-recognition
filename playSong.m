function playSong(song_c, length_c, song_g, length_g)

available_notes_c = {'C' 'C#' 'D' 'D#' 'E' 'F' 'F#' 'G' 'G#' 'A' 'A#' 'B' ...
    '+C' '+C#' '+D' '+D#' '+E' '+F' '+F#' '+G' '+G#' '+A' '+A#' '+B'};

available_notes_g = {'--D' '--D#' '--E' '--F' '--F#' '--G' '--G#' '--A' '--A#' '--B' ...
    '-C' '-C#' '-D' '-D#' '-E' '-F' '-F#' '-G' '-G#' '-A' '-A#' '-B' 'C'};

song_matrix_c = generateSongMatrix(song_c, length_c, available_notes_c);
song_matrix_g = generateSongMatrix(song_g, length_g, available_notes_g);

soundsc(song_matrix_c, 8192);
if length(song_matrix_g) > 0
    soundsc(song_matrix_g, 8192);
end