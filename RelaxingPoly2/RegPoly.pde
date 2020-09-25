// A class for creation of regular polygons
// edges can be segmented into more points than number of main vertices

class RegPoly {
  // Num_vertices
  int n;
  // Shape obj
  PShape s;
  int stroke_weight = 4;
  int stroke_shade = 255;
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
    s.strokeWeight(stroke_weight);
    s.stroke(stroke_shade);
    for (PVector v : original) {
      s.vertex(v.x, v.y);
    }
    s.endShape(CLOSE);
  }
  
  void display(float x, float y, color c_fill){
    pushMatrix();
    translate(x, y);
    rotate(PI);
    s.setFill(color(c_fill));
    shape(s);
    popMatrix();
  }
}
