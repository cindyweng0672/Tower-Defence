class SpeedyMob extends Mob { //<>//
  SpeedyMob(float x, float y, float vx, float vy) {
    super(x, y, vx, vy);
    hp=1;
    blood=hp*30;
    fullBlood=hp*30;
    d=d/2;
  }

  void act() {
    x+=2*vx;
    y+=2*vy;
    
    blood=hp*30;

    for (int i=0; i< nodes.size(); i++) {
      Node temp=nodes.get(i);
      if (dist(temp.x, temp.y, x, y)<4) {
        vx=temp.dx;
        vy=temp.dy;
      }
    }
    
  }
}
