void setup(){
  size(640, 640, P3D);
  background(0, 0, 0);
  
  ArrayList<PVector> shapeVectors;
  ArrayList<Line> shapeLines;
  PShape parentShape;
  PShape currShape = new PShape();
  int childCount;
  int vertexCount;
  float polyArea;
  
  parentShape = loadShape("simple.svg");
  childCount = parentShape.getChildCount();
  
  for(int i = 0; i < childCount; i++) {
    shapeVectors = new ArrayList<PVector>();
    shapeLines = new ArrayList<Line>();
    
    currShape = parentShape.getChild(i);
    
    vertexCount = currShape.getVertexCount();
    polyArea = surveyors(currShape);
    shapeLines = createLineList(currShape);
    
    int firstVertex = findFirstVertex(shapeLines);
    //for(int j = 0; j < vertexCount; j++) {
    //  shapeVectors.add(currShape.getVertex(i));
    //}
  }
}

int findFirstVertex(ArrayList<Line> lines) {
  int firstVertex = -1;
  int listSize = lines.size();
  
  for(int i = 0; i < listSize; i++) {
    PVector currVector = lines.get(i).end.sub(lines.get(i).start);
    PVector nextVector = lines.get((i+1) % listSize).end.sub(lines.get((i+1) % listSize).start);
    
    float angle = findAngle(currVector, nextVector);
    //println(angle);
  }
  
  return firstVertex;
}

float surveyors(PShape currShape){
  float area = 0;
  
  for (int i = 1; i < currShape.getVertexCount(); i++) {
    area += currShape.getVertex(i-1).cross(currShape.getVertex(i)).mag();
  }
  
  return area/2;
}

ArrayList<Line> createLineList(PShape currShape) {
  ArrayList<Line> shapeLines = new ArrayList<Line>();
  for (int i = 1; i < currShape.getVertexCount(); i++) {
    shapeLines.add(new Line(currShape.getVertex(i), currShape.getVertex(i-1)));
  }
  shapeLines.add(new Line(currShape.getVertex(shapeLines.size()-1), currShape.getVertex(0)));
  return shapeLines;
}

float findAngle(PVector v1, PVector v2) {
  float angle = 0;
  
  angle = asin(v1.cross(v2).mag() / v1.mag() * v2.mag());
  
  return angle;
}

class Triangle{
 PVector a;
 PVector b;
 PVector c;
 
 Triangle(PVector a, PVector b, PVector c) {
   this.a = a;
   this.b = b;
   this.c = c;
 }
}

class Line{
  PVector start;
  PVector end;
  
  Line(PVector start, PVector end){
    this.start = start;
    this.end = end;
  }
}
