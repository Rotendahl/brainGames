// Global variables
HashMap pics;
PFont font;
Grid grid;
PImage background;
PImage Hline;
PImage Vline;
PImage logo;
PImage spil;
PImage highscore;
PImage orangeBlue;
PImage blueOrange;
PImage bBar;
PImage red;

int oldHeight = height;
int oldWidth  = width;
int speed;

int verTileNr = 5;
int horTileNr = 6;
int tilesLeft = 5;
void setup(){
    jProcessingJS(this, {fullscreen:true, mouseoverlay:true, optmath:true});
    frameRate(30);
    font = loadFont("FFScala.ttf");
    /* @pjs preload="assets/background.png, assets/HBline.png,
       assets/VBline.png, assets/logo.png, assets/spil.png,
       assets/highscore.png, assets/blueOrange.png, assets/orangeBlue.png,
       assets/red.png";
    */
    background = loadImage("assets/background.png");
    Hline      = loadImage("assets/HBline.png");
    Vline      = loadImage("assets/VBline.png");
    logo       = loadImage("assets/logo.png");
    spil       = loadImage("assets/spil.png");
    highscore  = loadImage("assets/highscore.png");
    orangeBlue = loadImage("assets/orangeBlue.png");
    blueOrange = loadImage("assets/blueOrange.png");
    bBar = loadImage("assets/orangeBlue.png");
    red = loadImage("assets/red.png");
    scalePics();
//    grid = new Grid();
//    grid.fillTiles();
    textFont(font);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    grid = new Grid();
    speed = round(height * 0.005);
}

// Main draw loop
String state = "splash";
boolean splashDone = false;



void draw(){
    if(height != oldHeight || width != oldWidth){
        scalePics();
        oldHeight = height;
        oldWidth  = width;
        //grid.scaleTiles();
        mouseX = 0;
        mouseY = 0;
    }
    drawFrame();
    checkInput();
    if(state == "splash"){
        splash(splashDone) ? state = "spil": state = "splash";
        mouseX = 0;
        mouseY = 0;
    }
    if(state == "spil"){
        grid.drawGrid();
        //nextLevel();
        //playLevel();
    }
}
