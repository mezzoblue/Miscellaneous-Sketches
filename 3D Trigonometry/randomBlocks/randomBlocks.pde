/*

 Blocks Around a Circle, Supine and Random
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
float drawingScale = 20;
float multiplier = 1000;
float mainRadius = 10;

float offsetY = 0;


Block[] points;
int numPoints = 100;



void setup() {
  smooth();
  frameRate(30);
  size(canvasWidth, canvasHeight, OPENGL);


  // Create an off-screen buffer.
  buffer = createGraphics(800, 500, JAVA2D);
  loadPalette(paletteCount);

  background(palette[0]);

  points = new Block[numPoints];
  setCoordinates();

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
  for (int i = 0; i < numPoints; i++) {
    points[i].render(i);
  };
  
};





// populate random coordinates
void setCoordinates() {

  // set the x, y coordinates to the square of the number of points
  for (int i = 0; i < numPoints; i++) {

      // create a single temp Block object
      Block obj = new Block();
  
      // set the temp object's x,y,z coordinates
      obj.X = mainRadius * cos(i * (360 / numPoints));
      obj.Y = mainRadius * sin(i * (360 / numPoints));
      obj.Z = 0;
      
      obj.YRotation = i * (360 / numPoints);

      obj.blockWidth = 0.2;
      obj.blockHeight = random(0, multiplier / 100);
      
      int paletteValue = int(random(1, paletteCount));
  
      obj.R = red(palette[paletteValue]);
      obj.G = green(palette[paletteValue]);
      obj.B = blue(palette[paletteValue]);
      obj.Alpha = 255;//int(random(0, 128));
  
      // add the temp object to the list array
      points[int(i)] = obj;
    
  };
};
