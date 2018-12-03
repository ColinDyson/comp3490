//Created by Colin Dyson (7683407) on 11/26/2018

//exhibit 'footprints' within the gallery
final float[][][] Exhibits = {
  {
    {2, 2},
    {5, 2},
    {5, 4}, 
    {4, 4},
    {4, 3},
    {3, 3},
    {3, 4},
    {2, 4} },
  {
    {7, 2},
    {8, 2},
    {8, 3},
    {7, 3} },
  {
    {7, 4},
    {9, 4},
    {9, 7},
    {7, 7} },
  {
    {2, 5},
    {4, 5},
    {4, 7},
    {2, 7} }
};

final float[] PLAYER_SPAWN = {0, 0, 0};
final float PLAYER_HEIGHT = 1;
final float TILE_SIZE = 1;
final float[] BOUNDARY = {-10, 10, -10, 10};
final float GALLERY_SIZE = 20; //20 x 20 tiles

float[] pPos = {PLAYER_SPAWN[0], PLAYER_SPAWN[1], PLAYER_SPAWN[2]};
boolean pMoving = false;
int pFacing = 0; //0: North, 1: East, 2: South, 3: West

void setup() {
  size(640, 640, P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
  frustum(-float(width)/height, float(width)/height, 1, -1, 2, 30);
  resetMatrix();
}

void draw() {
  clear();
  background(#000000);
  
  // view
  translate(0, -PLAYER_HEIGHT, -2);
  rotateY(pFacing * PI/2);
  translate(-pPos[0], 0, -pPos[2]);
  
  drawFloor();
  drawWalls();
  drawExhibits();
}

void drawFloor() {
  for (float row = BOUNDARY[0]; row <= BOUNDARY[1]; row++) {
    for (float col = BOUNDARY[2]; col <= BOUNDARY[3]; col++) {
      drawTile(row, col);
    }
  }
}

void drawTile(float x, float z) {
  //Draw a tile centered at (x, 0, z)
  float offset = TILE_SIZE / 2;
  if ((x + z) % 2 == 0) {
    fill(#C5DB28);
  }
  else {
    fill(#8D9366);
  }
  stroke(#000000);
  strokeWeight(2);
  beginShape(QUAD);
  vertex(x - offset, 0, z - offset);
  vertex(x + offset, 0, z - offset);
  vertex(x + offset, 0, z + offset);
  vertex(x - offset, 0, z + offset);
  endShape();
}

void drawWalls() {
  stroke(#000000);
  strokeWeight(2);
  fill(#BFA07B);
  
  beginShape(QUAD);
  vertex(-10.5, 0, -10.5);
  vertex(-10.5, 0, 10.5);
  vertex(-10.5, 10, 10.5);
  vertex(-10.5, 10, -10.5);
  
  vertex(10.5, 0, -10.5);
  vertex(10.5, 0, 10.5);
  vertex(10.5, 10, 10.5);
  vertex(10.5, 10, -10.5);
  
  vertex(-10.5, 0, -10.5);
  vertex(10.5, 0, -10.5);
  vertex(10.5, 10, -10.5);
  vertex(-10.5, 10, -10.5);
  
  vertex(-10.5, 0, 10.5);
  vertex(10.5, 0, 10.5);
  vertex(10.5, 10, 10.5);
  vertex(-10.5, 10, 10.5);
  endShape();
}

void drawExhibits() {
}

boolean withinWallBounds(float x, float z) {
  return (x >= BOUNDARY[0] && x <= BOUNDARY[1] && z >= BOUNDARY[2] && z <= BOUNDARY[3]);
}

//-1: backward
//+1: forward
void move(int direction) {
  switch(pFacing) {
    case 0: //North, reverse direction
      if (withinWallBounds(pPos[0], pPos[2] - direction)) {
        pPos[2] -= direction;
      }
    break;
    case 2: //South
      if (withinWallBounds(pPos[0], pPos[2] + direction)) {
        pPos[2] += direction;
      }
    break;
    case 1: //East
      if (withinWallBounds(pPos[0] + direction, pPos[2])) {
        pPos[0] += direction;
      }
    break;
    case 3: //West, reverse direction
      if (withinWallBounds(pPos[0] - direction, pPos[2])) {
        pPos[0] -= direction;
      }
    break;
    default: break;
  }
  println("Player move to:", pPos[0], pPos[2]);
}

void turn(int direction) {
  pFacing = (pFacing + direction) % 4;
  println("Player turn to:", pFacing);
}

void keyPressed() {
  switch(key) {
    case 'w': move(1);
    break;
    case 'a' : turn(3);
    break;
    case 's' : move(-1);
    break;
    case 'd' : turn(1);
    break;
    default : break;
  }
}

void mouseClicked() {
}
