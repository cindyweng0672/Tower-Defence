void chooseMap() {
  background(green);

  textSize(80);
  fill(white);
  textFont(pixelFont);
  text("Choose a Map", 300, 100);

  image(map1, 50, 200);
  image(map2, 450, 200);

  Button map1Button=myButton.get(9);
  Button map2Button=myButton.get(10);

  map1Button.act();
  map1Button.show();
  map2Button.act();
  map2Button.show();

  if (map1Button.clicked) {
    map=1;
    mode=GAME;
  } else if (map2Button.clicked) {
    map=2;
    mode=GAME;
  }
}
