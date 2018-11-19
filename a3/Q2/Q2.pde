float BASE [][] = {
  {0, 0, 0},
  {0, 0, 0},
  {-1, -0.5, 0.5},
  {1, -0.5, 0.5},
  {1, 0.5, 0.5},
  {-1, 0.5, 0.5},
  {-1, -0.5, -0.5},
  {1, -0.5, -0.5},
  {1, 0.5, -0.5},
  {-1, 0.5, -0.5}
};

float ARM [][] = {
  {0, -0.75, 0},
  {0, 0, 0},
  {-4, -0.25, 0.25},
  {4, -0.25, 0.25},
  {4, 0.25, 0.25},
  {-4, 0.25, 0.25},
  {-4, -0.25, -0.25},
  {4, -0.25, -0.25},
  {4, 0.25, -0.25},
  {-4, 0.25, -0.25}
};

float ELBOW [][] = {
  {4, -0.75, 0},
  {0, 0, 0},
  {-0.5, -0.5, 0.5},
  {0.5, -0.5, 0.5},
  {0.5, 0.5, 0.5},
  {-0.5, 0.5, 0.5},
  {-0.5, -0.5, -0.5},
  {0.5, -0.5, -0.5},
  {0.5, 0.5, -0.5},
  {-0.5, 0.5, -0.5},
};

float WRIST [][] = {
  {0, -1, 0},
  {0, 0, 0},
  {-0.5, -0.5, 0.5},
  {0.5, -0.5, 0.5},
  {0.5, 0.5, 0.5},
  {-0.5, 0.5, 0.5},
  {-0.5, -0.5, -0.5},
  {0.5, -0.5, -0.5},
  {0.5, 0.5, -0.5},
  {-0.5, 0.5, -0.5},
};

float CLAW_PIECE_1 [][] = {
  {0.2, -0.3, 0},
  {0, 0, 20},
  {-0.1, -1, 0.1},
  {0.1, -1, 0.1},
  {0.1, 0, 0.1},
  {-0.1, 0, 0.1},
  {-0.1, -1, -0.1},
  {0.1, -1, -0.1},
  {0.1, 0, -0.1},
  {-0.1, 0, -0.1}
};

float CLAW_PIECE_2 [] = {-1, 0.2};

float CLAW_PIECE_3 [][] = {
  {0, 0, 0},
  {0, 0, -45},
  {-0.1, -0.8, 0.1},
  {0.1, -0.8, 0.1},
  {0.1, 0, 0.1},
  {-0.1, 0, 0.1},
  {-0.1, -0.8, -0.1},
  {0.1, -0.8, -0.1},
  {0.1, 0, -0.1},
  {-0.1, 0, -0.1}
};
  
//Limits for various transforms to keep the machine physically stable
final float[] CLAW_PIECE_1_LIMITS = {20, 50};
final float[] CLAW_PIECE_2_LIMITS = {-45, -10};
final float[] WRIST_HEIGHT_LIMITS = {-5, -1};
final float[] ELBOW_TRANSLATE_LIMITS = {-4, 4};

final float SLIDE_SPEED = 2;
final float ROTATE_SPEED = 0.8;
final float CLAW_SPEED = 1.5;
final float GRASP_SPEED = 0.4;
final float T_STEP = 0.02;

boolean perspective = true;
boolean inSequence = true;
int sliding = 0;
int rotatingArm = 0;
int rotatingClaw = 0;
int openingClaw = 0;
int movingClaw = 0;
int view = 0;
float t = 0;

