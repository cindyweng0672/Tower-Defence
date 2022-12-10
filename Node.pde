class Node{
  float x, y, dx, dy;
  
  Node(float x, float y, float dx, float dy){
    this.x=x; 
    this.y=y;
    this.dx=dx;
    this.dy=dy;
  }
  
  void show(){
    fill(green);
    stroke(green);
    strokeWeight(5);
    circle(x, y, w);
    strokeWeight(5);
    line(x, y, x+dx*50, y+dy*50);
  }
}
