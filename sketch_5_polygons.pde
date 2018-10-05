enum Shape {
  HOURGLASS,
  STAR,
  BOWTIE,
  TWISTED,
  MESS
};

Shape shape = Shape.HOURGLASS;

void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  ortho(-1, 1, 1, -1);
  resetMatrix();
  noLoop();
}

void draw() {
  clear();

  stroke(0.0f, 1.0f, 0.0f);
  fill(0.3f, 0.3f, 0.3f);

  beginShape(POLYGON);
  
  switch (shape) {
    case HOURGLASS:
      vertex(-.5, .8);
      vertex(-.5, .4);
      vertex(-.1, .1);
      vertex(-.1, -.1);
      vertex(-.5, -.4);
      vertex(-.5, -.8);
      vertex(0, -.75);
      vertex(.5, -.8);
      vertex(.5, -.4);
      vertex(.1, -.1);
      vertex(.1, .1);
      vertex(.5, .4);
      vertex(.5, .8);
      vertex(0, .75);
      // closing vertex is only requred to complete outline
      vertex(-.5, .8);
      break;
    
    case STAR:
      // star: https://people.sc.fsu.edu/~jburkardt/datasets/polygon/polygon.html
      vertex( 0.95105651629515353, 0.30901699437494740);
      vertex( 0.22451398828979272, 0.30901699437494740);
      vertex( 0.0, 1.0000000000000000);
      vertex(-0.22451398828979263, 0.30901699437494745);
      vertex(-0.95105651629515353, 0.30901699437494751);
      vertex(-0.36327126400268051, -0.11803398874989464);
      vertex(-0.58778525229247325, -0.80901699437494734);
      vertex( 0.0, -0.38196601125010515);
      vertex( 0.58778525229247292, -0.80901699437494756);
      vertex( 0.36327126400268039, -0.11803398874989492);
      vertex( 0.95105651629515353, 0.30901699437494740);
      break;

    case BOWTIE:
      vertex(-0.5f, 0.5f);
      vertex(-0.5f, -0.5f);
      vertex(0.5f, 0.5f);
      vertex(0.5f, -0.5f);
      vertex(-0.5f, 0.5f);
      break;

    case TWISTED:
      vertex(-0.5f, 0.5f);
      vertex(0.5f, -0.5f);
      vertex(-0.5f, -0.5f);
      vertex(0.5f, 0.5f);
      vertex(-0.5f, 0.5f);
      break;

    case MESS:
      vertex(0, 0);
      for (int i = 0; i < 100; i++) {
        vertex(random(-1,1), random(-1,1));
      }
      vertex(0, 0);
      break;
  }

  endShape();
}

void keyPressed() {
  if (' ' == key)
    shape = Shape.values()[(shape.ordinal() + 1) % Shape.values().length];
  redraw();
}
