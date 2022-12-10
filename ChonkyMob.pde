class ChonkyMob extends Mob {

  ChonkyMob(float x, float y, float vx, float vy) {
    super( x, y, vx, vy);

    d=3*d;
    hp=3;
    fullBlood=hp*30;
  }

  void show() {
    plankton1.resize(d, d);
    image(plankton1, x, y);
    
    rectMode(CORNER);
    stroke(black);
    strokeWeight(2);
    fill(white);
    rect(x-d/2, y-d/3*2,fullBlood, 20);

    fill(red);
    rectMode(CORNER);
    rect(x-d/2, y-d/3*2, blood, 20);
  }
}
