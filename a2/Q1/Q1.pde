//first element of each array is the origin point of the object within it's parent
//second element is scale factor w.r.t. object's parent
final float[][] TREE =
{
  {0.6, -0.4},
  {1}
};

final float[][] LEAVES =
{
  {0, 0.7},
  {0.9},
  {-0.2, -0.4, 0.6, 0.5},
  {0, 0, 0.8, 1.2},
  {0.1, 0.2, 0.3, 0.4}
};

final float[][] TRUNK =
{
 {0, 0},
 {0.5},
 //Quads
 {0, 0},
 {0.7, 0.2},
 {0.6, 0.3},
 {0, 0.2},
 {-0.3, -1},
 {0.3, -1},
 {0.2, 0.8},
 {-0.2, 0.8},
 //CIRCLE
 {0, -0.2, 0.25, 0.4}
};

final float[][] ROOF = 
{
  {-0.3, 0.4},
  {0.6}
};

final float[][] ROOFTOP = 
{
  {0, 0},
  {1},
  //TRIANGLES
  {-1, -1},
  {1, -1},
  {0, 0.3},
  {-0.7, -0.9},
  {0.6, -0.8},
  {-0.1, -0.3},
  //QUAD
  {-0.1, -0.5},
  {0.3, -0.7},
  {0.5, -0.4},
  {0.3, -0.1}
};

final float[][] CHIMNEY = 
{
  {0.5, -0.25},
  {0.3},
  //QUADS
  {-0.4, -1},
  {0.4, -1},
  {0.4, 0.7},
  {-0.4, 0.7},
  {-0.6, 0.7},
  {0.6, 0.7},
  {0.6, 0.9},
  {-0.6, 0.9},
  {-0.5, 0.8},
  {0.5, 0.8},
  {0.5, 1},
  {-0.5, 1}
};

final float[][] FRONT_WALL = 
{
  {-0.3, -0.5},
  {0.4}
};

final float[][] BRICK = 
{
  {-1, -1},
  {0.3},
  //QUADS
  {-1, -0.5},
  {1, -0.5},
  {1, 0.5},
  {-1, 0.5},
  {-0.9, -0.1},
  {-0.1, -0.1},
  {-0.1, 0.4},
  {-0.9, 0.4},
  {0.1, -0.4},
  {0.9, -0.4},
  {0.9, 0.1},
  {0.1, 0.1}
};

final float[][] DOOR =
{
  {-0.5, -0.4},
  {0.7},
  //Quads
  {-0.5, -1},
  {0.5, -1},
  {0.5, 1}, 
  {-0.5, 1},
  {-0.4, -1},
  {0.4, -1},
  {0.4, 0.9},
  {-0.4, 0.9},
  //Circle
  {0.3, 0, 0.2, 0.2}
};

final float[][] WINDOW = 
{ 
  {0.5, -0.2},
  {0.4},
  {-1, -1},
  {1, -1},
  {1, 1}, 
  {-1, 1}
};

final float[][] WINDOWPANE =
{
  {0, 0},
  {0.45},
  {-1, -1},
  {1, -1},
  {1, 1}, 
  {-1, 1}
};

final float[][] WALLSCALES = 
{
  {4, 4},
  {6, 5},
  {4, 4}, 
  {5, 4},
  {6, 4},
  {5, 5},
  {6, 4},
  {5, 4},
  {5, 3}
  
};

final float[][] TREETRANSLATES = 
{
  {0, -0.2},
  {-0.2, 0},
  {0.1, 0.2},
  {0.2, 0.1},
  {0, 0},
  {-0.1, 0},
  {0.3, 0.1},
  {-0.2, 0.2},
  {0.25, 0.15}
};

final float[][] WINDOWTRANSLATES = 
{
  {0, 0.3},
  {0, 0.5},
  {-0.4, 0},
  {0.6, -0.5},
  {0, 0},
  {0.7, 0},
  {-0.05, 0.3},
  {0.3, -0.55},
  {0.6, 0.8}
};

final float[] ROOFSCALES = {1.25, 1.15, 1.2, 1.1, 1, 0.9, 0.8, 0.7, 0.75};
final float[] TREESCALES = {1, 1.2, 0.6, 1.1, 1, 0.7, 0.9, 1.25, 0.3};
final float[] DOORSCALES = {0.75, 0.6, 0.9, 0.8, 1, 1.2, 0.55, 1.15, 1.3};
final float[] ROOFANGLES = {5, 20, 30, 45, 0, 10, 60, -35, -45};
final float[] WINDOWANGLES = {10, -35, 60, -5, 0, -45, -20, 5, 90};
final float[] LEAFSHEARS = {30, -20, -10, 15, 0, -30, -25, 25, 20};
final float[] WALLSHEARS = {5, 10, -5, -10, 0, 15, 20, -15, -20};

final int NUM_HOUSES = 9;
final int ROWS = 3;
final int COLUMNS = 3;
final float WIDTH = 2.0f;
final float HEIGHT = 2.0f;
final float HOUSESCALE = 0.33f;

