HashMap scalePics(){
        Hline.resize(width/20, height/50);
        Vline.resize(width/50, height/20);
        background.resize(width, height);
        logo.resize(round(width * 0.6), round(height * 0.6));
        spil.resize(round(width * 0.3), round(height * 0.1));
        highscore.resize(round(width * 0.5), round(height * 0.1));
        orangeBlue.resize(width / (horTileNr + 1), height / (verTileNr + 1));
        red.resize(width / (horTileNr + 1), height / (verTileNr + 1));
        blueOrange.resize(width / (horTileNr + 1), height / (verTileNr + 1));
        bBar.resize(width, Hline.height*3);
}

void drawFrame(){
    image(background, 0, 0);
    int drawWidth = 0;
    while(drawWidth < width){
        if(state == "splash"){
        image(Hline, drawWidth, 0);
    }
        image(Hline, drawWidth, height - Hline.height);
        drawWidth += Hline.width;
    }
    int drawHeight = 0;
    while(drawHeight < height){
        image(Vline, 0, drawHeight);
        image(Vline, width - Vline.width, drawHeight);
        drawHeight += Vline.height;
    }
}
