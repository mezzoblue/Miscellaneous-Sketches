class Strand {
  
  // let's remember each Strand's coordinates
  float X;
  float Y;
  float Z;

  float bezierX;
  float bezierY;
  float bezierZ;

  
  float seedX;
  float endX;
  float seedY;
  float endY;

  // and its colour
  float R;
  float G;
  float B;
  float Alpha;



  void jiggle(int i) {
    seedX += 0.005;
    endX = noise(seedX) * multiplier / 2;

    seedY += 0.005;
    endY = noise(seedY) * multiplier / 2;

    Z += random (-0.2, 0.2);

  }



  // draw each Strand to the screen
  void render(int i) {

    stroke(R, G, B, Alpha);
    noFill();

    pushMatrix();
      // rotate the view 
      rotate(i * PI / 180);
      // move to this Strand's x,y,z coordinates
      // translate((0 - numPoints / 4) + (i / 2), 0, 0);

      bezier(
        //multiplier / 5, multiplier / 5, 0, 
        0, 0, 0,
        multiplier / 10, multiplier / 10, multiplier / 10,
        X, endY, Z,
        X, Y, Z * 2
      );

    popMatrix();

  };
  
};
