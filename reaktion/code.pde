// Global variables
HashMap pics;
PFont font;
Board board;
PImage background;
PImage Hline;
PImage Vline;
PImage logo;
PImage spil;
PImage highscore;
PImage ringBlue;
PImage ringRed;
PImage ringYellow;
PImage ringBlue;
PImage ringGreen;
boolean loaded = false;
int oldHeight = height;
int oldWidth = width;
int secs;
int loadY;
int taskTime = 0;
int task;
int timeLimit = 20;
int comLevels = 0;

boolean explLevel = true;
int verNodesNr = 4;
int horNodesNr = 3;

boolean gameOver;
boolean gameStarted = false;
boolean readyNextLevel = true;

int assignNr = 0;

LetterGrid lets;

void setup() {
    loadY = 0;
    gameOver = false;

    jProcessingJS(this, {
        fullscreen: true,
        mouseoverlay: true,
        optmath: true
    });
    frameRate(30);
    font = loadFont("FFScala.ttf");
    /* @pjs preload="../assets/background.png, ../assets/HBline.png,
       ../assets/VBline.png, ../assets/logo.png, ../assets/spil.png,
       ../assets/highscore.png, ../assets/ringGreen.png, ../assets/ringBlue.png,
       ../assets/ringYellow.png, ../assets/ringRed.png";
    */
    background = requestImage("../assets/background.png");
    Hline = requestImage("../assets/HBline.png");
    Vline = requestImage("../assets/VBline.png");
    logo = requestImage("../assets/logo.png");
    spil = requestImage("../assets/spil.png");
    highscore = requestImage("../assets/highscore.png");
    ringBlue = requestImage("../assets/ringBlue.png");
    ringGreen = requestImage("../assets/ringGreen.png");
    ringYellow = requestImage("../assets/ringYellow.png");
    ringRed = requestImage("../assets/ringRed.png");

    textFont(font);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
}

// Main draw loop

char test = 'A';
String state = "splash";
boolean splashDone = false;
boolean firstScale = true;
void draw() {
    if (loaded) {
        if (firstScale) {
            scalePics();
            board = new Board();
            firstScale = false;
            lets = new LetterGrid();
        }
        if (height != oldHeight || width != oldWidth) {
            scalePics();
            board.scaleBoard();
            oldHeight = height;
            oldWidth = width;
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
            nextLevel();
            playLevel();

        }
        if (state == "highscore") {
            lets.drawLetGrid();
        }

    } else {
        fill(51);
        rect(0, 0, width * 1000, height * 100);

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
