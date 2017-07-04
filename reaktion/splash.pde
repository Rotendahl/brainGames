
int[] spilPos = {0, 0};
int[] highscorePos = {0, 0};
void splashDraw(){
    image(logo, width/2 - logo.width/2, height/4 - logo.height/3);
    spilPos[0] = round(width/2 - spil.width/2);
    spilPos[1] = round(height/4 - logo.height/3 + logo.height + height * 0.02)
    image(spil, spilPos[0], spilPos[1]);
    highscorePos[0] = width/2 - highscore.width/2;
    highscorePos[1] = height/4 - logo.height/3 + logo.height + height * 0.04 +
    spil.height;
    image(highscore, highscorePos[0], highscorePos[1]);
}

float scale = 1.0;
boolean splash(boolean next){
    if(next){
        scale -= 0.05
        logo.resize(round(width * 0.6 * scale), round(height * 0.6 * scale));
        spil.resize(round(width * 0.3 * scale), round(height * 0.1 * scale));
        highscore.resize(round(width * 0.5 * scale), round(height * 0.1 * scale));
    }
    splashDraw();
    if(scale < 0.1){

    }
    return scale < 0.1;
}
