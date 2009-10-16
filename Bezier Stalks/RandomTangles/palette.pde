/*

  Create a palette based on a source image

*/

void loadPalette(int paletteCount) {

  // load in an image
  paletteSource = loadImage(int(random(1,9)) + ".jpg");

  palette = new color[paletteCount];
  
  // load the image into the buffer
  buffer.beginDraw();
  buffer.image(paletteSource, 0, 0);
  buffer.endDraw();
  

  for (int i = 0; i < paletteCount; i++) {
    int colorX = int(random(0, 333));
    int colorY = int(random(0, 333));
    color pick = buffer.get(colorX, colorY);
//    println(hex(pick));
    palette[i] = pick;
  };
  
};
