void setup() {
    jProcessingJS(this, {
        fullscreen: true,
        mouseoverlay: true,
        optmath: true
    });
    frameRate(30);
    font = loadFont("FFScala.ttf");
    /* @pjs preload="../assets/background.png, ../assets/HBline.png,
       ../assets/VBline.png";
    */
    background = requestImage("../assets/background.png");
    Hline = requestImage("../assets/HBline.png");
    Vline = requestImage("../assets/VBline.png");
    textFont(font);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);
}

void scalePics() {
    Hline.resize(width / 20, height / 50);
    Vline.resize(width / 50, height / 20);
    background.resize(width, height);
    textSize(Hline.height * 3);
    textHeigt = height * 0.15;
}

void drawFrame() {
    image(background, 0, 0);
    int drawWidth = 0;
    while (drawWidth < width) {
        image(Hline, drawWidth, 0);
        image(Hline, drawWidth, height - Hline.height);
        drawWidth += Hline.width;
    }
    int drawHeight = 0;
    while (drawHeight < height) {
        image(Vline, 0, drawHeight);
        image(Vline, width - Vline.width, drawHeight);
        drawHeight += Vline.height;
    }
}

boolean isLoaded() {
    return background.width != 0 && Hline.width != 0 && Vline.width != 0
}

boolean firstLoad = true;

int wtd = 0;
void draw() {
    if (isLoaded) {
        if (firstLoad) {
            scalePics();
            firstLoad = false;
        }
        drawFrame();
        stroke(255, 237, 0);
        fill(73, 172, 218);
        strokeWeight(20);
        if (mouseY > width / 2) {
            link("http://rotendahl.dk/games/brain/");
        }
    }
    mouseY = 0;
    mouseX = 0;
}
