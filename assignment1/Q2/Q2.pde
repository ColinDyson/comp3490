final int[][][] STRIPS = {
  {
    { 30, 30 },
    { 80, 80 }
  },
  {
    { 150, 80 },
    { 100, 30 }
  },
  {
    { 80, 150 },
    { 30, 200 }
  },
  {
    { 100, 200 },
    { 150, 150 }
  },
  {
    { 180, 320 },
    { 160, 260 },
    { 40, 450 },
    { 100, 600 },
    { 160, 450 },
    { 40, 260 },
    { 20, 320 }
  },
  {
    { 480, 20 },
    { 200, 20 },
    { 200, 200 },
    { 270, 200 },
    { 270, 40 },
    { 230, 40 },
    { 230, 150 },
    { 310, 150 },
    { 310, 100 },
    { 350, 100 },
    { 350, 40 },
    { 290, 40 },
    { 290, 130 },
    { 330, 130 },
    { 330, 80 },
    { 370, 80 },
    { 400, 80 },
    { 400, 40 },
    { 380, 40 },
    { 380, 100 },
    { 380, 170 },
    { 300, 170 },
    { 300, 200 },
    { 350, 200 },
    { 350, 140 },
    { 400, 140 },
    { 445, 140 },
    { 480, 140 },
    { 480, 200 },
    { 460, 200 },
    { 460, 40 },
    { 430, 40 },
    { 430, 190 },
    { 400, 190 },
  },
  {
    { 520, 20 },
    { 570, 50 },
    { 540, 270 },
    { 550, 360 },
    { 580, 280 },
    { 620, 360 },
    { 620, 250 },
    { 515, 70 },
    { 560, 15 },
    { 590, 15 },
    { 620, 40 },
    { 600, 70 },
    { 610, 150 }
  },

  {
    { 250, 250 }, 
    { 426, 523 }, 
    { 239, 314 }, 
    { 317, 590 }, 
    { 204, 491 }, 
    { 339, 485 }, 
    { 363, 579 }, 
    { 427, 577 }, 
    { 435, 626 }, 
    { 619, 624 }, 
    { 594, 392 }, 
    { 572, 591 }, 
    { 421, 236 }, 
    { 497, 238 }, 
    { 505, 349 }, 
    { 513, 590 }, 
    { 458, 550 }, 
    { 471, 457 }, 
    { 306, 274 }, 
    { 368, 235 }, 
    { 425, 459 }
  }
};

final int[] WIDTHS = {
  45,
  45,
  44,
  44,
  37,
  15,
  29,
  24
};

int[][][] outlines1;
int[][][] outlines2;

void setup(){
  size(640, 640, P3D);
  background(0, 0, 0);
  
  outlines1 = STRIPS.clone();
  outlines2 = STRIPS.clone();
  
  for(int i = 0; i < STRIPS.length; i++){
    drawLine(i);
    calcOutlines(i);
  }
}

void drawLine(int i){
  stroke(70, 237, 0);
  strokeWeight(2);
  noFill();
  
  beginShape(LINE_STRIP);
  for(int j = 0; j < STRIPS[i].length; j++){
    vertex(STRIPS[i][j][0], STRIPS[i][j][1]);
  }
  endShape();
}

void calcOutlines(int i){
  int halfWidth = WIDTHS[i] / 2;
  float slope;
  float perpSlope;
  float b;
  float perpB;
  float dy;
  float dx;
  
  for(int j = 1; j < STRIPS[i].length; j++){
    dx = STRIPS[i][j][0] - STRIPS[i][j-1][0];
    dy = STRIPS[i][j][1] - STRIPS[i][j-1][1];
    
    //with dx = 0, just add halfWidth to the x coord
    if(dx == 0){
      outlines1[i][j][0] -= halfWidth;
      outlines1[i][j-1][0] -= halfWidth;
      outlines2[i][j][0] += halfWidth;
      outlines2[i][j-1][0] += halfWidth;
    }
    //if dy = 0, add halfWidth to the y coord
    else if(dy == 0) {
      outlines1[i][j][1] -= halfWidth;
      outlines1[i][j-1][1] -= halfWidth;
      outlines2[i][j][1] += halfWidth;
      outlines2[i][j-1][1] += halfWidth;
    }
    //otherwise we must find the equation of the perpendicular line
    else {
      slope = dy / dx;
      perpSlope = -(1/slope);
      b = STRIPS[i][j-1][1] - slope * STRIPS[i][j-1][0];
      perpB = STRIPS[i][j -1][1] - perpSlope * STRIPS[i][j-1][0];
      
      println("Shape " + i + " vertex " + j + ": Slope = " + slope + " b = " + b);
    }
  }
}

float crossProduct(float[] a, float[] b){
    return (a[0]*b[1]) - (a[1]*b[0]);
}

float dotProduct(float[] a, float[] b){
  return (a[0]*b[0] + a[1]*b[1]);
}

float magnitude(float[] v){
  return sqrt(v[0]*v[0] + v[1]*v[1]);
}