void setup() {
  size(640, 640, P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
  surface.setResizable(true);
}

void draw() {
  clear();
  resetMatrix();
  background(#2B2552);
  if (perspective) {
    frustum(-1, 1, 1, -1, 1, 20);
  }
  else {
    ortho(-10, 10, 10, -10, 1, 20);
  }
  camera(0, 0, 10, 0, 0, 0, 0, 1, 0);
  
  drawMachine();
  
  t %= t + T_STEP;
}

void drawMachine() {
  drawPortion(BASE, #000000);
  
  rotateArm();
  drawPortion(ARM, #555555);
  translateElbow();
  drawPortion(ELBOW, #00B74A);
  
  animateClaw();
  drawPortion(WRIST, #C613D3);
  drawString();
  
  pushMatrix();
  drawPortion(CLAW_PIECE_1, #AFAFAF);
  drawSphere(CLAW_PIECE_2);
  drawPortion(CLAW_PIECE_3, #AFAFAF);
  popMatrix();
  
  rotateY(radians(180));
  drawPortion(CLAW_PIECE_1, #AFAFAF);
  drawSphere(CLAW_PIECE_2);
  drawPortion(CLAW_PIECE_3, #AFAFAF);
}

void rotateArm() {
  ARM[1][1] += rotatingArm * ROTATE_SPEED;
}

void translateElbow() {
  if (ELBOW[0][0] + sliding * SLIDE_SPEED * T_STEP < ELBOW_TRANSLATE_LIMITS[0] ||
      ELBOW[0][0] + sliding * SLIDE_SPEED * T_STEP > ELBOW_TRANSLATE_LIMITS[1]) {
        sliding = 0;
  }
  else {
    ELBOW[0][0] += sliding * SLIDE_SPEED * T_STEP;
  }
}

void animateClaw() {
  if (WRIST[0][1] + movingClaw * CLAW_SPEED * T_STEP < WRIST_HEIGHT_LIMITS[0] ||
      WRIST[0][1] + movingClaw * CLAW_SPEED * T_STEP > WRIST_HEIGHT_LIMITS[1]) {
        movingClaw = 0;
  }
  else {
    WRIST[0][1] += movingClaw * CLAW_SPEED * T_STEP;
  }
}

void drawString() {
  stroke(#FFE308);
  strokeWeight(2);
  beginShape(LINES);
  vertex(0, 0, 0);
  vertex(0, -WRIST[0][1], 0);
  endShape(); 
}

void drawSphere(float[] s) {
  noStroke();
  fill(#AFAFAF);
  translate(0, s[0], 0);
  sphere(s[1]);
}

void drawPortion(float[][] shape, color c) {
  translate(shape[0][0], shape[0][1], shape[0][2]);
  rotateZ(radians(shape[1][2]));
  rotateX(radians(shape[1][0]));
  rotateY(radians(shape[1][1]));
  drawCube(shape, c);
}

void drawCube(float[][] v, color c) {
  resetStroke();
  fill(c);
  
  beginShape(QUAD);
  vertex(v[2][0], v[2][1], v[2][2]);
  vertex(v[3][0], v[3][1], v[3][2]);
  vertex(v[4][0], v[4][1], v[4][2]);
  vertex(v[5][0], v[5][1], v[5][2]);
  
  vertex(v[3][0], v[3][1], v[3][2]);
  vertex(v[7][0], v[7][1], v[7][2]);
  vertex(v[8][0], v[8][1], v[8][2]);
  vertex(v[4][0], v[4][1], v[4][2]);
  
  vertex(v[7][0], v[7][1], v[7][2]);
  vertex(v[6][0], v[6][1], v[6][2]);
  vertex(v[9][0], v[9][1], v[9][2]);
  vertex(v[8][0], v[8][1], v[8][2]);
  
  vertex(v[6][0], v[6][1], v[6][2]);
  vertex(v[2][0], v[2][1], v[2][2]);
  vertex(v[5][0], v[5][1], v[5][2]);
  vertex(v[9][0], v[9][1], v[9][2]);
  
  vertex(v[5][0], v[5][1], v[5][2]);
  vertex(v[4][0], v[4][1], v[4][2]);
  vertex(v[8][0], v[8][1], v[8][2]);
  vertex(v[9][0], v[9][1], v[9][2]);
  
  vertex(v[6][0], v[6][1], v[6][2]);
  vertex(v[7][0], v[7][1], v[7][2]);
  vertex(v[3][0], v[3][1], v[3][2]);
  vertex(v[2][0], v[2][1], v[2][2]);
  endShape();
}

void resetStroke() {
  strokeWeight(1);
  stroke(#FFFFFF);
}

void haltAnimations() {
  sliding = 0;
  rotatingArm = 0;
  rotatingClaw = 0;
  openingClaw = 0;
  movingClaw = 0;
}

void keyPressed() {
  switch(key) {
    case 'e':
      if (sliding != -1) sliding = -1;
      else sliding = 0;
      break;
    case 'r':
      if (sliding != 1) sliding = 1;
      else sliding = 0;
      break;
    case 'a':
      if (movingClaw != 1) movingClaw = 1;
      else movingClaw = 0;
      break;
    case 'z':
      if (movingClaw != -1) movingClaw = -1;
      else movingClaw = 0;
      break;
    case 'q':
      if (rotatingArm != 1) rotatingArm = 1;
      else rotatingArm = 0;
      break;
    case 'w':
      if (rotatingArm != -1) rotatingArm = -1;
      else rotatingArm = 0;
      break;
    case 'd':
      if (rotatingClaw != 1) rotatingClaw = 1;
      else rotatingClaw = 0;
      break;
    case 's':
      if (rotatingClaw != -1) rotatingClaw = -1;
      else rotatingClaw = 0;
      break;
    case 'x':
      if (openingClaw != 1) openingClaw = 1;
      else openingClaw = 0;
      break;
    case 'c':
      if (openingClaw != -1) openingClaw = -1;
      else openingClaw = 0;
      break;
    case 'o':
      perspective = false;
      break;
    case 'p':
      perspective = true;
      break;
    case '1':
      view = 0;
      break;
    case '2':
      view = 1;
      break;
    case '3':
      view = 2;
      break;
    case ' ':
      haltAnimations();
      inSequence = true;
      break;
    default: break;
  }
}
