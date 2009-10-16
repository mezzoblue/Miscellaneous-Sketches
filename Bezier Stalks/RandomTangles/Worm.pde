class Worm {
  
  float startX[] = new float[wormPoints];
  float startY[] = new float[wormPoints];
  float startZ[] = new float[wormPoints];
  float endX[] = new float[wormPoints];
  float endY[] = new float[wormPoints];
  float endZ[] = new float[wormPoints];

  float bezierStartX[] = new float[wormPoints];
  float bezierStartY[] = new float[wormPoints];
  float bezierStartZ[] = new float[wormPoints];
  float bezierEndX[] = new float[wormPoints];
  float bezierEndY[] = new float[wormPoints];
  float bezierEndZ[] = new float[wormPoints];
  
  float R;
  float G;
  float B;
  float Alpha;


  // draw each Worm to the screen
  void render() {
    for (int i = 0; i < wormPoints; i++) {
      strokeWeight(0.2);
      stroke(R, G, B, Alpha);
      noFill();
  
      bezier(
        // start point
        startX[i], startY[i], startZ[i],
  
        // bezier handles
        bezierStartX[i], bezierStartY[i], bezierStartZ[i],
        bezierEndX[i], bezierEndY[i], bezierEndZ[i],
  
        // end point
        endX[i], endY[i], endZ[i]
      );    
    };
  };
  
};



// update coordinates to set a path from the previous end point
void wiggle(int me) {

  Worm obj = new Worm();

  for (int i = 0; i < wormPoints; i++) {
    if (i > 0) {
      obj.startX[i] = obj.endX[i - 1];
      obj.startY[i] = obj.endY[i - 1];
      obj.startZ[i] = obj.endZ[i - 1];
    } else {
      obj.startX[i] = 0;
      obj.startY[i] = 0;
      obj.startZ[i] = 0;
    };
    
    obj.endX[i] = obj.startX[i] + random(-5, 5);
    obj.endY[i] = obj.startY[i] + random(-5, 5);
    obj.endZ[i] = obj.startZ[i] + random(-5, 5);
    
    obj.bezierStartX[i] = obj.startX[i] + (random(0 - movementDegree, movementDegree) / 5);
    obj.bezierStartY[i] = obj.startY[i] + (random(0 - movementDegree, movementDegree) / 5);
    obj.bezierStartZ[i] = obj.startZ[i] + (random(0 - movementDegree, movementDegree) / 5);
    obj.bezierEndX[i] = obj.endX[i] + (random(0 - movementDegree, movementDegree) / 5);
    obj.bezierEndY[i] = obj.endY[i] + (random(0 - movementDegree, movementDegree) / 5);
    obj.bezierEndZ[i] = obj.endZ[i] + (random(0 - movementDegree, movementDegree) / 5);

    int paletteValue = int(random(1, paletteCount));

    obj.R = red(palette[paletteValue]);
    obj.G = green(palette[paletteValue]);
    obj.B = blue(palette[paletteValue]);
    obj.Alpha = int(random(0, 128));

  };

  worms[me] = obj;
};





