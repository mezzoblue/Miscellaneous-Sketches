class Strand {
  
  // let's remember each Strand's coordinates
  float X;
  float Y;
  float Z;

  float bezierX;
  float bezierY;
  float bezierZ;

  
  float seedX;
  float seedY;
  float seedZ;

  float endX;
  float endY;
  float endZ;

  // and its colour
  float R;
  float G;
  float B;
  float Alpha;



  void jiggle(int i) {
    seedX += 0.005;
    endX = (noise(seedX) - 0.5) * multiplier / 20;

    seedY += 0.005;
    endY = (noise(seedY) - 0.5) * multiplier / 20;

    seedZ += 0.005;
    endZ = noise(seedZ) * multiplier / 20;
  }



  // draw each Strand to the screen
  void render(int i) {

    stroke(R, G, B, Alpha);
    noFill();

    pushMatrix();
      // rotate the view 
      // rotate(i * PI / 180);
      // move to this Strand's x,y,z coordinates
      translate(X, Y, Z);

      bezier(
        // start point
        0, 0, 0,

        // bezier handles
        0, 0, endZ,
        endX, endY, endZ,

        // end point
        endX, endY, endZ
      );

    popMatrix();

  };
  
};
