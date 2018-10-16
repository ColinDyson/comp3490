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


  

final int ROWS = 3;
final int COLUMNS = 3;

void setup() {
  size(640, 640, P3D);
  background(0, 0, 0);
}

void draw() {
  Point houseOrigin = new Point(0.0f, 0.0f);
  
  for(int i = 0; i < ROWS; i++) {
    houseOrigin.y = i * (height / ROWS) + (height / (2 * ROWS));
    for(int j = 0; j < COLUMNS; j++) {
      houseOrigin.x = j * (width / COLUMNS) + (width / (2 * COLUMNS));
      
      drawHouse(houseOrigin);
      //translate to houseOrigin, then scale to be 1/3 of screen wide/tall
    }
  }
}

void drawHouse(Point houseOrigin) {
  
}
