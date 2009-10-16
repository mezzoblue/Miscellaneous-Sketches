/*

  Interaction functions
  
  - mouse down resets the coordinates
  - mousewheel zooms in and out
  - pressing 'a' zooms in, 'z' zooms out
  - pressing 's' saves a screencap

*/


void mousePressed() {
    loadPalette(paletteCount);
    setCoordinates();
};


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
    save("bezier-" + mouseX + mouseY + ".png");
  };

  // if spacebar is pressed, reload the palette/points
  if (int(key) == 32) {
    loadPalette(paletteCount);
  };

};





void mouseWheel(int delta) {
  if (delta == 1) {
     drawingScale += 0.05;
  } else {
     drawingScale -= 0.05;
  }
}

