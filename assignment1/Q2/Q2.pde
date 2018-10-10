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

public class Point {
  float x;
  float y;
}

public class Line {
  Point start;
  Point end;
  
  float slope() {
    return (this.end.y - this.start.y) / (this.end.x - this.start.x);
  }
}

final color STRIP_COLOR = color(70, 237, 0);
final color OUTLINE_COLOR = color(255, 0, 0);

ArrayList<ArrayList<Point>> outline1 = new ArrayList<ArrayList<Point>>(STRIPS.length);
ArrayList<ArrayList<Point>> outline2 = new ArrayList<ArrayList<Point>>(STRIPS.length);

void setup(){
  size(640, 640, P3D);
  background(0, 0, 0);
  
  for(int i = 0; i < STRIPS.length; i++){
    //init a list of vertices for each shape
    initLists();
    drawLine(i);
    calcOutlines(i);
    //drawEndCaps(i);
    //findInnerAngles(i);
    if(STRIPS[i].length > 2){
      //ignore these for single-line shapes
      findIntersections(i);
    }
    drawOutlines(i);
  }
}

void initLists() {
  outline1.add(new ArrayList<Point>());
  outline2.add(new ArrayList<Point>());
}

void findIntersections(int i){
  ArrayList<Point> intersections = new ArrayList<Point>();
  Point intersection = null;
  Line currLine;
  Line checkLine;
  
  for(int j = 1; j < outline1.get(i).size(); j+=2){
    //For every line in the outline,
    currLine = new Line();
    for(int k = 1; k < outline1.get(i).size(); k+=2){
      //check if the line intersects any other line
      checkLine = new Line();
      currLine.start = outline1.get(i).get(j-1);
      currLine.end = outline1.get(i).get(j);
      checkLine.start = outline1.get(i).get(k-1);
      checkLine.end = outline1.get(i).get(k);
      
      if(k != j) {
        intersection = checkIntersection(currLine, checkLine);
      }
      if (intersection != null) {
        intersections.add(intersection);
      }
    }
  }
  
  //println("Shape ", i, " has ", intersections.size(), " intersections");
}

Point checkIntersection(Line line1, Line line2) {
  Point intersectionPoint = new Point();
  float intersectY;
  float intersectX;
  float slope1;
  float slope2;
  float intercept1;
  float intercept2;
  
  boolean line1Vert = line1.start.x == line1.end.x;
  boolean line2Vert = line2.start.x == line2.end.x;
  
  //if only one of the lines is vertical, find equation of non vertical line using the form y =m*x + b
  if(line1Vert && !line2Vert){
     slope2 = line2.slope();
     intercept2 = line2.start.y - (slope2 * line2.start.x);
     intersectY = slope2*line1.start.x + intercept2;
     intersectX = line1.start.x;
   }
   else if(line2Vert && !line1Vert){
     slope1 = line1.slope();
     intercept1 = line1.start.y - (slope1 * line1.start.x);
     intersectY = slope1*line2.start.x + intercept1;
     intersectX = line1.start.x;
   }
   else {
     //Neither is vertical nor parallel
     slope1 = line1.slope();
     intercept1 = line1.start.y - (slope1 * line1.start.x);
     slope2 = line2.slope();
     intercept2 = line2.start.y - (slope2 * line2.start.x);
     
     intersectX = -(intercept1 - intercept2) / (slope1 - slope2);
     intersectY = slope1 * intersectX + intercept1;
   }
   
   if((min(line1.start.x, line1.end.x) <= intersectX) && intersectX <= max(line1.start.x, line1.end.x) ||
      (min(line2.start.x, line2.end.x) <= intersectX) && intersectX <= max(line2.start.x, line2.end.x)){
        //If the intersection point lies within both lines, we have a valid intersection
         intersectionPoint.x = intersectX;
         intersectionPoint.y = intersectY;
   }
   else {
     intersectionPoint = null;
   }
  
  return intersectionPoint;
}

void drawEndCaps(int i) {
  float startAngle = 0f;
  float endAngle = PI;
  
  arc(STRIPS[i][0][0], STRIPS[i][0][1], WIDTHS[i], WIDTHS[i], startAngle, endAngle);
}

void drawLine(int i){
  stroke(STRIP_COLOR);
  strokeWeight(2);
  noFill();
  
  beginShape(LINE_STRIP);
  for(int j = 0; j < STRIPS[i].length; j++){
    vertex(STRIPS[i][j][0], STRIPS[i][j][1]);
  }
  endShape();
}

void calcOutlines(int i){
  float[] perpVector = {0, 0};
  Point newPoint1;
  Point newPoint2;
  float dy;
  float dx;
  
  for(int j = 1; j < STRIPS[i].length; j++){
    dx = STRIPS[i][j][0] - STRIPS[i][j-1][0];
    dy = STRIPS[i][j][1] - STRIPS[i][j-1][1];
    
    findPerpVector(dx, dy, perpVector);
    normalizeVector(perpVector);
    scaleVector(perpVector, WIDTHS[i] / 2);
    
    //For every vertex in the shape, we create 2 vertices for each of the outlines. The first and last vertex of the shape only correspond to 1 vertex on each outline.
    newPoint1 = new Point();
    newPoint2 = new Point();
    newPoint1.x = STRIPS[i][j-1][0] - perpVector[0];
    newPoint1.y = STRIPS[i][j-1][1] - perpVector[1];
    newPoint2.x = STRIPS[i][j][0] - perpVector[0];
    newPoint2.y = STRIPS[i][j][1] - perpVector[1];
    
    outline1.get(i).add(newPoint1);
    outline1.get(i).add(newPoint2);
    
    newPoint1 = new Point();
    newPoint2 = new Point();
    newPoint1.x = STRIPS[i][j-1][0] + perpVector[0];
    newPoint1.y = STRIPS[i][j-1][1] + perpVector[1];
    newPoint2.x = STRIPS[i][j][0] + perpVector[0];
    newPoint2.y = STRIPS[i][j][1] + perpVector[1];
    
    outline2.get(i).add(newPoint1);
    outline2.get(i).add(newPoint2);
  }
}

void drawOutlines(int i){
  stroke(OUTLINE_COLOR);
  strokeWeight(2);
  Point vertex1 = new Point();
  Point vertex2 = new Point();
  
  //Draw a line between every pair of vertices without overlap
  for(int j = 1; j < outline1.get(i).size(); j+=2){
    vertex1 = outline1.get(i).get(j-1);
    vertex2 = outline1.get(i).get(j);

    line(vertex1.x, vertex1.y, vertex2.x, vertex2.y);
    
    vertex1 = outline2.get(i).get(j-1);
    vertex2 = outline2.get(i).get(j);
    
    line(vertex1.x, vertex1.y, vertex2.x, vertex2.y);
  }
}

float crossProduct(float[] a, float[] b){
  return (a[0]*b[1]) - (a[1]*b[0]);
}

float dotProduct(float[] a, float[] b){
  return (a[0]*b[0] + a[1]*b[1]);
}

float magnitude(float x, float y){
  return sqrt(x*x + y*y);
}

void scaleVector(float[] vector, float scale){
  vector[0] *= scale;
  vector[1] *= scale;
}

void normalizeVector(float[] vector) {
  float magnitude = magnitude(vector[0], vector[1]);
  vector[0] /= magnitude;
  vector[1] /= magnitude;
}

void findPerpVector(float x, float y, float[] perpVector){
  perpVector[0] = y;
  perpVector[1] = -x;
}
