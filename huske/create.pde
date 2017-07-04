void scalePics() {
    Hline.resize(width / 20, height / 50);
    Vline.resize(width / 50, height / 20);
    background.resize(width, height);
    logo.resize(round(width * 0.6), round(height * 0.6));
    spil.resize(round(width * 0.3), round(height * 0.1));
    highscore.resize(round(width * 0.5), round(height * 0.1));
    orangeBlue.resize(width / (verTileNr + 1), height / (horTileNr + 1));
    blueOrange.resize(width / (verTileNr + 1), height / (horTileNr + 1));
    textSize(round(orangeBlue.width / 3));
    textHeigt = blueOrange.height * 0.5;
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
    return background.width != 0 && Hline.width != 0 && Vline.width != 0 &&
        logo.width != 0 && spil.width != 0 && highscore.width != 0 &&
        orangeBlue.width != 0 && blueOrange.width != 0;
}
