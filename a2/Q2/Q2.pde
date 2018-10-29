public class Vertex {
  float x;
  float y;
  
  public Vertex(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

public class Triangle {
  Vertex v0;
  Vertex v1;
  Vertex v2;
  color colour;
  
  public Triangle(Vertex v0, Vertex v1, Vertex v2, color colour) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
    this.colour = colour;
  }
  
  public boolean contains(float x, float y) {
    float yAvg = (v0.y + v1.y + v2.y)/3;
    float xAvg = (v0.x + v1.x + v2.x)/3;
    
    float boundingRadius = max(((v0.x - xAvg) * (v0.x - xAvg)) + ((v0.y - yAvg) * (v0.y - yAvg)),
                            ((v1.x - xAvg) * (v1.x - xAvg)) + ((v1.y - yAvg) * (v1.y - yAvg)),
                            ((v2.x - xAvg) * (v2.x - xAvg)) + ((v2.y - yAvg) * (v2.y - yAvg)));
                            
    float dist = (((x - xAvg) * (x - xAvg)) + ((y - yAvg) * (y - yAvg)));
    
    return dist <= boundingRadius;
  }
}

final color[] COLOURS = {#FF0000, #00FF00, #0000FF, #FFFF00, #FF00FF, #00FFFF, #FF0088, #FF8800, #88FF00, #8800FF};
final float PALETTE_HEIGHT = 0.05;
final float PALETTE_WIDTH = 0.1;

ArrayList<Triangle> triangles;
ArrayList<Vertex> vertices;
ArrayList<Vertex> vertexBuffer;

int selectedColour = 0;
int selectedTri = -1;
boolean drawing = false;

void setup() {
  size(640, 640, P3D);
  background(#000000);
  surface.setResizable(true);
  
  triangles = new ArrayList<Triangle>();
  vertices = new ArrayList<Vertex>();
  vertexBuffer = new ArrayList<Vertex>();
}

void draw() {
  clear();
  if (drawing) {
    drawPreviewLine();
  }
  drawPalette();
  drawTriangles();
}

void drawPreviewLine() {
  Vertex firstVertex = vertexBuffer.get(0);
  Vertex lastVertex = vertexBuffer.get(vertexBuffer.size() - 1);
  
  strokeWeight(1);
  stroke(#FFFFFF);
  line(firstVertex.x, firstVertex.y, lastVertex.x, lastVertex.y);
  line(lastVertex.x, lastVertex.y, mouseX, mouseY);
}

void drawTriangles() {
  Triangle currTri;

  for (int i = 0; i < triangles.size(); i++) {
    if (i == selectedTri) {
      strokeWeight(3);
      stroke(#00FF88);
      //Highlight Vertices
    }
    else {
      strokeWeight(1);
      stroke(#FFFFFF);
    }
    currTri = triangles.get(i);
    fill(currTri.colour);
    beginShape(TRIANGLE);
    vertex(currTri.v0.x, currTri.v0.y);
    vertex(currTri.v1.x, currTri.v1.y);
    vertex(currTri.v2.x, currTri.v2.y);
    endShape();
  }
}

void drawPalette() {
  float colourWidth = width * PALETTE_WIDTH;
  float colourHeight = height * PALETTE_HEIGHT;
  
  for (int i = 0; i < COLOURS.length; i++) {
    if (i == selectedColour) {
      strokeWeight(3);
      stroke(#FFFFFF);
    }
    else {
      strokeWeight(1);
      stroke(#000000);
    }
    drawRect(i * colourWidth, height, (i + 1) * colourWidth, height - colourHeight, COLOURS[i]);
  }
}

void drawRect(float x1, float y1, float x2, float y2, color colour) {
  fill(colour);
  beginShape(QUAD);
  vertex(x1, y1);
  vertex(x2, y1);
  vertex(x2, y2);
  vertex(x1, y2);
  endShape();
}

void createVertex(float x, float y) {
  vertexBuffer.add(new Vertex(x, y));
  
  if (vertexBuffer.size() == 3) {
    for (int i = 0; i < vertexBuffer.size(); i++) {
      vertices.add(vertexBuffer.get(i));
    }
    
    triangles.add(new Triangle(vertexBuffer.get(0), vertexBuffer.get(1), vertexBuffer.get(2), COLOURS[selectedColour]));
    
    vertexBuffer.clear();
    drawing = false;
  }
  else {
   drawing = true;
  }
}

int inTriangle(float x, float y) {
  int clickedTri = -1;
  for (int i = 0; i < triangles.size(); i++) {
    if (triangles.get(i).contains(x, y)) {
      clickedTri = i;
    }
  }
  return clickedTri;
}

void mouseClicked() {
   println("Click at", mouseX, mouseY);
   int hitTri = inTriangle(mouseX, mouseY);
   if (mouseY >= (height - (PALETTE_HEIGHT * height))) {
     selectedColour = floor(mouseX / (PALETTE_WIDTH * width));
     println("Selected Colour", selectedColour);
     selectedTri = -1;
     vertexBuffer.clear();
   }
   else if (hitTri != -1){
    selectedTri = hitTri;
    println("Hit triangle", selectedTri);
    drawing = false;
    vertexBuffer.clear();
   }
   else {
     selectedTri = -1;
     createVertex(mouseX, mouseY);
   }
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
      case LEFT:
        println("Left pressed");
        for (Vertex v : vertices) {
          v.x += 20;
        }
          
      case RIGHT:
      case DOWN:
      default:
    }
  }
}
