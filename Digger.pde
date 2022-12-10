class Digger extends Mob { //<>//
  int n=100;
  float[] mudPosX=new float[n];
  float[] mudPosY=new float[n];
  boolean found=false;
  float killRate;
  float  tempvx;
  float  tempvy;

  Digger(float x, float y, float vx, float vy) {
    super( x, y, vx, vy);

    for (int i=0; i<n; i++) {
      mudPosX[i]=x;
    }

    for (int i=0; i<n; i++) {
      mudPosY[i]=y;
    }

    killRate=hp/20;
    tempvx=vx;
    tempvy=vy;
    fullBlood=hp*30;
    blood=fullBlood;
    
    if(hp<=0){
      diggers.remove(this);
    }
  }

  void show() {
    for (int i=0; i<n; i++) {
      image(mud, mudPosX[i], mudPosY[i]);
    }
    if (found) {
      rectMode(CORNER);
      stroke(black);
      strokeWeight(2);
      fill(white);
      rect(x-25, y-d, fullBlood, 20);

      fill(red);
      rectMode(CORNER);
      rect(x-25, y-d, blood, 20);
    }

    if (found) {
      image(plankton2, x, y);
    }
  }

  void act() {

    x+=vx;
    y+=vy;

    for (int i=0; i< nodes.size(); i++) {
      Node temp=nodes.get(i);
      if (dist(temp.x, temp.y, x, y)<4) {
        vx=temp.dx;
        vy=temp.dy;
        tempvx=temp.dx;
        tempvy=temp.dy;
      }
    }

    blood=hp*30;

    mudPosX[(n-1)]=x;
    mudPosY[(n-1)]=y;

    for (int i=0; i<(n-1); i++) {
      mudPosX[i]=mudPosX[i+1];
      mudPosY[i]=mudPosY[i+1];
    }

    if (tower.size()<=0) {
      found=false;
    }

    for (int i=0; i<tower.size(); i++) {
      Tower temp=tower.get(i);
      if (dist(temp.x, temp.y, x-25, y-25)<=100) {
        vx=0;
        vy=0;
        temp.blood-=killRate;
        found=true;
      } else {
        found=false;
      }
    }

    if (!found) {
      vx=tempvx;
      vy=tempvy;
    }
  }
}
