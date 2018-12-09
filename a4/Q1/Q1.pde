//Created by Colin Dyson (7683407) on 11/26/2018

//exhibit 'footprints' within the gallery (used for collision boxes)
final float[][][] ExhibitBounds = {
  {
    {-8, 0, 8},
    {-6, 0, 8},
    {-6, 0, 2}, 
    {-8, 0, 2},
    {-6, 0, 8},
    {-4, 0, 8},
    {-4, 0, 4},
    {-6, 0, 4},
    {-2, 0, 8},
    {0, 0, 8},
    {0, 0, 2},
    {-2, 0, 2} },
  {
    {-8, 0, -8},
    {-4, 0, -8},
    {-4, 0, -4},
    {-8, 0, -4} },
  {
    {4, 0, -8},
    {8, 0, -8},
    {8, 0, -2},
    {4, 0, -2} },
  {
    {5, 0, 5},
    {7, 0, 5},
    {7, 0, 7},
    {5, 0, 7} }
};

float[] Ex0Sphere = {-5, 2, 7, -5, 2, 7, 1, 1, 0.01}; //origin x y z, currpos x y z, range of motion(x), direction of motion, velocity of motion
float[] Ex1Rotation = {0, 0.02}; //current angle, rate of rotation

final float[] PLAYER_SPAWN = {0, 0, 0};
final float PLAYER_HEIGHT = 1;
final float TILE_SIZE = 1;
final float[] BOUNDARY = {-10, 10, -10, 10};
final float GALLERY_SIZE = 20; //20 x 20 tiles
final float MOVE_SPEED = 0.1;
final float TURN_RATE = 0.1;

float[] pPos = {PLAYER_SPAWN[0], PLAYER_SPAWN[1] + PLAYER_HEIGHT, PLAYER_SPAWN[2]};
int pMoving = 0; //0: not moving +1: moving forward -1: moving backwards
int pTurning = 0; //0: not turning +1: turning cw -1: turning ccw
int pFacing = 0; //0: North, 1: East, 2: South, 3: West
float facingOffset = 0; //value between 0 and 1
float[] movementOffset = {0, 0, 0};
boolean godMode = false;
int Ex0Anim = 1; //direction of animation

PImage blackstone, floor, painting1, painting2, painting3, painting4, painting5, speckledgrey, wall, whitemarble, whitepaint, wood;
PShape eyeball, wolf, deer;

