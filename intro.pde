
void intro(){
  
  gif.get(0).act();
  Button startButton=myButton.get(0);
  startButton.act();
  startButton.show();

  textFont(pixelFont);
  fill(white);
  textSize(120);
  text("Tower Defence", 400, 400);

  if (startButton.clicked) {
    mode=CHOOSEMAP;
  }
  
}
