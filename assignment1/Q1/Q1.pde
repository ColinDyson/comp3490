final color[] PETAL_COLORS = {color(174, 54, 255), color(250, 225, 0), color(245, 138, 215), color(242, 89 ,0), color(54, 143, 255), color(165, 203, 14), color(255, 0, 77), color(245, 255, 219)};
final int[] FIBONACCI = {5, 8, 13, 21, 34, 55, 89, 144};
final float PHI = 1.618f;

void setup() {
  size(640, 640, P3D);
  ortho(-1, 1, 1, -1);
  resetMatrix();
  
  noStroke();
  background(50, 50, 50);
  
  float scaleFactor = 1.2f;
  int petalColor = 0;
  float petalAngle = 0.0f;
  
  //Swap petalColor assignment lines to change whether petal color is chosen randomly on every row or every petal
  for(int i = FIBONACCI.length - 1; i >= 0; i--){
    petalColor = pickColor(petalColor);
    for(int j = 0; j <= FIBONACCI[i]; j++){
      //petalColor = pickColor(petalColor);
      drawPetal(petalColor, scaleFactor);
      rotate(petalAngle);
      petalAngle += PI/PHI;
    }
    scaleFactor -= 0.15f;
  }
}

color pickColor(int prevColor){
  color newColor = prevColor;
  while (newColor == prevColor)
    newColor = int(random(PETAL_COLORS.length));
    
   newColor = PETAL_COLORS[newColor];

  return newColor;
}

void drawPetal(int petalColor, float scaleFactor){
  fill(petalColor);
  
  beginShape();
  vertex(0.0f*scaleFactor, 0.0f*scaleFactor);
  vertex(0.1f*scaleFactor, 0.5f*scaleFactor);
  vertex(0.05f*scaleFactor, 0.6f*scaleFactor);
  vertex(0.0f*scaleFactor, 0.8f*scaleFactor);
  vertex(-0.05f*scaleFactor, 0.6f*scaleFactor);
  vertex(-0.1f*scaleFactor, 0.5f*scaleFactor);
  endShape();
}
