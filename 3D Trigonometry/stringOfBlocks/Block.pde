class Block {
  
  // let's remember each Block's coordinates
  float X;
  float Y;
  float Z;


  float blockWidth;
  float blockHeight;

  // and its colour
  float R;
  float G;
  float B;
  float Alpha;


  // draw each Block to the screen
  void render(int i) {

    fill(R, G, B, Alpha);
    noStroke();

    pushMatrix();


      // spiral variation
//      rotate(i * PI / 30);
//      translate(X, Y, 0);

      // pipe cleaner variation
//      translate(X - (numPoints / 2), Y, 0);
//      rotateX(radians(i * 10));

      // helix variation
      translate(X - (numPoints / 2), Y, 0);
      rotateX(radians(i * 1));

      box(blockWidth, blockHeight, blockWidth);

    popMatrix();

  };
  
};
