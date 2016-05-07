function [song, note_length, c_count, g_count] = convert_song(notes_match, lines, center_points)
length = size(notes_match, 2);
clef = 1;
note_counter(1) = 1;
note_counter(2) = 1;
line_counter = 0;
centers = mean(lines, 2);
unit = ((lines(1, 2)-lines(1, 1))/2 + (lines(1, 3)-lines(1, 2))/2 + (lines(1, 4)-lines(1, 3))/2 + (lines(1, 5)-lines(1, 4))/2)/4;
notes_1 = {'C' 'D' 'E' 'F' 'G' 'A' 'B' '+C' '+D' '+E' '+F' '+G' '+A' '+B'};
notes_2 = {'C' '-B' '-A' '-G' '-F' '-E' '-D' '-C' '--B' '--A' '--G' '--F' '--E' '--D'};
flat = false;
sharp = false;
for i = 1:length
   if notes_match(i) ~= -1
      if  notes_match(i) == 1 || notes_match(i) == 2
          note_length(clef, note_counter(clef)) = 4;
          num = round((centers(line_counter)-center_points(i, 2))/unit);
          song(clef, note_counter(clef)) = convert(num, clef, notes_1, notes_2, flat, sharp);
          note_counter(clef) = note_counter(clef)+1;
          flat = false;
          sharp = false;
      elseif notes_match(i) == 3 || notes_match(i) == 4 || notes_match(i) == 5 || notes_match(i) == 6
          note_length(clef, note_counter(clef)) = 2;
          num = round((centers(line_counter)-center_points(i, 2))/unit);
          song(clef, note_counter(clef)) = convert(num, clef, notes_1, notes_2, flat, sharp);
          note_counter(clef) = note_counter(clef)+1;    
          flat = false;
          sharp = false;
      elseif notes_match(i) == 7 || notes_match(i) == 8 || notes_match(i) == 9 || notes_match(i) == 10
          note_length(clef, note_counter(clef)) = 1;
          num = round((centers(line_counter)-center_points(i, 2))/unit);
          song(clef, note_counter(clef)) = convert(num, clef, notes_1, notes_2, flat, sharp);
          note_counter(clef) = note_counter(clef)+1;    
          flat = false;
          sharp = false;
      elseif notes_match(i) == 21 || notes_match(i) == 22 || notes_match(i) == 23 || notes_match(i) == 20
          note_length(clef, note_counter(clef)) = 0.5;
          num = round((centers(line_counter)-center_points(i, 2))/unit);
          song(clef, note_counter(clef)) = convert(num, clef, notes_1, notes_2, flat, sharp);
          note_counter(clef) = note_counter(clef)+1;    
          flat = false;
          sharp = false;
      elseif notes_match(i) == 11
          upper_line = centers(line_counter)+unit*2;
          if upper_line-center_points(i, 2) < center_points(i, 2)-centers(line_counter)
              note_length(clef, note_counter(clef)) = 4;
          else
              note_length(clef, note_counter(clef)) = 2; 
          end
          song(clef, note_counter(clef)) = 'Q';
          note_counter(clef) = note_counter(clef)+1;    
      elseif notes_match(i) == 12
          note_length(clef, note_counter(clef)) = 1;
          song(clef, note_counter(clef)) = 'Q';
          note_counter(clef) = note_counter(clef)+1;  
      elseif notes_match(i) == 13
          note_length(clef, note_counter(clef)) = 0.5;
          song(clef, note_counter(clef)) = 'Q';
          note_counter(clef) = note_counter(clef)+1; 
      elseif notes_match(i) == 14
          note_length(clef, note_counter(clef)) = 0.25;
          song(clef, note_counter(clef)) = 'Q';
          note_counter(clef) = note_counter(clef)+1; 
      elseif notes_match(i) == 15
          clef = 1;
          line_counter = line_counter+1;
      elseif notes_match(i) == 16
          clef = 2;
          line_counter = line_counter+1;
      elseif notes_match(i) == 17
          sharp = true;
      elseif notes_match(i) == 18
          flat = true;
      elseif notes_match(i) == 19
          
      elseif notes_match(i) == 100
          note_length(clef, note_counter(clef)-1) = note_length(clef, note_counter(clef)-1)*1.5;
      end
   end
end
c_count = note_counter(1)-1;
g_count = note_counter(2)-1;
end

function note = convert(num, clef, notes_1, notes_2, flat, sharp)
    if flat
        if clef == 1
            num = num + 7;
            note = strcat(notes_1(num-1), '#');
        else
            num = num+8;
            num = 15-num;
            note = strcat(notes_2(num+1), '#');
        end
    elseif sharp
        if clef == 1
            num = num + 7;
            note = strcat(notes_1(num), '#');
        else
            num = num+8;
            num = 15-num;
            note = strcat(notes_2(num), '#');
        end       
    else
        if clef == 1
            num = num + 7;
            note = notes_1(num);
        else
            num = num+8;
            num = 15-num;
            note = notes_2(num);
        end
    end
end