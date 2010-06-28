/*
  --------------------------
  
  BasicIO
  Functions and classes that define the basic input and output functions

  Scene - a class that stores visual properties and scene manipulation methods
  checkMouse()
  keyPressed()
  startPDFCheck()
  stopPDFCheck()
  adjustScene()
  listFileNames()
  getExtension()
  
  --------------------------
*/




// a container object to hold the various scene properties
class Scene {

  // basic environment variables
  int canvasWidth, canvasHeight;
  int multiplier = 55;
  // 2D or 3D?
  int dimensions = 2;
  Boolean is3D = false;
  
  // prefix for saved-out files
  String filePrefix = "sketch";

  // create buffer and setup palette variables
  color[] palette;
  int paletteCount = 20;
  PGraphics buffer;
  PImage paletteSource;
  // if this is set, the palette will always be derived from this image otherwise it's random
  // this is useful for re-loading a saved palette
  //String paletteImage = "palette-saved.png";
  String paletteImage = "";

  // interaction variables
  boolean writePDF;
  Boolean viewRedraw = true;

  // adjustable offset values
  float uiIncrement = 1;
  float drawingScale = 1;
  float rotationX = 0, rotationY = 0, rotationZ = 0;
  float offsetX = 0, offsetY = 0, offsetZ = 0;

  Scene(int wide, int high, int dim, int count) {
    canvasWidth = wide;
    canvasHeight = high;
    paletteCount = count;

    if (dim == 3) {
      size(canvasWidth, canvasHeight, OPENGL);
      is3D = true;
    } else {
      size(canvasWidth, canvasHeight, JAVA2D);
    }

    // for some reason it seems as if both of these hints are necessary for true 4x sampling
    smooth();
    hint(DISABLE_OPENGL_2X_SMOOTH);
    hint(ENABLE_OPENGL_4X_SMOOTH);
  }

  void createPalette() {
    // Create an off-screen buffer.
    buffer = createGraphics(scene.canvasWidth, scene.canvasHeight, JAVA2D);
    // load in a new palette
    loadPalette();
  }

  //
  // Load in a source image and create a random palette from it
  //
  void loadPalette() {
    // if a specific image is set, use it
    if (scene.paletteImage != "") {

      // load in an image
      scene.paletteSource = loadImage(scene.paletteImage);
    
      // initialize the palette array
      scene.palette = new color[paletteCount];

      // throw it into the buffer  
      placeImageInBuffer(scene.paletteSource, 0, 0);
  
      // load in the stored palette
      for (int i = 0; i < paletteCount; i++) {
        color pick = scene.buffer.get(scene.canvasWidth / 2 + 1, scene.canvasHeight / 2 - paletteCount * 10 + i * 20 + 1);
        scene.palette[i] = pick;
      }
      
    // if no image is set, pick a random one
    } else {

      ArrayList filenames = listFileNames(dataPath("") + "/paletteSource/");
      
      // load in an image
      scene.paletteSource = loadImage(
        dataPath("") + "/paletteSource/" + (String) filenames.get(
          int(
            random(1, filenames.size())
          )
        )
      );
    
      // initialize the palette array
      scene.palette = new color[paletteCount];
      
      // throw it into the buffer  
      placeImageInBuffer(scene.paletteSource, 0, 0);

      // pull out a random palette
      for (int i = 0; i < paletteCount; i++) {
        int colorX = int(random(0, 333));
        int colorY = int(random(0, 333));
        color pick = scene.buffer.get(colorX, colorY);
        scene.palette[i] = pick;
      }
    
    }
  }

  // place image within the buffer
  void placeImageInBuffer(PImage img, int x, int y) {
      scene.buffer.beginDraw();
      scene.buffer.image(img, x, y);
      scene.buffer.endDraw();
  }
  
}



// if the canvas is being dragged, set the cursor and adjust rotation
void checkMouse() {
  if(mousePressed) {
  
    // any mouse action should probably toggle a re-draw
    scene.viewRedraw = true;
  
    // use a cursor image while rotating the scene (I suspect this was causing crashes in OS X, removed for now)
    // cursor(scene.cursorHand, scene.cursorHand.width / 2, scene.cursorHand.height / 2);
    scene.rotationY += ((float) (mouseX - pmouseX) / 180);
    scene.rotationX += ((float) (mouseY - pmouseY) / 180);
  }
}

