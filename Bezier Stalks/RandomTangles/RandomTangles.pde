/*

 Random Bezier Tangles in 3D
 http://exnihilo.mezzoblue.com/
 August 2009
 
*/

import processing.opengl.*;



// set up some environment variables
int canvasWidth = 800;
int canvasHeight = 500;

// set up some operating variables
float drawingScale = 2;
int movementDegree = 5;

// define the worms
Worm[] worms;
int numWorms = 20;
int wormPoints = 400;

// create the palette
PGraphics buffer;
PImage paletteSource;
color[] palette;
int paletteCount = 32;



void setup() {
  smooth();
  frameRate(1200);
  size(canvasWidth, canvasHeight, OPENGL);

  // Create an off-screen buffer.
  buffer = createGraphics(800, 500, JAVA2D);
  loadPalette(paletteCount);
  background(palette[0]);
  
  // each worm traces a randomized path through 3D space
  // but the key is that we're going to store its path
  // and then manipulate it later
  worms = new Worm[numWorms];

  for (int i = 0; i < numWorms; i++) {
    wiggle(i);
  };

};





void draw() {
  background(palette[0]);

  // move the sketch to the center of the canvas, compensate for the multiplier offset
  translate(canvasWidth / 2, canvasHeight / 2, 0);

  // rotate the canvas based on mouse x, y position
  rotateX((float) mouseY / 150);
  rotateZ((float) mouseX / 150);

  // adjust the scale based on keyboard input (a, z)
  scale(drawingScale);

  // render each Worm
  for (int i = 0; i < numWorms; i++) {
    worms[i].render();
  };
  
};
