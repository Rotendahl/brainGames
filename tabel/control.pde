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
            link("http://rotendahl.dk/games/brain/tabel/viewScore.php");
        }
    }
    if (state == "spil") {
        for (i = 0; i < grid.rows[grid.assignIndex].tiles.length; i++) {
            if (grid.rows[grid.assignIndex].tiles[i].isClicked(mouseX, mouseY) &&
                !grid.rows[grid.assignIndex].tiles[i].hit) {
                boolean wasWrong;
                if (grid.checkTask(grid.rows[grid.assignIndex].tiles[i].number)) {
                    wasWrong = false;
                } else {
                    if (!grid.rows[grid.assignIndex].tiles[i].wrong) {
                        grid.rowsLeft--;
                        grid.rows[grid.assignIndex].isWrong = true;
                    }
                    wasWrong = true;
                }
                grid.rows[grid.assignIndex].hit = true;
                for (j = 0; j < grid.rows[grid.assignIndex].tiles.length; j++) {
                    grid.rows[grid.assignIndex].tiles[j].hit = true;
                    grid.rows[grid.assignIndex].tiles[j].wrong = wasWrong;
                }
                grid.nextAssignIndex();
                mouseY = 0;
                mouseX = 0;
            }
        }
        if (gameOver && mouseY > height * 0.7 && mouseX < width / 2) {
            grid = new Grid();
            gameOver = false;
            speed = round(height * 0.002);
            secs = 0;
        }
        if (gameOver && mouseY > height * 0.7 && mouseX > width / 2) {
            gameOver = false;
            state = "highscore";
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
}
