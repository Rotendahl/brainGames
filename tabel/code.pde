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

boolean loaded = false;
int oldHeight = height;
int oldWidth = width;
int speed;
int secs;
int textHeigt;

LetterGrid lets;

int verTileNr = 5;
int horTileNr = 6;
int tilesLeft = 5;
void setup() {
    jProcessingJS(this, {
        fullscreen: true,
        mouseoverlay: true,
        optmath: true
    });
    frameRate(30);
    font = loadFont("FFScala.ttf");
    /* @pjs preload="../assets/background.png, ../assets/HBline.png,
       ../assets/VBline.png, ../assets/logo.png, ../assets/spil.png,
       ../assets/highscore.png, ../assets/blueOrange.png, ../assets/orangeBlue.png,
       ../assets/red.png";
    */
    background = requestImage("../assets/background.png");
    Hline = requestImage("../assets/HBline.png");
    Vline = requestImage("../assets/VBline.png");
    logo = requestImage("../assets/logo.png");
    spil = requestImage("../assets/spil.png");
    highscore = requestImage("../assets/highscore.png");
    orangeBlue = requestImage("../assets/orangeBlue.png");
    blueOrange = requestImage("../assets/blueOrange.png");
    bBar = requestImage("../assets/orangeBlue.png");
    red = requestImage("../assets/red.png");
    textFont(font);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
}

// Main draw loop
String state = "splash";
boolean splashDone = false;
boolean firstScale = true;
int loadY = 0;
boolean hasDoubled = false;

void draw() {
    if (loaded) {
        if (firstScale) {
            scalePics();
            speed = round(height * 0.002);
            grid = new Grid();
            firstScale = false;
            lets = new LetterGrid();
        }
        if (height != oldHeight || width != oldWidth) {
            textSize(round(orangeBlue.width / 3));
            scalePics();
            oldHeight = height;
            oldWidth = width;
            grid.scaleRows();
            mouseX = 0;
            mouseY = 0;
        }
        drawFrame();
        checkInput();
        if (state == "splash") {
            splash(splashDone) ? state = "spil" : state = "splash";
            mouseX = 0;
            mouseY = 0;
        }
        if (state == "spil") {
            grid.drawGrid();
            if (frameCount % 30 == 0 && !gameOver) {
                secs++;
                if (secs > 8 && !hasDoubled) {
                    speed *= 2;
                    hasDoubled = true;
                }
            }

        }
        if (state == "highscore") {
            lets.drawLetGrid();
        }
    } else {
        rect(0, 0, width * 1000, height * 100);
        fill(51);

        textSize(40);
        fill(255);

        for (int i = 0; i < 10; i++) {
            int yI = (loadY * i + 1) % height - height * 0.1
            text("0", width * 0.1, yI);
            text("1", width * 0.2, yI);
            text("0", width * 0.3, yI);
            text("1", width * 0.4, yI);
            text("0", width * 0.5, yI);
            text("1", width * 0.6, yI);
            text("0", width * 0.7, yI);
            text("1", width * 0.8, yI);
            text("0", width * 0.9, yI);
        }
        str = "Loader, vent et øjeblik..."
        fill(255, 237, 0);
        stroke(73, 172, 218);
        rect(width / 2, height / 2, textWidth(str) * 1.1, height / 10);
        fill(50, 50, 50);
        text(str, width / 2, height / 2);
        loaded = isLoaded();
        loadY > height ? loadY = 0 : loadY += height * 0.01;
    }

    mouseX = 0;
    mouseY = 0;
}
