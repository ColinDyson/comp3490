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
  
  public Triangle(Vertex v0, Vertex v1, Vertex v2) {
    this.v0 = v0;
    this.v1 = v1;
    this.v2 = v2;
  }
}

final float PALETTE_HEIGHT = 0.2;
final float[] COLOURS = {#FF0000, #00FF00, #0000FF, #FFFF00, #FF00FF, #00FFFF};

void setup() {
  size(640, 640, P3D);
  ortho(-1f, 1f, 1f, -1f);
  resetMatrix();
  background(0f, 0f, 0f);
}

void draw() {
  stroke(#FFFFFF);
  drawPalette();
}

void drawPalette() {
  float colourWidth = 0.2;
  
  for (int i = 0; i < COLOURS.length; i++) {
    drawRect((i*colourWidth), -1, ((i + 1) * colourWidth), -1 + PALETTE_HEIGHT, COLOURS[i]);
  }
}


void drawRect(float x1, float y1, float x2, float y2, float colour) {
  println(x1, y1, x2, y2);
  fill(colour);
  beginShape(QUAD);
  vertex(x1, y1);
  vertex(x2, y1);
  vertex(x2, y2);
  vertex(x1, y2);
  endShape();
}
