int secs;
boolean shows;
int nextTile;
int gameStarted;
boolean gameOver;
boolean wonLevel;
boolean next = true;
int nrOfTiles = 2;
int textHeigt;

void nextLevel() {
    if (next) {
        nrOfTiles++;
        grid.setActive(nrOfTiles);
        grid.showNrs();
        next = false;
        secs = 0;
        nextTile = 1;
        gameStarted = false;
        shows = true;
        gameOver = false;
        wonLevel = false;
    }
}

void playLevel() {
    if (!gameStarted) {
        if (secs > nrOfTiles - 1) {
            grid.hideNrs();
            gameStarted = true;
        } else {
            String str = "Spillet starter om: " + (nrOfTiles - secs);
            stroke(255, 237, 0);
            fill(73, 172, 218);
            rect(width / 2, height * 0.9, textWidth(str) * 1.1, textHeigt);
            fill(0);
            text(str, width / 2, height * 0.9);
        }
    } else if (gameStarted && !gameOver) {
        String str = "Hvad var rækkefølgen?";
        fill(255, 237, 0);
        stroke(73, 172, 218);
        rect(width / 2, height * 0.9, textWidth(str) * 1.1, textHeigt);
        fill(50, 50, 50);
        text(str, width / 2, height * 0.9);
    }
    if (frameCount % 30 == 0) {
        secs++;
    }
    grid.drawGrid();
    if (gameOver) {
        fill(255, 237, 0);
        stroke(73, 172, 218);
        String msg = "Start igen";
        int msgW = textWidth(msg);
        stroke(150, 0, 0);
        rect(msgW * 1.1, height * 0.9, msgW * 1.1, textHeigt, msgW * 0.2);
        fill(50, 50, 50);
        text(msg, 0 + msgW * 1.1, height * 0.9);

        String str = "Gem record";
        fill(255, 237, 0);
        stroke(0, 0, 150);
        rect(width - textWidth(str) * 1.1, height * 0.9, textWidth(str) * 1.1,
            blueOrange.height * 0.5, blueOrange.height * 0.1);
        fill(50, 50, 50);
        text(str, width - textWidth(str) * 1.1, height * 0.9);

        grid.showNrs();

    }
    if (wonLevel) {
        levelDone();
    }
}



void levelDone() {
    str = "Du vandt med " + nrOfTiles + " brikker!\n" +
        "Næste bane kommer om: " + (3 - secs);
    fill(255, 237, 0);
    stroke(73, 172, 218);
    rect(width / 2, height / 2, textWidth(str) * 1.1, blueOrange.height * 1.5);
    fill(50, 50, 50);
    text(str, width / 2, height / 2);
    if (3 - secs == 0) {
        next = true;
    }
}
