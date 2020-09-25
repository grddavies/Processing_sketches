class Walker {
  PVector pos;
  PVector vel;
  PVector step;
  PVector mouse;

  Walker() {
    pos = new PVector(width/2, height/2);
  }

  void display(){
    stroke(0);
    point(pos.x, pos.y);
  }

  void step(){
    mouse = new PVector(mouseX, mouseY);
    float r = random(1);
    if (r < .25){
      pos.add(mouse.sub(pos).normalize()) ;
    }
    else{
      step = new PVector(random(-1, 1), random(-1, 1));
      pos.add(step);
    }
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
