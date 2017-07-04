int oldNode = -1;
void checkInput() {
    if (state == "splash") {
        touchSpilX = mouseX > spilPos[0] && mouseX < spilPos[0] + spil.width;
        touchSpilY = mouseY > spilPos[1] && mouseY < spilPos[1] + spil.height;
        if (touchSpilY && touchSpilX) {
            splashDone = true;
        }
        touchHSX = mouseX > highscorePos[0] && mouseX < highscorePos[0] + highscore.width;
        touchHSY = mouseY > highscorePos[1] && mouseY < highscorePos[1] + highscore.height;
        if (touchHSX && touchHSY && !splashDone) {
            link("http://rotendahl.dk/games/brain/reaktion/viewScore.php");
        }
    }
    if (state == "spil" && !gameOver) {
        if (explLevel && mouseY > height / 2 - textHeigt && mouseY < height / 2 +
            textHeigt * 2) {
            explLevel = false;
        }
        for (int i = 0; i < board.nodes.length; i++) {
            if (board.nodes[i].isClicked(mouseX, mouseY) && (i != oldNode ||
                    i == randNode)) {
                if (checkAssign(board.nodes[i].number)) {
                    board.nodes[i].goal = true;
                } else {
                    board.nodes[i].wrong = true;
                    taskTime++;
                }
                if (board.corretLeft <= 0) {
                    readyNextLevel = true;
                }
                oldNode = i;
                mouseX = 0;
                mouseY = 0;
            }
        }
    }
    if (gameOver && mouseY > height * 0.5) {
        assignNr = 0;
        readyNextLevel = true;
        gameOver = false;
        timeLimit = 20;
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
    if (gameOver && mouseY < height * 0.5 && mouseY > 10) {
        state = "highscore";
        mouseX = 0;
        mouseY = 0;
    }
}