void setup() {
  size(640, 640, P3D);
  ortho(-1f, 1f, 1f, -1f);
  background(0f, 0f, 0f);
  resetMatrix();
  noLoop();
}

void draw() {
  float houseX;
  float houseY;
  int houseNumber = 0;
  
  for(int i = 0; i < ROWS; i++) {
    houseY = i * (HEIGHT / ROWS) + (HEIGHT / (2 * ROWS));
    houseY -= 1;
    for(int j = 0; j < COLUMNS; j++) {
      houseX = j * (WIDTH / COLUMNS) + (WIDTH / (2 * COLUMNS));
      houseX -= 1;

      resetMatrix();
      translate(houseX, houseY);
      scale(1f / ROWS);
      drawHouse(houseNumber);
      houseNumber++;
    }
  }
}

void drawHouse(int houseNumber) {
  //House consists of roof, tree, front wall
  noStroke();
  
  pushMatrix();
  translate(TREE[0][0], TREE[0][1]);
  scale(TREE[1][0]);
  scale(TREESCALES[houseNumber]);
  drawTree(houseNumber);
  popMatrix();
  
  pushMatrix();
  translate(FRONT_WALL[0][0], FRONT_WALL[0][1]);
  scale(FRONT_WALL[1][0]);
  drawWall(houseNumber);
  popMatrix();
  
  translate(ROOF[0][0], ROOF[0][1]);
  scale(ROOF[1][0]);
  scale(ROOFSCALES[houseNumber]);
  drawRoof(houseNumber);
}

void drawTree(int houseNumber) {
  //Tree consists of leaves and trunk
  translate(TREETRANSLATES[houseNumber][0], TREETRANSLATES[houseNumber][1]);
  pushMatrix();
  translate(TRUNK[0][0], TRUNK[0][1]);
  scale(TRUNK[1][0]);
  drawTrunk();
  popMatrix();
  
  translate(LEAVES[0][0], LEAVES[0][1]);
  scale(LEAVES[1][0]);
  drawLeaves(houseNumber);
}

void drawWall(int houseNumber) {
  //Wall consists of bricks, window, and door
  shearX(radians(WALLSHEARS[houseNumber]));
  int brickWidth = 2;
  int brickHeight = 1;
  float brickSpacing = 0.07;
  
  pushMatrix();
  translate(BRICK[0][0], BRICK[0][1]);
  scale(BRICK[1][0]);
  for(int row = 0; row < WALLSCALES[houseNumber][0]; row++) {
    for(int col = 0; col < WALLSCALES[houseNumber][1]; col++) {
      drawBrick();
      translate(brickWidth + brickSpacing, 0);
    }
    translate(-(brickWidth + brickSpacing) * WALLSCALES[houseNumber][1], brickHeight + brickSpacing);
  }
  popMatrix();
  
  pushMatrix();
  translate(DOOR[0][0], DOOR[0][1]);
  scale(DOOR[1][0]);
  drawDoor(houseNumber);
  popMatrix();
  
  translate(WINDOW[0][0], WINDOW[0][1]);
  scale(WINDOW[1][0]);
  drawWindow(houseNumber);
}

void drawRoof(int houseNumber) {
  rotate(radians(ROOFANGLES[houseNumber]));
  //Roof consists of rooftop and chimney
  pushMatrix();
  translate(CHIMNEY[0][0], CHIMNEY[0][1]);
  scale(CHIMNEY[1][0]);
  drawChimney();
  popMatrix();
  
  translate(ROOFTOP[0][0], ROOFTOP[0][1]);
  scale(ROOFTOP[1][0]);
  drawRooftop();
}

