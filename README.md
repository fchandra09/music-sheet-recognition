# Printed Music Sheet Recognition

*University of Illinois at Urbana-Champaign  
Computer Vision (CS543) Spring 2016 Final Project*  

### Summary
Optical Music Recognition is a topic that has been studied extensively in the field of Computer Vision. Using the commonly used algorithm, our project aims to interpret a music sheet into playable music. We will take an image of a clean printed music sheet as an input, recognize the musical notations in the content, and play the musical tones as an output.

### Process
1. Staff Lines Detection and Removal
Detect the location of all staff lines and remove them to get the musical symbols. The staff lines location will be stored for Segmentation and Note Identification.
2. Segmentation
Perform segmentation to extract the individual symbol.
3. Symbol Recognition
Perform template matching on each symbol to determine the musical notation.
4. Note Identification
For each note, determine the pitch by comparing the symbol location and the staff lines location. Also determine the duration based on the result from Symbol Recognition.
5. Music Transformation
Create a playable music based on the pitch and duration of the notes.

More information can be found on the final report and presentation slides.

### Sample Results
* [Love Me Tender](https://www.youtube.com/watch?v=m-BWrnQkLsc)
* [Mary Had a Little Lamb](https://www.youtube.com/watch?v=x7-oeOPcq6g)

### Development Specification
**Language:** MATLAB
