public class Vector2D {
  float x;
  float y;
  
  public Vector2D(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float crossProduct(Vector2D v2) {
    return ((this.x * v2.y) - (this.y * v2.x));
  }
}

public class Vertex {
  float x;
  float y;
  
  public Vertex(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float squareDistance(Vertex v1) {
    return ((v1.x - this.x) * (v1.x - this.x)) + ((v1.y - this.y) * (v1.y - this.y));
  }
}

public class Triangle {
  Vertex v0;
  Vertex v1;
  Vertex v2;
  Vertex center;
  float translateX;
  float translateY;
  float rotate;
  float scale;
  color colour;
  
  public Triangle(Vertex v0, Vertex v1, Vertex v2, color colour) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
    this.colour = colour;
    
    float yAvg = (v0.y + v1.y + v2.y)/3;
    float xAvg = (v0.x + v1.x + v2.x)/3;
    center = new Vertex(xAvg, yAvg);
    
    translateX = 0;
    translateY = 0;
    rotate = 0;
    scale = 1;
  }
  
  public boolean contains(float x, float y) {
    //rough point in triangle test
    float boundingRadius = max(v0.squareDistance(center), v1.squareDistance(center), v2.squareDistance(center));
                            
    float dist = center.squareDistance(new Vertex(x, y));
    
    if (dist <= boundingRadius) {
      //fine point in triangle test
      Vector2D a0 = new Vector2D(x - v0.x, y - v0.y);
      Vector2D a1 = new Vector2D(x - v1.x, y - v1.y);
      Vector2D a2 = new Vector2D(x - v2.x, y - v2.y);
      Vector2D e0 = new Vector2D(v1.x - v0.x, v1.y - v0.y);
      Vector2D e1 = new Vector2D(v2.x - v1.x, v2.y - v1.y);
      Vector2D e2 = new Vector2D(v0.x - v2.x, v0.y - v2.y);
      
      //Point x, y is in triangle if all 3 cross products share the same sign
      return (((e0.crossProduct(a0) > 0) && (e1.crossProduct(a1) > 0) && (e2.crossProduct(a2) > 0)) ||
              ((e0.crossProduct(a0) < 0) && (e1.crossProduct(a1) < 0) && (e2.crossProduct(a2) < 0)));
    }
    else {
      return false;
    }
  }
}

final color[] COLOURS = {#FF0000, #00FF00, #0000FF, #FFFF00, #FF00FF, #00FFFF, #FF0088, #FF8800, #88FF00, #8800FF};
final float PALETTE_HEIGHT = 0.05;
final float PALETTE_WIDTH = 0.1;
final float HANDLE_RADIUS = 7;
final color HANDLE_FILL = #00FF88;
final color OUTLINE_COLOUR = #00FF88;
final float OUTLINE_WEIGHT = 3;
final float GRAVITY = 7;

ArrayList<Triangle> triangles;
ArrayList<Vertex> vertices;
ArrayList<Vertex> vertexBuffer;

int selectedColour = 0; //index of currently selected palette colour
int selectedTri = -1; //index of currently highlighted triangle in triangles
Vertex draggingVertex = null; //Vertex user is currently dragging
Triangle draggingTriangle = null;
boolean drawing = false; //Flag for indicating vertex buffer is not empty

void setup() {
  hint(DISABLE_OPTIMIZED_STROKE);
  size(640, 640, P3D);
  background(#000000);
  surface.setResizable(true);
  resetMatrix();
  
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
  if (selectedTri != -1) {
    drawHandles(triangles.get(selectedTri));
  }
}

void drawPreviewLine() {
  //Draws a line strip connecting the first 2 elements of our vertex buffer
  Vertex firstVertex = vertexBuffer.get(0);
  Vertex lastVertex = vertexBuffer.get(vertexBuffer.size() - 1);
  
  strokeWeight(1);
  stroke(#FFFFFF);
  line(firstVertex.x, firstVertex.y, lastVertex.x, lastVertex.y);
  line(lastVertex.x, lastVertex.y, mouseX, mouseY);
}

void drawHandles(Triangle tri) {
  fill(HANDLE_FILL);
  ellipse(tri.v0.x, tri.v0.y, HANDLE_RADIUS, HANDLE_RADIUS);
  ellipse(tri.v1.x, tri.v1.y, HANDLE_RADIUS, HANDLE_RADIUS);
  ellipse(tri.v2.x, tri.v2.y, HANDLE_RADIUS, HANDLE_RADIUS);
}

void drawTriangles() {
  Triangle currTri;

  for (int i = 0; i < triangles.size(); i++) {
    currTri = triangles.get(i);
    
    if (i == selectedTri) {
      strokeWeight(OUTLINE_WEIGHT);
      stroke(OUTLINE_COLOUR);
    }
    else {
      strokeWeight(1);
      stroke(#FFFFFF);
    }
    
    pushMatrix();
    translate(-currTri.center.x, -currTri.center.y);
    scale(currTri.scale);
    rotate(radians(currTri.rotate));
    translate(currTri.center.x, currTri.center.y);
    
    fill(currTri.colour);
    beginShape(TRIANGLE);
    vertex(currTri.v0.x, currTri.v0.y);
    vertex(currTri.v1.x, currTri.v1.y);
    vertex(currTri.v2.x, currTri.v2.y);
    endShape();
    
    popMatrix();
  }
}

void drawPalette() {
  float colourWidth = width * PALETTE_WIDTH;
  float colourHeight = height * PALETTE_HEIGHT;
  
  for (int i = 0; i < COLOURS.length; i++) {
    if (i == selectedColour) {
      strokeWeight(OUTLINE_WEIGHT);
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
  //We keep a buffer of up to 3 previous vertex locations. Once the buffer has 3 elements, we add the vertices to our vertex list, create a triangle, then empty the buffer
  //If the user clicks on something other than the canvas, the buffer is cleared. If user is within GRAVITY of an existing vertex, we snap to it and share the vertex between triangles
  //If 3 vertices are shared, we are effectvely drawing a new triangle on top of the previous, and will not be able to separate the two. This is left as is intentionally.
  Vertex newV = new Vertex(x, y);
  
  float nearestVertexDistance = width * height; //Impossible to be this far away
  //If we are within GRAVITY of an existing vertex, simply add the pre-existing vertex to the buffer
  //nearestVertexDistance ensures we simply use the closest vertex found within GRAVITY (in case multiple vertices are dragged to within GRAVITY of eachother)
  for (int i = 0; i < vertices.size(); i++) {
    float d = vertices.get(i).squareDistance(newV);
    if (d <= GRAVITY && d < nearestVertexDistance) {
      newV = vertices.get(i);
      nearestVertexDistance = d;
    }
  }
  vertexBuffer.add(newV);
  
  if (vertexBuffer.size() == 3) {
    for (int i = 0; i < vertexBuffer.size(); i++) {
      if (!vertices.contains(vertexBuffer.get(i))) {
        //Only add unique vertices to the list
        vertices.add(vertexBuffer.get(i));
      }
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

void translateTriangle(Triangle tri, float x, float y) {
  tri.v0.x += x;
  tri.v0.y += y;
  tri.v1.x += x;
  tri.v1.y += y;
  tri.v2.x += x;
  tri.v2.y += y;
}

void rotateTriangle(Triangle tri, float angle) {
}

void scaleTriangle(Triangle tri, float scale) {
}

void scaleView(float scale) {
}

void rotateView(float angle) {
}

void translateView(float x, float y) {
}

void mousePressed() {
  //on mouse down, check if we have a triangle selected. If so, check if we are in a selection vertex. If so, begin dragging
  if (selectedTri != -1) {
    Triangle currTri = triangles.get(selectedTri);
    Vertex[] handles = {currTri.v0, currTri.v1, currTri.v2};
    
    for (int i = 0; i < handles.length && draggingVertex == null; i++) {
      //Finds the squared distance from the point the mouse was pressed to the center of each handle
      float d = handles[i].squareDistance(new Vertex(mouseX, mouseY));
      if (d <= HANDLE_RADIUS * HANDLE_RADIUS) {
        draggingVertex = handles[i];
      }
    }
  }
  
  if (draggingVertex == null) {
    selectedTri = inTriangle(mouseX, mouseY);
    if (selectedTri != -1) {
      drawing = false;
      vertexBuffer.clear();
      draggingTriangle = triangles.get(selectedTri);
    }
  }
}

void mouseReleased() {
  draggingVertex = null;
  draggingTriangle = null;
}

void mouseDragged() {
  float dx = mouseX - pmouseX;
  float dy = mouseY - pmouseY;
    
  if (draggingVertex != null) {
    draggingVertex.x += dx;
    draggingVertex.y += dy;
  }
  else if (draggingTriangle != null) {
    selectedTri = triangles.indexOf(draggingTriangle);
    translateTriangle(draggingTriangle, dx, dy);
  }
}

void mouseClicked() {
   println("Click at", mouseX, mouseY);
   int hitTri = inTriangle(mouseX, mouseY);
   if (mouseY >= (height - (PALETTE_HEIGHT * height))) {
     //Click within colour palette
     selectedColour = floor(mouseX / (PALETTE_WIDTH * width));
     println("Selected Colour", selectedColour);
     selectedTri = -1;
     drawing = false;
     vertexBuffer.clear();
   }
   else if (hitTri != -1){
    //click within a triangle
    selectedTri = hitTri;
    println("Hit triangle", selectedTri);
    drawing = false;
    vertexBuffer.clear();
   }
   else {
     //click on canvas
     selectedTri = -1;
     createVertex(mouseX, mouseY);
   }
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
      case LEFT:
        if(selectedTri != -1) {
          triangles.get(selectedTri).translateX -= 10;
        }
          
      case RIGHT:
      case DOWN:
        if(selectedTri != -1) {
          triangles.get(selectedTri).rotate += 10;
        }
      default:
    }
  }
}
