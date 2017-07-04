int secs;
boolean shows;
int nextTile;
int gameStarted;
boolean gameOver;
boolean wonLevel;
boolean next = true;
int nrOfTiles = 2;


void playLevel() {
    if (!gameStarted) {
        if (secs > nrOfTiles - 1) {
            grid.hideNrs();
            gameStarted = true;
        } else {
            String str = "Spillet starter om: " + (nrOfTiles - secs);
            fill(255);
            stroke(0);
            rect(width / 2, height * 0.9, textWidth(str) * 1.1, blueOrange.height * 0.5);
            fill(0);
            text(str, width / 2, height * 0.9);
        }
    }
    if (frameCount % 30 == 0) {
        secs++;
    }
    if (gameOver) {
        fill(255);
        stroke(255, 0, 0);
        String msg = "Du tabte, prøv igen";
        rect(width / 2, height * 0.94, textWidth(msg) * 1.1, blueOrange.height * 0.5);
        fill(255, 0, 0);
        text(msg, width / 2, height * 0.94);
        grid.showNrs();

    }
    grid.drawGrid();
    if (wonLevel) {
        levelDone();
    }
}



void levelDone() {
    str = "Du vandt med " + nrOfTiles + " brikker!\n" +
        "Næste bane kommer om: " + (3 - secs);
    fill(255);
    stroke(0);
    rect(width / 2, height / 2, textWidth(str) * 1.1, blueOrange.height * 1.5);
    fill(0);
    text(str, width / 2, height / 2);
    if (3 - secs == 0) {
        next = true;
    }
}
