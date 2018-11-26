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
  
  Point(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  Point(){
    this.x = 0;
    this.y = 0;
  }
  
  public boolean equals(Point other) {
    return abs(this.x - other.x) <= 0.01f && abs(this.y - other.y) <= 0.01f;
  }
  
  public String toString() {
   return "[" + this.x + ", " + this.y + "]";
  }
}

public class Line {
  ArrayList<Point> points;
  Point start;
  Point end;
  int verticesCount = 0;
  
  Line(Point start, Point end) {
    this.points = new ArrayList<Point>();
    this.start = start;
    this.end = end;
    points.add(start);
    points.add(end);
    this.verticesCount = 2;
  }
  
  float slope() {
    return (this.end.y - this.start.y) / (this.end.x - this.start.x);
  }
  
  String toString(){
   return this.start.toString() + " - " + this.end.toString();
  }
  
  void add(Point point) {
    if(this.points.size() > 2) {
      this.points.add(this.points.size() - 2, point);
    }
    else {
      this.points.add(this.points.size() - 1, point);
    }
    this.verticesCount++;
  }
}

final color STRIP_COLOR = color(70, 237, 0);
final color OUTLINE_COLOR = color(255, 0, 0);

void setup(){
  size(640, 640, P3D);
  background(0, 0, 0);
  
  ArrayList<ArrayList<Point>> outline = new ArrayList<ArrayList<Point>>(STRIPS.length);
  ArrayList<Point> currShape;
  ArrayList<Line> modifiedOutline;
  
  //For each shape in the set
  for(int i = 0; i < STRIPS.length; i++){
    //init a list of vertices
    currShape = new ArrayList<Point>();
    outline.add(currShape);
    
    //draw the shape
    drawLine(i);
    findOutline(i, currShape);
    drawEndCaps(i);
    modifiedOutline = findIntersections(currShape);
    //drawEndCaps(i);
    //findInnerAngles(i);
    drawOutline(modifiedOutline);
  }
}

ArrayList<Line> findIntersections(ArrayList<Point> currShape){
  ArrayList<Line> finalOutline = new ArrayList<Line>();
  Line currLine;
  Line checkLine;
  Point intersection = null;
  
  for(int j = 0; j + 1 < currShape.size(); j+=2){
    //For every line in the outline,
    currLine = new Line(currShape.get(j), currShape.get(j+1));
    finalOutline.add(currLine);
    for(int k = 0; k + 1 < currShape.size(); k+=2){
      //check if the line intersects any other line
      if(k != j) {
        checkLine = new Line(currShape.get(k), currShape.get(k+1));

        intersection = checkIntersection(currLine, checkLine);
        
        if(intersection != null) {
          //if the intersection is not somewhere the lines meet
          finalOutline.get(finalOutline.size() - 1).add(intersection);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        }
      }
    }
  }
  return finalOutline;
}

Point checkIntersection(Line line1, Line line2) {
  Point intersectionPoint = null;
  float intersectY;
  float intersectX;
  float intercept1;
  float intercept2;
  
  //println(line1, line2);
  boolean line1Vert = floatEqual(line1.start.x, line1.end.x);
  boolean line2Vert = floatEqual(line2.start.x, line2.end.x);
  
  //if only one of the lines is vertical, find equation of non vertical line using the form y =m*x + b
  if(line1Vert && !line2Vert){
     intercept2 = line2.start.y - (line2.slope() * line2.start.x);
     intersectY = line2.slope() * line1.start.x + intercept2;
     intersectX = line1.start.x;
     //println("Line 1 is vert, ", intersectX, intersectY);
   }
   else if(line2Vert && !line1Vert){
     intercept1 = line1.start.y - (line1.slope() * line1.start.x);
     intersectY = line1.slope() * line2.start.x + intercept1;
     intersectX = line2.start.x;
     //println("Line 2 is vert, ", intersectX, intersectY);
   }
   else {
     //Neither is vertical nor parallel
     intercept1 = line1.start.y - (line1.slope() * line1.start.x);
     intercept2 = line2.start.y - (line2.slope() * line2.start.x);
     
     intersectX = (intercept1 - intercept2) / (line2.slope() - line1.slope());
     intersectY = line1.slope() * intersectX + intercept1;
   }
   
   if((min(line1.start.x, line1.end.x) < intersectX) && intersectX < max(line1.start.x, line1.end.x) &&
      (min(line2.start.x, line2.end.x) < intersectX) && intersectX < max(line2.start.x, line2.end.x)){
        //If the intersection point lies within both lines, we have a valid intersection
        intersectionPoint = new Point(intersectX, intersectY);
   }
  return intersectionPoint;
}

