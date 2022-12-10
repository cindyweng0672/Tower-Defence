class Mob {
  float x, y;
  float vx, vy;
  float hp;
  int d;
  float blood;
  float fullBlood;

  Mob( float x, float y, float vx, float vy) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    d=w;
    hp=2;
    fullBlood=(int)hp*30;
  }

  void show() {
    plankton.resize(d, d);
      image(plankton, x, y);
   /* } else if (type.equals("CHONKY")) {
      image(plankton1, x, y);
      d=2*w;
     /* vx=0.5;
      vy=0.5;*/
    //} else if (type.equals("SPEEDY")) {
      //image(plankton2, x, y);
      /*vx=2;
      vy=2;*/ 
   // }

    //blood
    
    rectMode(CORNER);
    stroke(black);
    strokeWeight(2);
    fill(white);
    rect(x-d, y-d*2, fullBlood, 20);

    fill(red);
    rectMode(CORNER);
    rect(x-d, y-d*2, blood, 20);
  }

  void act() {
    x+=vx;
    y+=vy;

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
