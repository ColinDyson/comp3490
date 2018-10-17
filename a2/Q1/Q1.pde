//first element of each array is the origin point of the object within it's parent
//second element is scale factor w.r.t. object's parent
final float[][] TREE =
{
  {0.6, 0},
  {1}
};

final float[][] LEAVES =
{
  {0, 0.7},
  {0.5},
  {1, 0, 0}
};

final float[][] TRUNK =
{
 {0, 0},
 {0.5},
 {-0.3, -1},
 {0.1, -1},
 {0.1, 8},
 {-0.3, 8} 
};

final float[][] ROOF = 
{
  {-0.3, 0.5},
  {1}
};

final float[][] ROOFTOP = 
{
  {0, 0},
  {1},
  {-1, -1},
  {1, -1},
  {0, 1}
};

final float[][] CHIMNEY = 
{
  {0.5, 0},
  {0.3},
  {-0.4, -1},
  {0.4, -1},
  {0.4, 0.7},
  {-0.4, 0.7},
  {-0.6, 0.7},
  {0.6, 0.7},
  {0.6, 1},
  {-0.6, 1}
};

final float[][] FRONT_WALL = 
{
  {-0.3, 0},
  {1}
};

final float[][] BRICK = 
{
  {0, 0},
  {0.1},
  {-1, -0.5},
  {1, -0.5},
  {1, 0.5},
  {-1, 0.5}
};

final float[][] DOOR =
{
  {-0.5, -0.6},
  {0.5},
  {-0.5, -1},
  {0.5, -1},
  {0.5, 1}, 
  {-0.5, 1},
  {0.05, 0.8, 0}
};

final float[][] WINDOW = 
{ 
  {0.5, 0},
  {0.25},
  {-1, -1},
  {1, -1},
  {1, 1}, 
  {-1, 1},
  {-0.8, -0.8},
  {-0.1, -0.8},
  {-0.1, -0.1},
  {-0.8, -0.1},
  {0.1, -0.8},
  {0.8, -0.8},
  {0.1, -0.1},
  {0.8, -0.1},
  {0.1, 0.1},
  {0.8, 0.1},
  {0.8, 0.8},
  {0.1, 0.8},
  {-0.8, 0.1},
  {-0.1, 0.1},
  {-0.1, 0.8},
  {-0.8, 0.8}
};

final int NUM_HOUSES = 9;
final int ROWS = 3;
final int COLUMNS = 3;
final float WIDTH = 2.0f;
final float HEIGHT = 2.0f;

void setup() {
  size(640, 640, P3D);
  background(0, 0, 0);
  colorMode(RGB, 1.0f);
  ortho(-1, 1, 1, -1);
  resetMatrix();
  noLoop();
}

void draw() {
  Point houseOrigin = new Point(0.0f, 0.0f);
  
  for(int i = 0; i < ROWS; i++) {
    houseOrigin.y = i * (HEIGHT / ROWS) + (HEIGHT / (2 * ROWS));
    houseOrigin.y -= 1;
    for(int j = 0; j < COLUMNS; j++) {
      houseOrigin.x = j * (WIDTH / COLUMNS) + (WIDTH / (2 * COLUMNS));
      houseOrigin.x -= 1;
      println(houseOrigin);
      resetMatrix();
      translate(houseOrigin.x, houseOrigin.y);
      scale(1/NUM_HOUSES);
      drawHouse();
      //translate to houseOrigin, then scale to be 1/3 of screen wide/tall
    }
  }
}

void drawHouse() {
  //House consists of roof, tree, front wall
  pushMatrix();
  drawTree();
  popMatrix();
  
  pushMatrix();
  drawWall();
  popMatrix();
  
  translate(ROOF[0][0], ROOF[0][1]);
  scale(ROOF[1][0]);
  drawRoof();
}

void drawTree() {
  //Tree consists of leaves and trunk
  drawTrunk();
  drawLeaves();
}

void drawWall() {
  //Wall consists of bricks, window, and door
  drawBricks();
  drawDoor();
  drawWindow();
}

void drawRoof() {
  //Roof consists of rooftop and chimney
  drawChimney();
  translate(ROOFTOP[0][0], ROOFTOP[0][1]);
  scale(ROOFTOP[1][0]);
  drawRooftop();
}

void drawTrunk() {
}

void drawLeaves() {
}

void drawBricks() {
}

void drawDoor() {
}

void drawWindow() {
}

void drawChimney() {
}

void drawRooftop() {
  //beginShape(TRIANGLE);
  fill(color(0.0f, 0.0f, 1.0f));
  triangle(ROOFTOP[2][0], ROOFTOP[2][1], ROOFTOP[3][0], ROOFTOP[3][1], ROOFTOP[4][0], ROOFTOP[4][1]);
  //vertex(ROOFTOP[2][0], ROOFTOP[2][1]);
  //vertex(ROOFTOP[3][0], ROOFTOP[3][1]);
  //vertex(ROOFTOP[4][0], ROOFTOP[4][1]);
  //endShape();
}
