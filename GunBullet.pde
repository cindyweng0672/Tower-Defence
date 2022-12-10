class GunBullet {
  float x, y, vx, vy, d;
  float towerX, towerY;
  boolean shootDigger;

  GunBullet(float x, float y, float vx, float vy) {
    this.x=x;
    this.y=y;
    this.vx=vx;
    this.vy=vy;
    
    towerX=x; 
    towerY=y;
  }

  void show() {
    stroke(black);
    strokeWeight(3);
    if(shootDigger){
      fill(green);
    }else{
      fill(blue);
  }
    circle(x, y, 15);
    d=15;
  }

  void act() {
    x+=vx;
    y+=vy;

    for (int i=0; i<mobby.size(); i++) {
      Mob temp=mobby.get(i);
      if (dist(temp.x, temp.y, x, y)<=d+temp.d/2) {
        gunBullets.remove(this);
        temp.hp-=1;
      }
    }
    
    for (int i=0; i<diggers.size(); i++) {
      Mob temp=diggers.get(i);
      if (dist(temp.x, temp.y, x, y)<= d+temp.d/2 && dist(temp.x, temp.y, towerX, towerY)<=100) { //<>//
        gunBullets.remove(this);
        temp.hp-=0.5;
      }else{
        shootDigger=false;
      }
    }
  }
}
