int max_sides = 10;
int nsides;
float sidelength = 60;

void setup(){
  fullScreen();
  background(255); 
  fill(155);
  strokeWeight(3);
  nsides=3;
}

void draw(){
  if (mousePressed){
    nsides = int(random(3, max_sides));
  }
  polygon2(mouseX, mouseY, sidelength, nsides);
}

//void polygon(float x, float y, float radius, int npoints) {
//  float angle = TWO_PI / npoints;
//  beginShape();
//  for (float a = 0; a < TWO_PI; a += angle) {
//    float sx = x + cos(a) * radius;
//    float sy = y + sin(a) * radius;
//    vertex(sx, sy);
//  }
//  endShape(CLOSE);
//  }
  
  void polygon2(float x, float y, float sidelength, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  float sx = x;
  float sy = y;
  for (float a = 0; a < TWO_PI; a += angle) {
    vertex(sx, sy);
    sx += cos(a) * sidelength;
    sy += sin(a) * sidelength;
  }
  endShape(CLOSE);

}