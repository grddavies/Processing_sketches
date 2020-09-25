// Max number of edges in polygon
int edge_lim = 70;
// Length of polygon edges
int edge_len = 60;
// Number of points per edge for lerp
int edge_res = 8;
// mouse position
int ticker;
// list of regular polygon geoms
RegPoly[] polyList;

void setup() {
  // max number of vertices in a shape
  //int maxPoints = edge_lim*edge_res;
  fullScreen();
  polyList = new RegPoly[edge_lim];
  for (int i = 0; i < edge_lim; i++) {
    polyList[i] = new RegPoly(i+3, edge_len);
  }
}

void draw() {
  background(255);
  ticker = int(map(mouseY, 0, height, edge_lim-1, 0));
  for (int i=0; i<ticker; i++){
    polyList[i].display(width/2, 5*height/6);
  }
}