void drawEndCaps(int i) {
  float startAngle = 0f;
  float endAngle = PI;
  stroke(OUTLINE_COLOR);
  strokeWeight(2);
  arc(STRIPS[i][0][0], STRIPS[i][0][1], WIDTHS[i], WIDTHS[i], startAngle, endAngle);
  arc(STRIPS[i][STRIPS[i].length - 1][0], STRIPS[i][STRIPS[i].length - 1][1], WIDTHS[i], WIDTHS[i], startAngle, endAngle);
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

void findOutline(int i, ArrayList<Point> currShape){
  //secondHalf will be appended to currShape to ensure vertices are in order
  ArrayList<Point> secondHalf = new ArrayList<Point>();
  float[] perpVector = {0, 0};
  float dy;
  float dx;
  
  for(int j = 1; j < STRIPS[i].length; j++){
    dx = STRIPS[i][j][0] - STRIPS[i][j-1][0];
    dy = STRIPS[i][j][1] - STRIPS[i][j-1][1];
    
    findPerpVector(dx, dy, perpVector);
    normalizeVector(perpVector);
    scaleVector(perpVector, WIDTHS[i] / 2);
    
    //For every pair of vertices in the shape, we create 4 vertices in the outline.
    currShape.add(new Point(STRIPS[i][j-1][0] - perpVector[0],
                            STRIPS[i][j-1][1] - perpVector[1]));
    currShape.add(new Point(STRIPS[i][j][0] - perpVector[0],
                            STRIPS[i][j][1] - perpVector[1]));
    //The following vertices are on the opposite side of the line, and will be appended to the main array later
    secondHalf.add(new Point(STRIPS[i][j-1][0] + perpVector[0],
                             STRIPS[i][j-1][1] + perpVector[1]));
    secondHalf.add(new Point(STRIPS[i][j][0] + perpVector[0],
                             STRIPS[i][j][1] + perpVector[1]));
  }
  //Append secondHalf to currShape in reverse order
  for(int j = secondHalf.size() - 1; j >= 0; j--) {
    currShape.add(secondHalf.get(j));
  }
}

void drawOutline(ArrayList<Line> currShape){
  stroke(OUTLINE_COLOR);
  strokeWeight(2);
  Line currLine;
  Point vertex1;
  Point vertex2;
  boolean drawing = true;
  //For each line in the shape
  for(int j = 0; j < currShape.size(); j++){
    currLine = currShape.get(j);
    //For each vertex within the line
    for(int k = 0; k + 1 < currLine.verticesCount; k++){
      if(drawing) {
        vertex1 = currLine.points.get(k);
        vertex2 = currLine.points.get(k+1);
        
        //beginShape();
        //vertex(vertex1.x, vertex1.y);
        //vertex(vertex2.x, vertex2.y);
        //endShape();
        line(vertex1.x, vertex1.y, vertex2.x, vertex2.y);
      }
      if (currLine.points.get(k+1).x != currLine.end.x &&
          currLine.points.get(k+1).y != currLine.end.y) {
        drawing = !drawing;
      }
    }
  }
}

boolean floatEqual(float a, float b) {
  return abs(a - b) <= 0.1f; 
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
