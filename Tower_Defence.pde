import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

color beige=#f4f1de;
color red=#e07a5f;
color blue=#3d405b;
color green=#81b29a;
color orange=#f2cc8f;
color white=#FFFFFF;
color black=#050505;
color purple=#AE78FC;

int mode=0;
int INTRO=0;
int GAME=1;
int PAUSE=2;
int GAMEOVER=3;
int BUILDMODE=4;
int CHOOSEMAP=5;

int waveNum;
int money;
int gunTowerCost;
int sniperTowerCost;
int poisonTowerCost;
int lives;

int diggerCount; 

ArrayList<GifButton> gif=new ArrayList<GifButton>();
ArrayList<Button> myButton=new ArrayList<Button>();

//Node[] nodes;
ArrayList<Mob> mobby=new ArrayList<Mob>();

ArrayList<Digger> diggers=new ArrayList<Digger>();

ArrayList<Tower> tower=new ArrayList<Tower>();
ArrayList<GunBullet> gunBullets=new ArrayList<GunBullet>();
ArrayList<SniperLaser> sniperBullets=new ArrayList<SniperLaser>();
ArrayList<Graveyard> graveyard=new ArrayList<Graveyard>();
ArrayList<Node> nodes=new ArrayList<Node>();
boolean mouseReleased=false;
boolean wasPressed=false;

boolean enoughMoney;
int map;

PFont pixelFont;
PImage build;
PImage moneyPic;
PImage plankton;
PImage plankton1;
PImage plankton2;
PImage fighting;
PImage sniper;
PImage poison;
PImage map1;
PImage map2;
PImage mud;

int w;
int noMoneyAlertCount;

//sound
Minim minim;
AudioPlayer start, themesong;

void setup() {
  size(800, 800);

  map=1;

  pixelFont=createFont("data/8_bit_arcade/8-bit_Arcade_In.ttf", 30);

  //load images
  build=loadImage("data/build.jpeg");
  moneyPic=loadImage("data/money.jpeg");
  moneyPic.resize(100, 50);
  plankton=loadImage("data/plankton.png");
  plankton.resize(50, 50);
  plankton1=loadImage("data/plankton2.png");
  plankton1.resize(100, 100);
  plankton2=loadImage("data/plankton1.jpeg");
  plankton2.resize(50, 50);
  fighting=loadImage("data/fighting.jpeg");
  fighting.resize(50, 50);
  sniper=loadImage("data/sniper.jpeg");
  sniper.resize(50, 50);
  poison=loadImage("data/poison.jpeg");
  poison.resize(50, 50);
  map1=loadImage("data/map1.png");
  map1.resize(300, 300);
  map2=loadImage("data/map2.png");
  map2.resize(300, 300);
  mud=loadImage("data/mud.png");
  mud.resize(50, 50);

  //nodes

  //nodes=new Node[7];

  //intro
  myButton.add(new Button("start", 400, 600, 200, 100, orange, red));
  myButton.add(new Button("Regular Mob", 725, 150, 100, 50, orange, red));
  myButton.add(new Button("Chonky Mob", 725, 200, 100, 50, orange, red));
  myButton.add(new Button("Speedy Mob", 725, 250, 100, 50, orange, red));
  myButton.add(new Button(build, 725, 700, 100, 100, orange, red));
  myButton.add(new Button("Play", 730, 150, 100, 100, orange, red));
  myButton.add(new Button("GunTower-5", 730, 250, 100, 50, orange, red));
  myButton.add(new Button("SniperTower-5", 730, 300, 100, 50, orange, red));
  myButton.add(new Button("AoETower-10", 730, 350, 100, 50, orange, red));
  myButton.add(new Button("Map 1", 200, 600, 100, 50, beige, blue));
  myButton.add(new Button("Map 2", 600, 600, 100, 50, beige, blue));
  myButton.add(new Button("Restart", 400, 600, 200, 100, beige, orange));
  myButton.add(new Button("Delete", mouseX, mouseY, 100, 50, orange, beige));

  gif.add(new GifButton("backgroundGif", "frame_", "_delay-0.1s.gif", 35, 0, 0, width, height, 1));
  gif.add(new GifButton("pineappleHouse", "frame_", "_delay-0.07s.png", 27, 400, 750, 100, 100, 1));
  gif.add(new GifButton("pineappleHouse", "frame_", "_delay-0.07s.png", 27, 300, 750, 100, 100, 1));

  //mobby.add(new Mob(0, height/8, 1, 0));

  //tower.add(new Tower(100, 50, 0, 60, false));
  //tower.add(new Tower("POISON", 300, 150, 0, 60, false));

  //sound
  minim=new Minim(this);
  start=minim.loadFile("data/musics/i'mReady.wav");
  themesong=minim.loadFile("data/musics/themesong.wav");

  waveNum=0;

  money=15;

  gunTowerCost=5;
  sniperTowerCost=10;
  poisonTowerCost=10;

  lives=1;

  enoughMoney=true;
  
  diggerCount=120;
}

void draw() {
  click();
  if (mode==INTRO) {
    intro();
  } else if (mode==GAME) {
    game();
  } else if (mode==PAUSE) {
    pause();
  } else if (mode==GAMEOVER) {
    gameOver();
  } else if (mode==BUILDMODE) {
    buildMode();
  } else if (mode==CHOOSEMAP) {
    chooseMap();
  } else {
    println("Mode Error: Mode is "+mode);
  }
}

void makeNodes() {
  while (nodes.size()>0) {
    nodes.remove(0);
  }
  if (map==1) {
    nodes.add(new Node(300, height/8, 0, 1));
    nodes.add(new Node(300, height/8+200, 1, 0));
    nodes.add(new Node(600, height/8+200, 0, 1));
    nodes.add(new Node(600, height/8+500, -1, 0));
    nodes.add(new Node(100, height/8+500, 0, -1));
    nodes.add(new Node(100, height/8+300, 1, 0));
    nodes.add(new Node(400, height/8+300, 0, 1));
  } else if (map==2) {
    nodes.add(new Node(100, 100, 0, 1));
    nodes.add(new Node(100, 650, 1, 0));
    nodes.add(new Node(200, 650, 0, -1));
    nodes.add(new Node(200, 100, 1, 0));
    nodes.add(new Node(550, 100, 0, 1));
    nodes.add(new Node(550, 200, -1, 0));
    nodes.add(new Node(300, 200, 0, 1));
    nodes.add(new Node(300, 500, 1, 0));
    nodes.add(new Node(550, 500, -1, 1));
  }
}
