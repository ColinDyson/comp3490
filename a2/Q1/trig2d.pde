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
    return fEqual(this.x, other.x) && fEqual(this.y, other.y);
  }
  
  public String toString() {
   return "(" + this.x + ", " + this.y + ")";
  }
}

public class Vector {
  float i;
  float j;
  Point origin;
  
  Vector(float i, float j) {
    this.i = i;
    this.j = j;
    this.origin = new Point(0.0f, 0.0f);
  }
  
  Vector(float i, float j, Point origin) {
    this.i = i;
    this.j = j;
    this.origin = origin;
  }
  
  Vector(Line line) {
    this.i = line.end.x - line.start.x;
    this.j = line.end.y - line.start.y;
    this.origin = line.start;
  }
  
  float crossProduct(Vector other) {
    return (this.i*other.j) - (this.j*other.i);
  }
  
  float dotProduct(Vector other){
    return (this.i*other.i + this.j*other.j);
  }
  
  float magnitude(){
    return sqrt(i*i + j*j);
  }
  
  void scale(float scale){
    i *= scale;
    j *= scale;
  }
  
  void normalize() {
    float magnitude = this.magnitude();
    i /= magnitude;
    j /= magnitude;
  }
  
  Vector perpendicular(){
    return new Vector(this.j, -(this.i));
  }
}

public class Line {
  Point start;
  Point end;
  
  Line(Point start, Point end) {
    this.start = start;
    this.end = end;
  }
  
  float slope() {
    //TODO: check for horizontal or vertical line
    return (this.end.y - this.start.y) / (this.end.x - this.start.x);
  }
  
  String toString(){
   return this.start.toString() + " - " + this.end.toString();
  }
}

boolean fEqual(float a, float b, float epsilon) {
  return abs(a - b) <= epsilon; 
}

boolean fEqual(float a, float b) {
  return abs(a - b) <= 0.01f;
}

//float crossProduct(float[] a, float[] b){
//  return (a[0]*b[1]) - (a[1]*b[0]);
//}

//float dotProduct(float[] a, float[] b){
//  return (a[0]*b[0] + a[1]*b[1]);
//}

//float magnitude(float x, float y){
//  return sqrt(x*x + y*y);
//}

//void scaleVector(float[] vector, float scale){
//  vector[0] *= scale;
//  vector[1] *= scale;
//}

//void normalizeVector(float[] vector) {
//  float magnitude = magnitude(vector[0], vector[1]);
//  vector[0] /= magnitude;
//  vector[1] /= magnitude;
//}

//void findPerpVector(float x, float y, float[] perpVector){
//  perpVector[0] = y;
//  perpVector[1] = -x;
//}
