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
      rotateZ(PI / 2 / blockHeight);
      
      translate(
        // the commented out replacement for X below is kinda neat too
        0, //mainRadius * cos(i * (360 / numBlocks)),
        0 - blockHeight / 2,
        0
      );

      box(blockWidth, blockHeight, blockWidth);

    popMatrix();

  };
  
};







// populate random coordinates
void setBlockCoordinates() {

  // set the x, y coordinates to the square of the number of blocks
  for (int i = 0; i < numBlocks; i++) {

      // create a single temp Block object
      Block obj = new Block();
  
      // set the temp object's x,y,z coordinates
      obj.X = mainRadius * cos(radians(i * (360 / numBlocks)));
      obj.Y = mainRadius * sin(radians(i * (360 / numBlocks)));
      obj.Z = 0;
      
      // variation: fan them out
      obj.YRotation = i * radians((360 / numBlocks));

      // variation: stack them diagonally
      //obj.YRotation = i * radians((360 / numBlocks)) - PI/2;

      obj.blockWidth = 0.1;
      
      // set blockHeight with Perlin noise
      //obj.blockHeight = noise(heightSeed) * 5;
      //heightSeed += 0.001;
      
      // set blockHeight on a sine wave
      obj.blockHeight = 0.5 * sin(i * 0.5) + mainRadius;
      
      int paletteValue = int(random(1, paletteCount));
  
      obj.R = red(palette[paletteValue]);
      obj.G = green(palette[paletteValue]);
      obj.B = blue(palette[paletteValue]);
      obj.Alpha = 255;
  
      // add the temp object to the list array
      blocks[int(i)] = obj;
    
  };
};
