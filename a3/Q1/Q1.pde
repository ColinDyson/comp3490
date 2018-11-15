public class Vector {
  float x;
  float y;
  
  public Vector(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float crossProduct(Vector v2) {
    return ((this.x * v2.y) - (this.y * v2.x));
  }
  
  public float magnitude() {
    return sqrt(x*x + y*y);
  }
  
  public Vector normalized() {
    return new Vector(x/this.magnitude(), y/this.magnitude());
  }
  
  public void scale(float scale) {
    x *= scale;
    y *= scale;
  }
  
  public float dot(Vector v) {
    return (x * v.x + y * v.y);
  }
  
  public Vector add(Vector v) {
    return new Vector(x + v.x, y + v.y);
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
  
  public void addVector(Vector v) {
    x = x + v.x;
    y = y + v.y;
  }
}

public class Particle {
  Vertex position;
  Vector velocity;
  int hue;
  int lifespan;
  long birth;
  
  public Particle(Vertex position) {
    this.position = position;
    hue = int(random(0, 359));
    velocity = new Vector(random(-MAX_VELOCITY, MAX_VELOCITY), random(-MAX_VELOCITY, MAX_VELOCITY));
    birth = System.currentTimeMillis();
    lifespan = int(random(MIN_P_LIFE, MAX_P_LIFE));
  }
}

final float BOUNDS = 1;
final float P_RADIUS = 0.2;
final int P_COUNT = 10; //Typical population at any time
final int MIN_P_LIFE = 3000;
final int MAX_P_LIFE = 10000; //milliseconds
final float MAX_VELOCITY = 0.1;
final float T_STEP = 0.1;
final float BIRTH_RATE = 10; //With a population of P_COUNT, there is a 10% chance to birth a new particle

ArrayList<Particle> particles;

void setup() {
  size(640, 640, P3D);
  ortho(-1, 1, 1, -1);
  resetMatrix();
  colorMode(HSB, 360, 100, 100); //We use HSB mode to easily animate the colour of our particles
  
  particles = new ArrayList<Particle>();
  for (int i = 0; i < P_COUNT; i++) {
    addParticle();
  }
}

void draw() {
  clear();
  background(0, 0, 0);
  noStroke();
  
  resetMatrix();
  
  for (int i = 0; i < particles.size(); i++) {
    Particle currParticle = particles.get(i);
    long pAge = System.currentTimeMillis() - currParticle.birth;
    if (pAge >= currParticle.lifespan) {
      particles.remove(i);
    }
    else {
      moveParticle(currParticle);
      checkCollisions(currParticle);
      drawParticle(currParticle);
    }
  }
  birthParticles();
}

void birthParticles() {
  int populationOffset = particles.size() - P_COUNT;

  if (abs(populationOffset) <= 2) {
    //If we are between 8 and 12 particles, add a chance to spawn more
    int spawnRoll = (int)random(0, 100);
    if (spawnRoll - (populationOffset * 10) <= BIRTH_RATE) {
      addParticle();
    }
  }
}
  

void moveParticle(Particle p) {
  p.position.x += p.velocity.x * T_STEP;
  p.position.y += p.velocity.y * T_STEP;
}

void addParticle() {
  //Spawns a particle ensuring it does not overlap with an existing particle
  boolean collision = false;
  boolean spawned = false;

  while (!spawned) {
    //Generate a random coordinate
    float x = random(-BOUNDS + P_RADIUS, BOUNDS - P_RADIUS);
    float y = random(-BOUNDS + P_RADIUS, BOUNDS - P_RADIUS);
    Vertex newPosition = new Vertex(x, y);
    
    //Check if the coordinate collides with any particle
    for (int i = 0; i < particles.size(); i++) {
      if (newPosition.squareDistance(particles.get(i).position) <= 4 * P_RADIUS * P_RADIUS) {
        collision = true;
      }
    }
    
    //Once we have a coordinate that does not collide with anything, spawn a particle there
    if (!collision) {
      particles.add(new Particle(newPosition));
      spawned = true;
    }
    else {
      collision = false;
    }
  }
}

void drawParticle(Particle p) {
  pushMatrix();
  translate(p.position.x, p.position.y);
  float pAge = System.currentTimeMillis() - p.birth; //Between 0 and 10000
  pAge = pAge * 100f / (float)p.lifespan;
  fill(p.hue, 100, 100 - pAge);
  ellipse(0, 0, P_RADIUS, P_RADIUS);
  popMatrix();
}

void checkCollisions(Particle p) {
  //First, check walls
  if (abs(p.position.x) + P_RADIUS >= BOUNDS) {
    //collide with left or right side of screen
    p.velocity.x = -p.velocity.x;
  }
  if (abs(p.position.y) + P_RADIUS >= BOUNDS) {
    //colllide with top or bottom of screen
    p.velocity.y = -p.velocity.y;
  }

  //Then check for collision with other particles
  for (int i = 0; i < P_COUNT; i++) {
    Particle currParticle = particles.get(i);
    if (currParticle != p) {
      //If the square distance between the two is less than or equal to 2 * RADIUS, there is a collision
      if (sqrt(p.position.squareDistance(currParticle.position)) <= (P_RADIUS)) {
        resolveCollision(p, currParticle);
      }
    }
  }
}

void resolveCollision(Particle p0, Particle p1) {
  //Based on https://www.vobarian.com/collisions/2dcollisions2.pdf
  float normalp0, tangentp0, normalp1, tangentp1;
  Vector newNormalVector0, newNormalVector1, newTangentVector0, newTangentVector1;
  Vector normal = new Vector((p1.position.x - p0.position.x), (p1.position.y - p0.position.y));
  normal = normal.normalized();
  
  Vector tangent = new Vector(-normal.y, normal.x);
  normalp0 = normal.dot(p0.velocity);
  tangentp0 = tangent.dot(p0.velocity);
  normalp1 = normal.dot(p1.velocity);
  tangentp1 = tangent.dot(p1.velocity);
  
  newNormalVector0 = new Vector(normal.x * normalp1, normal.y * normalp1);
  newTangentVector0 = new Vector(tangent.x * tangentp0, tangent.y * tangentp0);
  newNormalVector1 = new Vector(normal.x * normalp0, normal.y * normalp0);
  newTangentVector1 = new Vector(tangent.x * tangentp1, tangent.y * tangentp1);
  
  p0.velocity = newNormalVector0.add(newTangentVector0);
  p1.velocity = newNormalVector1.add(newTangentVector1);
}
