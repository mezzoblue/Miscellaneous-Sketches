/*

  Interaction functions
  
  - mousewheel zooms in and out
  - pressing 'a' zooms in, 'z' zooms out
  - pressing 's' saves a screencap
  - pressing spacebar resets the coordinates, palette

*/

int oldMouseY;

void mouseDragged() {
  if (oldMouseY > mouseY) {
   offsetY -= 2;
  } else {
   offsetY += 2;
  };
  oldMouseY = mouseY;
};


// zoom in / out + save
void keyPressed() {
   println(int(key));
  // if 'a' is pressed, zoom in
  if (int(key) == 97) {
     drawingScale += 0.5;
  };
  // if 'z' is pressed, zoom out
  if (int(key) == 122) {
     drawingScale -= 0.5;
  };
  // set a lower boundary
  if (drawingScale < 0.1) {
     drawingScale = 0.1;
  };

  // if 's' is pressed, save out an image
  if (int(key) == 115) {
    save("screencap-" + int(random(0, 9999)) + ".png");
  };


  // if spacebar is pressed, reload the palette/points
  if (int(key) == 32) {
    loadPalette(paletteCount);
    setBlockCoordinates();
  };

};


void mouseWheel(int delta) {
  if (delta == 1) {
     drawingScale += 0.5;
  } else {
     drawingScale -= 0.5;
  }
}

