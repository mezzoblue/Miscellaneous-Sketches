/*

 3D Line Flower, with variations
 http://exnihilo.mezzoblue.com/
 July 2009
 
*/

import processing.opengl.*;

 
float seed = 0;
float offset = 0;
int drawingSize = 300;
int ellipseX = 3;
int ellipseY = 3;

// how many 360-degree revolutions do we want?
int revolutions = 15;

// create coordinates arrays
float[] startX = new float[360 * revolutions];
float[] startY = new float[360 * revolutions];
float[] startZ = new float[360 * revolutions];
float[] endX = new float[360 * revolutions];
float[] endY = new float[360 * revolutions];
float[] endZ = new float[360 * revolutions];


void setup() {
  size(800, 500, OPENGL);
  smooth();
  frameRate(30);
  background(#888888);
  //lights();

  // populate coordinates arrays
  for (int i = 0; i < 360 * revolutions; i++) {
    
    // generate some perlin noise
    seed += 0.005;
    offset = noise(seed) * drawingSize;

    // set line starting point
    startX[i] = offset;
    startY[i] = offset;
    startZ[i] = offset;

    // set line end point
    endX[i] = offset - drawingSize / 4;
    endY[i] = offset - drawingSize / 4;
    endZ[i] = offset - drawingSize / 4;

    // check for below-zero values, correct them if found
    if (endX[i] < 0) {endX[i] = 0;};
    if (endY[i] < 0) {endY[i] = 0;};
    if (endZ[i] < 0) {endZ[i] = 0;};


// interesting variation
//    if (i == 0) {
//      endZ[0] = 1;      
//    } else {
//      endZ[i] = endZ[i - 1] + random(-1, 1) * 10;
//    }


  }

};


void draw() {
  // fill the background 
  background(#888888);
  // set line properties
  fill(255, 255, 255, 24);
  stroke(255, 255, 255, 24);
  lights();


  // move the sketch to the center of the canvas
  translate(400, 250);

  // rotate the canvas based on mouse X position
  rotateX((float) mouseY / 150);
  rotateZ((float) mouseX / 150);


  // loop through the coordinate array
  for (int i = 0; i < 360 * revolutions; i++) {
    // save coordinates, rotate the matrix, draw the shape, restore coordinates
    pushMatrix();
      rotate(i * PI / (180 * revolutions));
    
      // produces a semi-filled shape
      line(startX[i], startY[i], startZ[i], endX[i], endY[i], endZ[i]);

      // produces a semi-outlined shape
      // line(startX[i], startY[i], startZ[i], startX[i] + 1, startY[i] + 1, startZ[i] + 1);

    popMatrix();
  };




};

