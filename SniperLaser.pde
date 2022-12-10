class SniperLaser { //<>// //<>//
  float x, y;
  int range;
  float distance;
  float killRate;

  boolean shootable;
  boolean shootDigger;

  Mob target;
  Digger priorTarget;

  SniperLaser(float x, float y, int range) {
    this.x=x;
    this.y=y;
    this.range=range;
    shootable=false;
    killRate=0.02;
  }

  void act() {
    if (diggers.size()>0) {
      for (int i=0; i<diggers.size(); i++) {
        if (dist(diggers.get(i).x, diggers.get(i).y, x, y)<100) {
          priorTarget=diggers.get(i);
          shootDigger=true;
          shootable=false;
        } else {
          shootDigger=false;
        }
      }
    }

    if (mobby.size()>0 && shootDigger==false) {
      target=mobby.get(mobby.size()-1);
      distance=dist(x, y, target.x, target.y);
      if (distance<=range) {
        shootable=true;
      } else {
        shootable=false;
      }
    }

    /*if (priorTarget!=null&&dist(priorTarget.x, priorTarget.y, x, y)<100) {
     shootDigger=true;
     } else {
     shootDigger=false;
     }
     if (priorTarget==null&&target!=null) {
     distance=dist(x, y, target.x, target.y);
     if (distance<=range) {
     shootable=true;
     } else {
     shootable=false;
     }
     }*/

    if (shootDigger) {
      //priorTarget.hp-=killRate;
      priorTarget.hp-=killRate;
      if (priorTarget.hp<=0) {
        sniperBullets.remove(this);
        shootDigger=false;
      }
    }

    if (shootable) {
      target.hp-=killRate;
      if (target.hp<=0) {
        sniperBullets.remove(this);
        shootable=false; 
      }
    }
  }

  void show() {
    if (diggers.size()>0||mobby.size()>0) {
      if (shootDigger) {
        strokeWeight(5);
        stroke(blue);
        line(x, y, priorTarget.x, priorTarget.y);
      } else if (shootable) {
        strokeWeight(5);
        stroke(blue);
        line(x, y, target.x, target.y);
      }
    }
  }
}
