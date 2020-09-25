class Snake {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector mouse;
  float topspeed;
  float t;
  
  Snake() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    topspeed = 5;
  }
  
  void update() {
    mouse = new PVector(mouseX, mouseY);
    //acc = mouse.sub(pos).normalize();
    acc = new PVector(.05, sin(t));
    acc = acc.mult(1/acc.magSq());
    vel.add(acc);
    vel.x = min(topspeed, abs(vel.x));
    vel.y = min(topspeed, abs(vel.y));
    //vel.limit(topspeed);
    pos.add(vel);
    t += 2;
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


Snake[] snakes = new Snake[1];

void setup(){
  size(640, 640);
  for (int i = 0; i < snakes.length; i++) {
    snakes[i] = new Snake();
  }
}

void draw(){
  background(255);
  for (int i = 0; i <snakes.length; i++) {
    snakes[i].update();
    snakes[i].checkEdges();
    snakes[i].display();
  }
}
