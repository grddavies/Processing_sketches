class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  float radius;
  float topspeed;
  
  Mover(float r) {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    radius = abs(r);
    mass = PI*radius*radius;
    topspeed = 15;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(topspeed);
    pos.add(vel);
    acc.mult(0);
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  void checkEdges(){
    boolean bounce_y = false;
    boolean bounce_x = false;
    if (pos.y > height - radius){
      pos.y = height - radius;
      bounce_y = true;
    } else if (pos.y < radius){
      pos.y = radius;
      bounce_y = true;
    }

    if (pos.x > width - radius){
      pos.x = width - radius;
      bounce_x = true;
    } else if (pos.x < radius){
      pos.x = radius;
      bounce_x = true;
    }
    if (bounce_y) {
    vel.y *= -1;
  } if (bounce_x) {
    vel.x *= -1;
  }}

  boolean isInside(Liquid l) {
    if(pos.x > l.x && pos.x < l.x+l.w && pos.y > l.y && pos.y < l.y+l.h)
    {
      return true;
    } else {
      return false;
    }
  }

  void drag(Liquid l) {
    float speed = vel.mag();
    float dragMagnitude = l.c*speed*speed*radius;
    PVector drag = vel.copy();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    applyForce(drag);
  }

  void mouseAttract() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, pos);
    dir.normalize().mult(100000);
    applyForce(dir);
  }
}

class Liquid {
  float x, y, w, h;
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  void display() {
    noStroke();
    fill(150);
    rect(x, y, w, y);
  }
}

// MAIN
Mover[] movers = new Mover[8];
Liquid liquid;
float t = 0;
PVector wind;
PVector gravity;


void setup(){
  size(640, 640);
  liquid = new Liquid(1, height/2, width, height/2, 5);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(4, 18));
  }
}

void draw(){
  background(255);
  liquid.display();
  wind = new PVector(noise(t), noise(t + 200));
  // Iterate over Mover array
  for (int i = 0; i < movers.length; i++) {

    if (movers[i].isInside(liquid)){
      movers[i].drag(liquid);
    } else {movers[i].applyForce(wind);
    }

    if (mousePressed) {
      movers[i].mouseAttract();
    }

    float m = movers[i].mass;
    PVector gravity = new PVector(0, 0.1*m);
    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
    t++;
  }
}
