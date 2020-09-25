// Max number of edges in polygon
int num_polys = 32;
// Length of polygon edges
int edge_len = 60;
// Number of points per edge for lerp
int edge_res = 3;
// mouse position
int ticker;
// list of regular polygon geoms
RegPoly[] poly_list;
// Arraylist to store the vertices drawn
ArrayList<PVector> morph = new ArrayList<PVector>();

void setup() {
  fullScreen();
  poly_list = new RegPoly[num_polys];
  for (int i = 0; i < num_polys; i++) {
    // Generate vertex coords for each poly
    poly_list[i] = new RegPoly(i+3, edge_len);
  }
  for (int i = 0; i < num_polys+3; i++) {
    // Add a PVector for max number of 
    morph.add(new PVector());
  }
}

void draw() {
  background(51);
  
  // ticker: integer rep of mouse Y pos rel to screen size
  ticker = int(map(mouseY, 0, height, num_polys-1, 0));
  
  for (int i=ticker - 1; i>-1; i--){
    //int shade = int(map(cos(PI*i/(2*num_polys)), 0, 1, 0, 255));
    poly_list[i].display(width/2, 5*height/6, 255);
  }
  
  float total_distance = 0;
  RegPoly target_poly = poly_list[ticker];
  // iterate over each Pvector in morph
  for (int i = 0; i < morph.size(); i++) {
    // get target vertex coordinates
    PVector v_target;
    v_target = target_poly.s.getVertex(i % target_poly.n);
    // Get the vertex we will draw
    PVector v_subject = morph.get(i);
    // Lerp to the target
    v_subject.lerp(v_target, 0.05);
    total_distance += PVector.dist(v_subject, v_target);
  }
  
  // Draw relative to center
  translate(width/2, 5*height/6);
  rotate(PI);
  strokeWeight(3);
  // Draw a polygon that makes up all the vertices
  beginShape();
  noFill();
  stroke(255);
  for (PVector v : morph) {
    vertex(v.x, v.y);
  }
  endShape();
  
}