// zoom in / out + save
void keyPressed() {
  if (int(key) == 61) {
    scene.drawingScale += 0.1;
    scene.viewRedraw = true;
  }
  if (int(key) == 43) {
    scene.drawingScale += 1;
    scene.viewRedraw = true;
  }
  if (int(key) == 45) {
    scene.drawingScale -= 0.1;
    scene.viewRedraw = true;
  }
  if (int(key) == 95) {
    scene.drawingScale -= 1;
    scene.viewRedraw = true;
  }
    
  // set a lower boundary
  if (scene.drawingScale < 0.1) {
     scene.drawingScale = 0.1;
  }


  // check arrow keys / modifiers to manipulate scene
  if (keyEvent.isControlDown()) {
    if (keyEvent.isShiftDown()) {
      scene.uiIncrement = 1000;
    } else {
      scene.uiIncrement = 100;
    }
  } else if (keyEvent.isShiftDown()) {
    scene.uiIncrement = 10;
  } else {
    scene.uiIncrement = 1;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      scene.offsetY -= scene.uiIncrement;
      scene.viewRedraw = true;
    } else if (keyCode == DOWN) {
      scene.offsetY += scene.uiIncrement; 
      scene.viewRedraw = true;
    } else if (keyCode == LEFT) {
      scene.offsetX -= scene.uiIncrement; 
      scene.viewRedraw = true;
    } else if (keyCode == RIGHT) {
      scene.offsetX += scene.uiIncrement; 
      scene.viewRedraw = true;
    }
  }

  // if 'c' is pressed, save the colour palette
  // (kinda sketchy, only works without zooming)
  if (int(key) == 99) {
    for (int i = 0; i < scene.paletteCount; i++) {
      translate(0, 0);
      fill(scene.palette[i]);
      rect(0, 0 - scene.paletteCount * 10 + i * 20, 20, 20);
    }
    save("palette-" + int(random(0, 9999)) + ".png");
  }
  // if 'p' is pressed, save out a PDF
  if (int(key) == 112) {
    scene.writePDF = true;
  }
  // if 'r' is pressed, reload the palette
  if (int(key) == 114) {
    scene.loadPalette();
    scene.viewRedraw = true;
  }
  // if 's' is pressed, save out a PNG image
  if (int(key) == 115) {
    save(scene.filePrefix + "-" + int(random(0, 9999)) + ".png");
  }

}


// setup the PDF save
void startPDFCheck(String fileName) {
  if (scene.writePDF) {
    if (scene.is3D) {
      beginRaw(PDF, fileName + ".pdf");
    } else {
      beginRecord(PDF, fileName + ".pdf");
    }
    scene.viewRedraw = true;
  }
}

// execute the PDF save
void stopPDFCheck() {
  if (scene.writePDF) {
    if (scene.is3D) {
      endRaw();
    } else {
      endRecord();
    }
    scene.writePDF = false;
  }
}


// make the scene adjustments
void adjustScene() {
  // move the sketch to the center of the canvas, compensate for the multiplier offset
  translate(scene.canvasWidth / 2 + scene.offsetX, scene.canvasHeight / 2 + scene.offsetY);

  // rotate the canvas
  if (scene.is3D) {
    lights();
    rotateX(scene.rotationX);
    rotateY(scene.rotationY);
    rotateZ(scene.rotationZ);
  } else {
    rotate(scene.rotationY);
  }

  // adjust the scale based on keyboard input (a, z)
  scale(scene.drawingScale);
}




// This function returns all the files in a directory as an arraylist of Strings  
// modified from: http://processing.org/learning/topics/directorylist.html
ArrayList listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // dump the files into a string array
    String names[] = file.list();
    // create an ArrayList for the final file list
    ArrayList names2 = new ArrayList();

    // run through and remove files that don't match the extension
    for (int i = 0; i < names.length; i++) {
      String fileExt = getExtension(names[i]);
      if ((fileExt.toLowerCase().equals("png")) || (fileExt.toLowerCase().equals("jpg")) || (fileExt.toLowerCase().equals("gif"))) {
        names2.add(names[i]);
      };

    };
    return names2;
  } 
  else {
    // If it's not a directory
    return null;
  }
}


// get the file extension of the document
String getExtension(String file) {
  return file.substring(file.length() - 3).toLowerCase();
};



// add an alpha value to an existing color
// adapted from Processing docs on right/left shift functions
color addAlpha(color col, int opacity) {
  //  int a = (col >> 24) & 0xFF;
  int r = (col >> 16) & 0xFF;  // Faster way of getting red(argb)
  int g = (col >> 8) & 0xFF;   // Faster way of getting green(argb)
  int b = col & 0xFF;          // Faster way of getting blue(argb)

  opacity = opacity << 24;
  r = r << 16;
  g = g << 8;
  color newCol = opacity | r | g | b;
  return(newCol);
}
