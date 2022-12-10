void buildMode() { //<>// //<>//
  background(beige);
  pathway(30); 
  toolbar(150);

  textAlign(CENTER);
  fill(red);
  textSize(30);

  image(moneyPic, 700, 550);
  text("money: "+money, 725, 600);

  textSize(50);
  fill(black);
  text("BUILD MODE", width/2, 100);

  Button goPlayButton=myButton.get(5);
  goPlayButton.act(); 
  goPlayButton.show();

  Button gunTowerButton=myButton.get(6);
  gunTowerButton.act(); 
  gunTowerButton.show();

  Button sniperTowerButton=myButton.get(7); 
  sniperTowerButton.act(); 
  sniperTowerButton.show();
  
  Button poisonTowerButton=myButton.get(8); 
  poisonTowerButton.act(); 
  poisonTowerButton.show();


  if (goPlayButton.clicked) {
    mode=GAME;
  }

  if (gunTowerButton.clicked) {
    if (money<gunTowerCost) {
      enoughMoney=false;
    } else {
      enoughMoney=true;
      tower.add(new Tower("GUN", mouseX, mouseY, 0, 60, true));
      money-=gunTowerCost;
    }
  }

  if (sniperTowerButton.clicked) {
    if (money<sniperTowerCost) {
      enoughMoney=false;
    } else {
      enoughMoney=true;
      tower.add(new Tower("SNIPER", mouseX, mouseY, 0, 60, true));
      money-=gunTowerCost;
    }
  }
  
  if(poisonTowerButton.clicked){
    if(money<poisonTowerCost){
      enoughMoney=false; 
    }else{
      enoughMoney=true;
      tower.add(new Tower("POISON", mouseX, mouseY, 0, 60, true));
      money-=poisonTowerCost;
    }
  }

  if (!enoughMoney) {
    fill(black);
    text("Not", 730, 620);
    text("Enough Money", 730, 640);
  }

  animateTowers();
  
  for(int i=0; i<tower.size(); i++){
    Tower temp=tower.get(i);
    if(temp.hp<=0){
      tower.remove(i);
    }
  }

  /*Tower newBuildingTower=tower.get(tower.size()-1);
   newBuildingTower.act();
   newBuildingTower.show();*/
}
