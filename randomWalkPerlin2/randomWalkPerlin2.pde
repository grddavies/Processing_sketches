class Walker {
  PVector pos;
  PVector vel;
  float t;
  float stepsize;

  Walker() {
    pos = new PVector(width/2, height/2);
  }

  void display(){
    background(255);
    stroke(3);
    ellipse(pos.x, pos.y, 15, 15);
  }

  void step(){
    stepsize = map(noise(t), 0, 1, 0, 10);
    vel = new PVector(map(noise(t), 0, 1, -1, 1), 
                      map(noise(t + 100), 0, 1, -1, 1));
    pos.add(vel.setMag(stepsize));
    t += .1;
  }
}

Walker w;

void setup(){
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw(){
  w.step();
  w.display();
}
