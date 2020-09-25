class Walker {
  float x, y;
  float tx, ty;

  Walker() {
    tx = 0;
    ty = 1000;
  }

  void display(){
    background(255);
    ellipse(x, y, 15, 15);
  }

  void step(){
    x = map(noise(tx), 0, 1, 0, width);
    y = map(noise(ty), 0, 1, 0, height);
    tx += 0.007;
    ty += 0.005;
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
