void gameOver() {
  background(red);
  fill(beige);

  textFont(pixelFont);
  textSize(100);
  textAlign(CENTER);
  text("Game Over", 400, 400);

  Button restartButton=myButton.get(11);
  restartButton.act();
  restartButton.show();

  if (restartButton.clicked) {
    mode=GAME;

    lives=5;
    money=15;
    waveNum=0;

    while (tower.size()>0) {
      for (int i=0; i<tower.size(); i++) {
        tower.remove(i);
        i--;
      }
    }

    while (mobby.size()>0) {
      for (int i=0; i<mobby.size(); i++) {
        mobby.remove(i);
        i--;
      }
    }

    while (diggers.size()>0) {
      for (int i=0; i<diggers.size(); i++) {
        diggers.remove(i);
        i--;
      }
    }

    while (gunBullets.size()>0) {
      for (int i=0; i<gunBullets.size(); i++) {
        gunBullets.remove(i);
        i--;
      }
    }

    while (graveyard.size()>0) {
      for (int i=0; i<graveyard.size(); i++) {
        graveyard.remove(i);
        i--;
      }
    }

    while (sniperBullets.size()>0) {
      for (int i=0; i<sniperBullets.size(); i++) {
        sniperBullets.remove(i);
        i--;
      }
    }
  }
}