void drawTrunk() {
  beginShape(QUAD);
  fill(#482C01);
  vertex(TRUNK[2][0], TRUNK[2][1]);
  vertex(TRUNK[3][0], TRUNK[3][1]);
  vertex(TRUNK[4][0], TRUNK[4][1]);
  vertex(TRUNK[5][0], TRUNK[5][1]);
  
  fill(#9D702C);
  vertex(TRUNK[6][0], TRUNK[6][1]);
  vertex(TRUNK[7][0], TRUNK[7][1]);
  vertex(TRUNK[8][0], TRUNK[8][1]);
  vertex(TRUNK[9][0], TRUNK[9][1]);
  endShape();
  
  fill(#000000);
  ellipse(TRUNK[10][0], TRUNK[10][1], TRUNK[10][2], TRUNK[10][3]);
}

void drawLeaves(int houseNumber) {
  shearX(radians(LEAFSHEARS[houseNumber]));
  fill(#E5FF40);
  ellipse(LEAVES[2][0], LEAVES[2][1], LEAVES[2][2], LEAVES[2][3]);
  
  fill(#428B12);
  ellipse(LEAVES[3][0], LEAVES[3][1], LEAVES[3][2], LEAVES[3][3]);
  
  fill(#7ECE49);
  ellipse(LEAVES[4][0], LEAVES[4][1], LEAVES[4][2], LEAVES[4][3]);
}

void drawBrick() { 
  beginShape(QUAD);
  fill(#9B310E);
  vertex(BRICK[2][0], BRICK[2][1]);
  vertex(BRICK[3][0], BRICK[3][1]);
  vertex(BRICK[4][0], BRICK[4][1]);
  vertex(BRICK[5][0], BRICK[5][1]);
  
  fill(#EAA266);
  vertex(BRICK[6][0], BRICK[6][1]);
  vertex(BRICK[7][0], BRICK[7][1]);
  vertex(BRICK[8][0], BRICK[8][1]);
  vertex(BRICK[9][0], BRICK[9][1]);
  
  fill(#81542F);
  vertex(BRICK[10][0], BRICK[10][1]);
  vertex(BRICK[11][0], BRICK[11][1]);
  vertex(BRICK[12][0], BRICK[12][1]);
  vertex(BRICK[13][0], BRICK[13][1]);
  endShape();
}

void drawDoor(int houseNumber) {
  scale(DOORSCALES[houseNumber]);
  beginShape(QUAD);
  fill(#D60F0F);
  vertex(DOOR[2][0], DOOR[2][1]);
  vertex(DOOR[3][0], DOOR[3][1]);
  vertex(DOOR[4][0], DOOR[4][1]);
  vertex(DOOR[5][0], DOOR[5][1]);
  
  fill(#FFD436);
  vertex(DOOR[6][0], DOOR[6][1]);
  vertex(DOOR[7][0], DOOR[7][1]);
  vertex(DOOR[8][0], DOOR[8][1]);
  vertex(DOOR[9][0], DOOR[9][1]);
  endShape();
  
  fill(#28EADF);
  ellipse(DOOR[10][0], DOOR[10][1], DOOR[10][2], DOOR[10][3]);
}

void drawWindowPane(float x, float y) {
  pushMatrix();
  translate(x, y);
  scale(WINDOWPANE[1][0]);
  beginShape(QUAD);
  fill(#B9D1FF);
  vertex(WINDOWPANE[2][0], WINDOWPANE[2][1]);
  vertex(WINDOWPANE[3][0], WINDOWPANE[3][1]);
  vertex(WINDOWPANE[4][0], WINDOWPANE[4][1]);
  vertex(WINDOWPANE[5][0], WINDOWPANE[5][1]);
  endShape();
  popMatrix();
}

void drawWindow(int houseNumber) {
  translate(WINDOWTRANSLATES[houseNumber][0], WINDOWTRANSLATES[houseNumber][1]);
  rotate(radians(WINDOWANGLES[houseNumber]));
  beginShape(QUAD);
  fill(#D263F5);
  vertex(WINDOW[2][0], WINDOW[2][1]);
  vertex(WINDOW[3][0], WINDOW[3][1]);
  vertex(WINDOW[4][0], WINDOW[4][1]);
  vertex(WINDOW[5][0], WINDOW[5][1]);
  endShape();

  drawWindowPane(-0.5, -0.5);
  drawWindowPane(0.5, -0.5);
  drawWindowPane(0.5, 0.5);
  drawWindowPane(-0.5, 0.5);
}

void drawChimney() {
  beginShape(QUAD);
  fill(#B72A1E);
  vertex(CHIMNEY[2][0], CHIMNEY[2][1]);
  vertex(CHIMNEY[3][0], CHIMNEY[3][1]);
  vertex(CHIMNEY[4][0], CHIMNEY[4][1]);
  vertex(CHIMNEY[5][0], CHIMNEY[5][1]);
  
  fill(#C6C6C6);
  vertex(CHIMNEY[6][0], CHIMNEY[6][1]);
  vertex(CHIMNEY[7][0], CHIMNEY[7][1]);
  vertex(CHIMNEY[8][0], CHIMNEY[8][1]);
  vertex(CHIMNEY[9][0], CHIMNEY[9][1]);
  
  fill(#707889);
  vertex(CHIMNEY[10][0], CHIMNEY[10][1]);
  vertex(CHIMNEY[11][0], CHIMNEY[11][1]);
  vertex(CHIMNEY[12][0], CHIMNEY[12][1]);
  vertex(CHIMNEY[13][0], CHIMNEY[13][1]);
  endShape();
}

void drawRooftop() {
  beginShape(TRIANGLE);
  fill(#C9B47A);
  vertex(ROOFTOP[2][0], ROOFTOP[2][1]);
  vertex(ROOFTOP[3][0], ROOFTOP[3][1]);
  vertex(ROOFTOP[4][0], ROOFTOP[4][1]);
  
  fill(#A6D8DE);
  vertex(ROOFTOP[5][0], ROOFTOP[5][1]);
  vertex(ROOFTOP[6][0], ROOFTOP[6][1]);
  vertex(ROOFTOP[7][0], ROOFTOP[7][1]);
  endShape();
  
  beginShape(QUAD);
  fill(#FFAD31);
  vertex(ROOFTOP[8][0], ROOFTOP[8][1]);
  vertex(ROOFTOP[9][0], ROOFTOP[9][1]);
  vertex(ROOFTOP[10][0], ROOFTOP[10][1]);
  vertex(ROOFTOP[11][0], ROOFTOP[11][1]);
  endShape();
}
