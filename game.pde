void game() {

  diggerCount--;
   
   if (diggerCount==0) {
   diggers.add(new Digger(-200, height/8, 1, 0));
   diggerCount=1200;
   }

  background(beige);

  textFont(pixelFont);

  noStroke();
  rectMode(CORNER);
  w=pathway(30);
  toolbar(150);
  nextWave();
  buildButton();

  fill(black);
  textSize(20);
  text(mouseX+","+mouseY, mouseX, mouseY);

  for (int i=0; i<nodes.size(); i++) {
    nodes.get(i).show();
  }

  animateBullets();
  animateMobs();
  animateTowers();

  for (int i=0; i<tower.size(); i++) {
    Tower temp=tower.get(i);
    if (temp.blood<=0) {
      tower.remove(i);
      i--;
    }
  }

  for (int i=0; i<graveyard.size(); i++) {
    boolean towerExist=false;
    Graveyard gy=graveyard.get(i);
    for (int j=0; j<tower.size(); j++) {
      Tower temp=tower.get(j);
      if (dist(gy.x, gy.y, temp.x, temp.y)<50) {
        towerExist=true;
        break;
      } else {
        towerExist=false;
      }
    }

    if (!towerExist) {
      graveyard.remove(i);
    }
  }

  for (int i=0; i<sniperBullets.size(); i++) {
    boolean towerExist=false;
    SniperLaser gy=sniperBullets.get(i);
    for (int j=0; j<tower.size(); j++) {
      Tower temp=tower.get(j);
      if (dist(gy.x, gy.y, temp.x, temp.y)<50) {
        towerExist=true;
        break;
      } else {
        towerExist=false;
      }
    }

    if (!towerExist) {
      sniperBullets.remove(i);
    }
  }
}

int pathway(int w) {
  GifButton pineappleHouse;

  if (map==1) {
    fill(red);
    strokeWeight(w);
    stroke(red);

    line(-100, height/8, 300, height/8);
    line(300, height/8, 300, height/8+200);
    line(300, height/8+200, 600, height/8+200);
    line(600, height/8+200, 600, height/8+500);
    line(600, height/8+500, 100, height/8+500);
    line(100, height/8+300, 100, height/8+500);
    line(100, height/8+300, 400, height/8+300);
    line(400, height/8+300, 400, height/8+600);
    pineappleHouse=gif.get(1);
  } else {
    fill(blue);
    strokeWeight(w);
    stroke(blue);

    line(-100, 100, 100, 100);
    line(100, 100, 100, 650);
    line(100, 650, 200, 650);
    line(200, 650, 200, 100);
    line(200, 100, 550, 100);
    line(550, 100, 550, 200);
    line(550, 200, 300, 200);
    line(300, 200, 300, 500);
    line(300, 500, 550, 500);
    line(550, 500, 300, 750);
    pineappleHouse=gif.get(2);
  }

  makeNodes();

  pineappleHouse.act();

  for (int i=0; i<mobby.size(); i++) {
    Mob temp=mobby.get(i);
    if (temp.y>pineappleHouse.y-pineappleHouse.h/2) {
      lives--;
      mobby.remove(i);
    }
  }

  if (lives<=0) {
    mode=GAMEOVER;
  }

  return w;
}

void toolbar(int w) {
  rectMode(CORNER);
  noStroke();
  fill(orange);
  rect(800-w, 0, w, 800);

  fill(black); 
  text("Lives: "+lives, 720, 70);
}

void nextWave() {
  Button regularButton=myButton.get(1);
  Button chonkyButton=myButton.get(2);
  Button speedyButton=myButton.get(3);

  regularButton.act();
  regularButton.show();
  chonkyButton.act();
  chonkyButton.show();
  speedyButton.act();
  speedyButton.show();

  fill(red);
  text("wave number:", regularButton.x, regularButton.y+200);
  text(waveNum, regularButton.x, regularButton.y+250);

  if (mouseReleased&&regularButton.clicked&&mobby.size()<=0) {
    waveNum++;
    for (int i=waveNum; i>0; i--) {
      mobby.add(new Mob(-50-i*100, height/8, 1, 0));
      //diggers.add(new Digger(-10, height/8, 1, 0));
    }
  }

  if (mouseReleased&&chonkyButton.clicked&&mobby.size()<=0) {
    waveNum++;
    for (int i=waveNum; i>0; i--) {
      mobby.add(new ChonkyMob(-50-i*100, height/8, 1, 0));
    }
  }

  if (mouseReleased&&speedyButton.clicked&&mobby.size()<=0) {
    waveNum++;
    for (int i=waveNum; i>0; i--) {
      mobby.add(new SpeedyMob(-50-i*100, height/8, 1, 0));
    }
  }
}

void buildButton() {
  textSize(30);

  image(moneyPic, 700, 550);
  text("money: "+money, 725, 600);

  Button buildButton=myButton.get(4);
  buildButton.act();
  buildButton.show();

  if (buildButton.clicked) {
    mode=BUILDMODE;
  }
}

void animateMobs() {
  for (int i=0; i<mobby.size(); i++) {
    Mob temp=mobby.get(i);
    temp.act();
    temp.show();

    if (temp.hp<=0) {
      mobby.remove(i);
      money+=5;
      i--;
    }

    if (temp.y>gif.get(1).y) {
      mobby.remove(i);
      i--;
    }
  }

  for (int i=0; i<diggers.size(); i++) {
    Digger temp=diggers.get(i);
    temp.act();
    temp.show();

    if (temp.hp<=0) {
      diggers.remove(i);
      money+=5;
      i--;
    }

    if (temp.y>gif.get(1).y) {
      diggers.remove(i);
      i--;
    }
  }
}

void animateTowers() {
  for (int i=0; i<tower.size(); i++) {
    Tower temp=tower.get(i);
    temp.act();
    temp.show();
  }
}

void animateBullets() {
  for (int i=0; i<gunBullets.size(); i++) {
    GunBullet temp=gunBullets.get(i);
    temp.act();
    temp.show();
  }

  for (int i=0; i<sniperBullets.size(); i++) {
    SniperLaser temp=sniperBullets.get(i);
    temp.act();
    temp.show();
  }

  for (int i=0; i<graveyard.size(); i++) {
    Graveyard temp=graveyard.get(i);
    temp.act();
    temp.show();
  }
}
