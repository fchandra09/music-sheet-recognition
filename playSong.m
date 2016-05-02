function playSong(song_c, length_c, song_g, length_g)

song_matrix_c = generateSongMatrix(song_c, length_c);
song_matrix_g = generateSongMatrix(song_g, length_g);

soundsc(song_matrix_c, 8192);
if length(song_matrix_g) > 0
    soundsc(song_matrix_g, 8192);
end