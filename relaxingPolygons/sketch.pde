int max_sides = 16;
float sidelength = 155;
ArrayList<PVector> circle, square, morph;
// array lists to store target points for
// each shape
//ArrayList<ArrayList<PVector>> shapes = new ArrayList<ArrayList<PVector>>();

void setup() {
  fullScreen();
  background(255);
  circle = polygonArray(width/2, height/2, 36, 40);
  square = polygonArray(0, 0, 4, 40);
  morph = circle;
}

void draw(){
  background(255);
  beginShape();
  noFill();
  strokeWeight(4);
  for (PVector v : morph){
    vertex(v.x, v.y);
  }
  endShape(CLOSE);
}

class Polygon{
  ArrayList<PVector> vertices
  Polygon(float x, float y, int n, float l){
    ArrayList<PVector> vertices = new ArrayList<PVector>();
    float angle = TWO_PI / n;
    pushMatrix();
    translate(x, y);
    rotate(PI);
    float sx = 0 - sidelength/2;
    float sy = 0;
    for (float a = 0; a < TWO_PI; a += angle) {
      vertices.add(new PVector(sx, sy));
      sx += cos(a) * l;
      sy += sin(a) * l;
  }
  popMatrix();
  return edges;
  }

}