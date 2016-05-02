function note_matrix = generateNoteMatrix(note_index, duration)

note_matrix = sin(2 * pi * [1 : duration] / 8192 * 440 * 2^((note_index - 4) / 12));
note_matrix = note_matrix';