class Graveyard { //<>//
  float x, y;
  int d;
  float killRate;

  Graveyard(float x, float y, int d) {
    this.x=x;
    this.y=y;
    this.d=d;
    killRate=(float)1/600;
  }

  void act() {
    for (int i=0; i<diggers.size(); i++) {
      Digger temp=diggers.get(i);
      if (dist(temp.x, temp.y, x, y)<1000) {
        temp.hp-=killRate;
      }
    }

    for (int i=0; i<mobby.size(); i++) {
      Mob temp=mobby.get(i);
      if (dist(temp.x, temp.y, x, y)<50) {
        temp.hp-=killRate;
      }
    }
  }

  void show() {
    noStroke();
    fill(white);
    circle(x, y, d);
  }
}
