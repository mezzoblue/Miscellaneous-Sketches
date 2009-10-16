/*

 Bezier 3D Blossom
 dave@mezzoblue.com
 July 2009
 
*/

import processing.opengl.*;


// set up some environment variables
int canvasWidth = 500;
int canvasHeight = 500;
PGraphics buffer;

PImage paletteSource;
color[] palette;
int paletteCount = 5;

// set up some operating variables
float drawingScale = 1;
float multiplier = 200;
float seedX = 0;
float seedY = 1;
float seedZ = 2;

float bezierX = 0;
float bezierY = 1;
float bezierZ = 2;


Strand[] points;
int numPoints = 5000;



void setup() {
  smooth();
  frameRate(30);
  size(canvasWidth, canvasHeight, OPENGL);


  // Create an off-screen buffer.
  buffer = createGraphics(800, 500, JAVA2D);
  loadPalette(paletteCount);

  background(palette[0]);

  points = new Strand[numPoints];
  setCoordinates();

};





void draw() {
  // fill the background 
  background(palette[0]);


  // move the sketch to the center of the canvas, compensate for the multiplier offset
  translate(canvasWidth / 2, canvasHeight / 1.6, 0 / multiplier);

  // rotate the canvas based on mouse X position
  rotateX((float) mouseY / 150);
  rotateZ((float) mouseX / 150);

  // adjust the scale based on keyboard input (a, z)
  scale(drawingScale);

  // animate each Strand
  for (int i = 0; i < numPoints; i++) {
    points[i].jiggle(i);
    points[i].render(i);
  };
  
};





// populate random coordinates
void setCoordinates() {
  for (int i = 0; i < numPoints; i++) {

    // create a single temp Strand object
    Strand obj = new Strand();

    seedX += 0.005;
    seedY += 0.005;
    seedZ += 0.005;

    // set the temp object's x,y,z coordinates
    obj.X = noise(seedX) * multiplier;
    obj.Y = 1;
    obj.Z = noise(seedZ) * multiplier;

    // set the temp object's bezier point
    obj.bezierX = noise(bezierX) * multiplier;
    obj.bezierY = 1;
    obj.bezierZ = noise(bezierZ) * multiplier;

    int paletteValue = int(random(1, paletteCount));

    obj.R = red(palette[paletteValue]);
    obj.G = green(palette[paletteValue]);
    obj.B = blue(palette[paletteValue]);
    obj.Alpha = int(random(0, 128));

    // add the temp object to the list array
    points[i] = obj;
    
  };
};
