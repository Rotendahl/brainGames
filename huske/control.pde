void checkInput() {
    if (state == "splash") {
        touchSpilX = mouseX > spilPos[0] && mouseX < spilPos[0] + spil.width;
        touchSpilY = mouseY > spilPos[1] && mouseY < spilPos[1] + spil.height;
        if (touchSpilY && touchSpilX) {
            splashDone = true;
            strokeWeight(10);
            stroke(255);
            fill(0);
        }
        touchHSX = mouseX > highscorePos[0] && mouseX < highscorePos[0] + highscore.width;
        touchHSY = mouseY > highscorePos[1] && mouseY < highscorePos[1] + highscore.height;
        if (touchHSX && touchHSY && !splashDone) {
            link("http://rotendahl.dk/games/hjerne/huske/viewScore.php");
        }
    }
    if (state == "spil" && gameStarted && !gameOver) {
        for (int i = 0; i < grid.actives.size(); i++) {
            int[] act = grid.actives.get(i);
            if (grid.tiles.get(act[0])[act[1]].isClicked(mouseX, mouseY)) {
                console.log(nextTile);
                if (grid.tiles.get(act[0])[act[1]].number == nextTile) {
                    grid.tiles.get(act[0])[act[1]].showNumber = true;
                    if (nextTile == nrOfTiles) {
                        wonLevel = true;
                        secs = 0;
                    }
                    nextTile++;
                } else if (grid.tiles.get(act[0])[act[1]].number > nextTile) {
                    gameOver = true;
                }
            }
        }
        mouseX = 0;
        mouseY = 0;
    }

    if (state == "highscore") {
        for (int i = 0; i < lets.letters.length; i++) {
            if (lets.letters[i].isClicked(mouseX, mouseY)) {
                lets.name[lets.curLet] = lets.letters[i].letter;
                lets.curLet++;
                mouseX = 0;
                mouseY = 0;
            }
        }
    }

    if (gameOver && mouseX < width * 0.5 && mouseY > height * 0.9) {
        nrOfTiles = 2;
        next = true;
        gameOver = false;
    }

    if (gameOver && mouseX > width * 0.5 && mouseY > height * 0.9) {
        state = "highscore";
        mouseX = 0;
        mouseY = 0;
    }
}
