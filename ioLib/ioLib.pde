import processing.pdf.*;
import processing.opengl.*;
/*

 Common Library for basic Input / Output Functions
 http://exnihilo.mezzoblue.com/
 April 2010


 See README for documentation.
  
 
*/


//
// user-configurable settings
//
// set this to 2 for flat 2D, 3 for openGL 3D
int sceneDimensions = 3;

// how many random colours will be generated?
int paletteCount = 20;





// create the scene object
Scene scene;

void setup() {

  // set scene width, height, and dimensions
  scene = new Scene(600, 600, sceneDimensions, paletteCount);

  // create a random palette
  scene.createPalette();

  // set the viewRedraw flag coming out of setup() so that we get the initial draw
  scene.viewRedraw = true;
}





void draw() {
  // set up the PDF export, if needed
  startPDFCheck(scene.filePrefix + "-####");

  // see if there's been mouse action
  checkMouse();

  // if we're going to redraw, let's go for it
  if (scene.viewRedraw == true) {  

    // make the various scene adjustments
    adjustScene();

    // fill the background 
    background(scene.palette[0]);





    // this is about where you'd start doing useful stuff

    // how about a rectangle?
    rect(-50, -50, 100, 100);




  }

  // write the PDF, if needed
  stopPDFCheck();
  // reset the viewRedraw switch for each loop so we don't peg the CPU
  scene.viewRedraw = false;
}
