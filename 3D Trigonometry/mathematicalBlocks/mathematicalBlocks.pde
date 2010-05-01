/*

 Blocks Around a Circle, Mathematical Variations
 http://exnihilo.mezzoblue.com/
 August 2009
 
*/

import processing.opengl.*;


// set up some environment variables
int canvasWidth = 800;
int canvasHeight = 500;
PGraphics buffer;

PImage paletteSource;
color[] palette;
int paletteCount = 20;

// set up some operating variables
float drawingScale = 50;
float multiplier = 500;
float mainRadius = 3;
float heightSeed = 1;

float offsetY = 0;


Block[] blocks;
// multiples of 36
int numBlocks = 180;



void setup() {
  frameRate(30);
  size(canvasWidth, canvasHeight, OPENGL);
  hint(DISABLE_OPENGL_2X_SMOOTH);
  hint(ENABLE_OPENGL_4X_SMOOTH);

  // Create an off-screen buffer.
  buffer = createGraphics(800, 500, JAVA2D);
  loadPalette(paletteCount);

  background(palette[0]);

  blocks = new Block[numBlocks];
  setBlockCoordinates();
};





void draw() {
  lights();

  // fill the background 
  background(palette[0]);

  // move the sketch to the center of the canvas, compensate for the multiplier offset
  translate(canvasWidth / 2, canvasHeight / 2  + offsetY, 0 / multiplier);

  // rotate the canvas based on mouse x, y position
  rotateX((float) mouseY / 150);
  rotateZ((float) mouseX / 150);

  // adjust the scale based on keyboard input (a, z)
  scale(drawingScale);

  // animate each Block
  for (int i = 0; i < numBlocks; i++) {
    blocks[i].render(i);
  };
  
};






