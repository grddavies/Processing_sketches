// A class for creation of regular polygons
class RegPoly {
  // Num_sides
  int n;
  // Shape obj
  PShape s;
  // Midpoint of bottom edge
  float x, y;
  // ArrayList of coords of vertices
  ArrayList<PVector> original;
  
  RegPoly(int n_, float l) {
    n = n_;
    float angle = TWO_PI / n;
    float sx = 0 - l/2;
    float sy = 0;

    original = new ArrayList<PVector>();
    for (float a = 0; a < TWO_PI; a += angle) {
      original.add(new PVector(sx, sy));
      sx += cos(a) * l;
      sy += sin(a) * l;
    }
    s = createShape();
    s.beginShape();
    s.noFill();
    s.strokeWeight(4);
    for (PVector v : original) {
      s.vertex(v.x, v.y);
    }
    s.endShape(CLOSE);
  }
  
  void display(float x, float y){
    pushMatrix();
    translate(x, y);
    rotate(PI);
    shape(s);
    popMatrix();
  }
  
  void segment(int n_vertices){
    // TODO: cut edges into n vertices
  }
}