class Block {
  
  // let's remember each Block's coordinates
  float X;
  float Y;
  float Z;
  
  float XRotation;
  float YRotation;
  
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

      // move this below the rotates for an interesting double helix
      translate(X, Y, 0);

      rotateX(PI / 2);
      rotateY(YRotation);
      rotateZ(PI / 2);
      
      box(blockWidth, blockHeight, blockWidth);

    popMatrix();

  };
  
};
