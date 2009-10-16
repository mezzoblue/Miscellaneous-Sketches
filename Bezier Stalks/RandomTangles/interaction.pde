
// zoom in / out + save
void keyPressed() {

  // if 'a' is pressed, zoom in
  if (int(key) == 97) {
     drawingScale += 0.05;
  };
  // if 'z' is pressed, zoom out
  if (int(key) == 122) {
     drawingScale -= 0.05;
  };
  // set a lower boundary
  if (drawingScale < 0.1) {
     drawingScale = 0.1;
  };

  // if 's' is pressed, save out an image
  if (int(key) == 115) {
    save("bezier-" + int(random(0, 9999)) + ".png");
  };


   // if spacebar is pressed, blank out the canvas
  if (int(key) == 32) {
    loadPalette(paletteCount);
  };

};