void setup() {
  size(800, 600, P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
  noStroke();
  frustum(-float(width)/height, float(width)/height, 1, -1, 2, 30);
  resetMatrix();
  
  textureMode(NORMAL); // you want this!
  blackstone = loadImage("assets/blackstone.jpg");
  floor = loadImage("assets/floor.jpg");
  painting1 = loadImage("assets/painting1.jpeg");
  painting2 = loadImage("assets/painting2.jpeg");
  painting3 = loadImage("assets/painting3.jpeg");
  painting4 = loadImage("assets/painting4.jpeg");
  painting5 = loadImage("assets/painting5.jpeg");
  speckledgrey = loadImage("assets/speckledgrey.jpeg");
  wall = loadImage("assets/wall.jpg");
  whitemarble = loadImage("assets/whitemarble.jpeg");
  whitepaint = loadImage("assets/whitepaint.jpeg");
  wood = loadImage("assets/wood.jpeg");
  
  //eyeball = loadShape("assets/models/eyeball/eyeball.obj");
  wolf = loadShape("assets/models/wolf.obj");
  deer = loadShape("assets/models/deer.obj");
  
  textureWrap(REPEAT);
}

void draw() {
  clear();
  background(#000000);
  
  // view
  animatePlayer();
  translate(0, -pPos[1], -2);
  rotateY((pFacing + facingOffset) * PI/2);
  translate(-pPos[0] - movementOffset[0], 0, -pPos[2] - movementOffset[2]);
  
  drawFloor();
  drawWalls();
  drawExhibits();
  pushMatrix();
  translate(5, 1, -5);
  shape(deer);
  popMatrix();
}

void drawFloor() {
  for (float row = BOUNDARY[0]; row <= BOUNDARY[1]; row++) {
    for (float col = BOUNDARY[2]; col <= BOUNDARY[3]; col++) {
      pushMatrix();
      translate(row, 0, col);
      rotateX(PI / 2);
      drawTexturedQuad(floor, 1, 1);
      popMatrix();
    }
  }
}

void drawWalls() {
  drawTexturedBox(wall, 0, 3, 0, 21, 6, 21);
}

void drawExhibits() {
  drawEx0();
  drawEx1();
  drawEx2();
  drawEx3();
}

void drawEx0() {
  drawTexturedBox(whitepaint, -7, 2, 6, 2, 4, 4);
  drawTexturedBox(wood, -3, 2, 6, 2, 4, 4);
  pushMatrix();
  Ex0Sphere[3] += Ex0Sphere[7] * Ex0Sphere[8];
  if (abs(Ex0Sphere[3] - Ex0Sphere[0]) >= Ex0Sphere[6]) {
    Ex0Sphere[7] = -Ex0Sphere[7]; //Reverse direction when we hit bounds of the range of motion
  }
  translate(Ex0Sphere[3], Ex0Sphere[4], Ex0Sphere[5]);
  fill(#F7E219);
  sphere(1);
  popMatrix();
}

void drawEx1() {
  pushMatrix();
  translate(-6, -0.5, -6);
  fill(#4B006A);
  sphere(1.5);
  popMatrix();
  
  Ex1Rotation[0] += Ex1Rotation[1] % (2 * PI);
  pushMatrix();
  translate(-6, 0, -6);
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    rotateY((i + Ex1Rotation[0]) * PI / 2);
    rotateX(PI / 4);
    translate(0, 0.5, 0);
    drawTexturedBox(whitemarble, 0, 0, 0, 0.2, 3, 0.2);
    popMatrix();
  }
  popMatrix();
}

void drawEx2() {
}

void drawEx3() {
}

void drawTexturedBox(PImage tex, float x, float y, float z, float w, float h, float d) {
  pushMatrix();
  translate(x, y, z);
  
  pushMatrix();
  translate(-(w/2), 0, 0);
  rotateY(3 * PI / 2);
  drawTexturedQuad(tex, d, h);
  popMatrix();
  
  pushMatrix();
  translate((w/2), 0, 0);
  rotateY(PI / 2);
  drawTexturedQuad(tex, d, h);
  popMatrix();
  
  pushMatrix();
  translate(0, 0, -(d/2));
  drawTexturedQuad(tex, w, h);
  popMatrix();
  
  pushMatrix();
  translate(0, 0, (d/2));
  rotateY(2 * PI / 2);
  drawTexturedQuad(tex, w, h);
  popMatrix();
  
  popMatrix();
}

void drawTexturedQuad(PImage tex, float w, float h) {
  beginShape(QUAD);
  texture(tex);
  vertex(-(w/2), -(h/2), 0, 0, 0);
  vertex((w/2), -(h/2), 0, 1, 0);
  vertex((w/2), (h/2), 0, 1, 1);
  vertex(-(w/2), (h/2), 0, 0, 1);
  endShape();
}

boolean withinWallBounds(float x, float z) {
  return (x >= BOUNDARY[0] && x <= BOUNDARY[1] && z >= BOUNDARY[2] && z <= BOUNDARY[3]);
}

void animatePlayer() {
  //Turn Animation
  if (pTurning != 0) {
    facingOffset += pTurning * TURN_RATE;
    if (abs(abs(facingOffset) - 1) <= TURN_RATE) {
      if (pTurning == -1) {
        pFacing = (pFacing + 3) % 4;
      }
      else {
        pFacing = (pFacing + 1) % 4;
      }
      facingOffset = 0;
      pTurning = 0;
    }
  }
  
  //Move Animation
  if (pMoving != 0) {
    if (pFacing % 2 == 0) { //facing north or south
      movementOffset[2] += MOVE_SPEED * pMoving;
      
      if (abs(abs(movementOffset[2]) - 1) <= MOVE_SPEED) {
        pPos[2] += pMoving;
        movementOffset[2] = 0;
        pMoving = 0;
      }
    }
    else {
      movementOffset[0] += MOVE_SPEED * pMoving;
    
      if (abs(abs(movementOffset[0]) - 1) <= MOVE_SPEED) {
        pPos[0] += pMoving;
        movementOffset[0] = 0;
        pMoving = 0;
      }
    }
  }
}

//-1: backward
//+1: forward
void move(int direction) {
  switch(pFacing) {
    case 0: //North, reverse direction
      if (withinWallBounds(pPos[0], pPos[2] - direction) || godMode) {
        pMoving = -direction;
      }
    break;
    case 2: //South
      if (withinWallBounds(pPos[0], pPos[2] + direction) || godMode) {
        pMoving = direction;
      }
    break;
    case 1: //East
      if (withinWallBounds(pPos[0] + direction, pPos[2]) || godMode) {
        pMoving = direction;
      }
    break;
    case 3: //West, reverse direction
      if (withinWallBounds(pPos[0] - direction, pPos[2]) || godMode) {
        pMoving = -direction;
      }
    break;
    default: break;
  }
}

void turn(int direction) {
  pTurning = direction;
}

void keyPressed() {
  if (pMoving == 0 && pTurning == 0) {
    switch(key) {
      case 'w': move(1);
      break;
      case 'a' : turn(-1);
      break;
      case 's' : move(-1);
      break;
      case 'd' : turn(1);
      break;
      case 'g' : godMode = !godMode;
      break;
      case 'y' : if (godMode) { pPos[1] += 1; }
      break;
      case 'h' : if (godMode) { pPos[1] -= 1; }
      break;
      default : break;
    }
  }
}

void mouseClicked() {
}
