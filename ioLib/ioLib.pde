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
// (make sure to toggle the size() declaration below if changing)
int sceneDimensions = 3;

// how many random colours will be generated?
int paletteCount = 20;





// create the scene object
Scene scene;

void setup() {

  // set scene width, height, and dimensions of a 3D screen
  size(600, 600, P3D);

  // uncomment this size() declaration if 2D, and comment out the previous one
  //size(600, 600, P2D);

  // turn on 4x sampling anti-aliasing
  // (will not work on every system, change to 2 if there are issues)
  smooth(4);

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

    // how about a couple of rectangles for example?
    translate(0, 0, -25);
    stroke(scene.palette[1]);
    fill(scene.palette[2]);
    rect(-200, -200, 100, 100);

    translate(0, 0, 50);
    stroke(scene.palette[3]);
    fill(scene.palette[4]);
    rect(-50, -50, 75, 75);

    translate(0, 0, -25);
    stroke(scene.palette[5]);
    fill(scene.palette[6]);
    rect(100, 100, 175, 175);

    translate(0, 0, -75);
    stroke(scene.palette[7]);
    fill(scene.palette[8]);
    rect(-200, 100, 125, 125);

    translate(0, 0, 150);
    stroke(scene.palette[7]);
    fill(scene.palette[8]);
    rect(100, -200, 150, 150);
  }

  // write the PDF, if needed
  stopPDFCheck();
  // reset the viewRedraw switch for each loop so we don't peg the CPU
  scene.viewRedraw = false;
}