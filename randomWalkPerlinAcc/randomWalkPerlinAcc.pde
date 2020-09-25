class Mover {
  PVector pos;
  PVector vel;
  PVector acc;
  float topspeed;
  float t;
  
  Mover() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    topspeed = 8;
  }
  
  void update() {
    acc = new PVector(map(noise(t), 0, 1, -1, 1), map(noise(t+100), 0, 1, -1, 1));
    vel.add(acc);
    vel.limit(topspeed);
    pos.add(vel);
    t += 0.1;
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(pos.x, pos.y, 30, 30);
  }
  
  void checkEdges() {
    if (pos.x > width){
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height){
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height;
    }
  }
}

Mover m;

void setup(){
  size(640, 640);
  m = new Mover();
}

void draw(){
  background(255);
  m.update();
  m.checkEdges();
  m.display();
}
