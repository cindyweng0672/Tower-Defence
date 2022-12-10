class Tower { //<>//
  float x, y;
  int cooldown, threshold;
  boolean isBuilding;
  boolean clicked;
  String type;
  int hp;
  float blood;
  float killRate;

  Tower(String type, float x, float y, int cooldown, int threshold, boolean isBuilding) {
    this.x=x;
    this.y=y;
    this.cooldown=cooldown;
    this.threshold=threshold;
    this.isBuilding=isBuilding;
    this.type=type;
    hp=20;
    blood=hp*2.5;
    killRate=hp/20;
    //KILL DIGGERS------------------------------------------------
  }

  void show() {
    fighting.resize(50, 50);
    if (isBuilding) {
      x=mouseX;
      y=mouseY;
    }
    if (type.equals("GUN")) {
      image(fighting, x, y);
    } else if (type.equals("SNIPER")) {
      image(sniper, x, y);
    } else if (type.equals("POISON")) {
      image(poison, x, y);
    }

    noStroke();
    fill(white);
    rectMode(CORNER);
    rect(x-25, y-25, 50, 10);
    fill(purple);
    rectMode(CORNER);
    rect(x-25, y-25, blood, 10);
  }

  void act() {
    if (isBuilding) {
      towerClicked();
      if (clicked) {
        isBuilding=false;
      }
    }

    for (int i=0; i<diggers.size(); i++) {
      Digger diggerTemp=diggers.get(i);
      if (dist(x, y, diggerTemp.x, diggerTemp.y)<=100) {
        cooldown++;
        if (cooldown==threshold) {
          cooldown=0;
          if (type.equals("GUN")) {
            gunBullets.add(new GunBullet(x, y, 0, -10));
            gunBullets.add(new GunBullet(x, y, 0, 10));
            gunBullets.add(new GunBullet(x, y, 10, 0));
            gunBullets.add(new GunBullet(x, y, -10, 0));
          } else if (type.equals("SNIPER")) {
            sniperBullets.add(new SniperLaser(x, y, 100));
          } else if (type.equals("POISON")) {
            graveyard.add(new Graveyard(x, y, 100));
          }
        }
      }
    }

    if (mobby.size()>0&&mode==GAME) {
      cooldown++;
      if (cooldown==threshold) {
        cooldown=0;
        if (type.equals("GUN")) {
          gunBullets.add(new GunBullet(x, y, 0, -10));
          gunBullets.add(new GunBullet(x, y, 0, 10));
          gunBullets.add(new GunBullet(x, y, 10, 0));
          gunBullets.add(new GunBullet(x, y, -10, 0));
        } else if (type.equals("SNIPER")&& sniperBullets.size()<=1) {
          sniperBullets.add(new SniperLaser(x, y, 100));
        } else if (type.equals("POISON")) {
          graveyard.add(new Graveyard(x, y, 100));
        }
      }
    }

    for (int i=0; i<gunBullets.size(); i++) {
      GunBullet temp=gunBullets.get(i);
      if (temp.x<0||temp.y<0||temp.x>width||temp.y>height) {
        gunBullets.remove(i);
        i--;
      }
    } 
    
    for (int i=0; i<sniperBullets.size(); i++) {
      if ((mobby.size()<=0&&diggers.size()<=0)) {
        sniperBullets.remove(i);
        i--;
      }
    }
    for (int i=0; i<graveyard.size(); i++) {
      if ((mobby.size()<=0&&diggers.size()<=0) ) {
        graveyard.remove(i);
      }
    }
    
    sell();
  }

  void towerClicked() {
    if (mouseReleased&&mouseX<=650) {
      clicked=true;
    } else {
      clicked=false;
    }
  }
  
  void sell(){
    if(mode==BUILDMODE){
      if(mouseX>=x-25 && mouseX<=x+25 && mouseY<=y+25 && mouseY>=y-75){
          Button delete=myButton.get(12);
          delete.x=(int)x; 
          delete.y=(int)y-50;
          delete.act(); 
          delete.show();
          
          if(delete.clicked){
            if(type.equals("GUN")){
              money+=5;
            }else if(type.equals("SNIPER")){
              money+=5;
            }else if(type.equals("POISON")){
              money+=10;
            }
            tower.remove(this);
          }
      }
    }
  }
}
