class Tile {
    int xPos, yPos, number;
    boolean hit, wrong;
    Tile(x, y) {
        this.xPos = x;
        this.yPos = y;
        this.numer = 0;
        this.hit = false;
        wrong = false;
    }
    boolean isClicked(xInput, yInput) {
        int size = blueOrange.width;
        return xInput > xPos && xInput < xPos + blueOrange.width &&
            yInput > yPos && yInput < yPos + blueOrange.height;
    }
    void drawTile() {
        gameOver ? 1 + 1 : this.yPos += speed;
        if (!this.hit) {
            image(blueOrange, this.xPos, this.yPos);
            textSize(orangeBlue.width / 2);
            fill(0);
            text(this.number, this.xPos + blueOrange.width / 2, this.yPos +
                blueOrange.height / 2);
        } else {
            wrong ? image(red, this.xPos, this.yPos) :
                image(orangeBlue, this.xPos, this.yPos);
        }
    }
    boolean isDead() {
        return this.yPos > height - Hline.height - blueOrange.height / 2;
    }
}

class Row {
    int yPos;
    int[] numbers;
    Tile[] tiles;
    boolean isDead;
    boolean isWrong;
    Row(y, nrs) {
        isWrong = false;
        isDead = false;
        numbers = nrs;
        yPos = y;
        tiles = new Tile[6];
        int xStart = round(Hline.width * 0.7);
        Tile temp;
        for (int i = 0; i < 6; i++) {
            temp = new Tile(xStart, yPos);
            xStart += blueOrange.width * 1.1
            temp.number = numbers[i];
            tiles[i] = temp;
        }
    }

    void scaleRow() {
        int xStart = round(Hline.width * 0.7);
        Tile temp;
        for (int i = 0; i < 6; i++) {
            temp = new Tile(xStart, yPos);
            xStart += blueOrange.width * 1.1
            temp.number = numbers[i];
            tiles[i] = temp;
        }
    }

    void drawRow() {
        if (tiles[0].isDead()) {
            isDead = true
        }
        for (i = 0; i < tiles.length; i++) {
            tiles[i].drawTile();
        }
        this.yPos = tiles[0].yPos;
    }
}

class Grid {
    Row[] rows;
    int assign;
    int curNr;
    int topRowIndex;
    int botRowIndex;
    boolean nextAssing;
    int randNr;
    int goalTile;
    int rowsLeft = verTileNr + 1;
    int assignIndex;
    Grid() {
        goalTile = -1;
        nextAssing = true;
        botRowIndex = 0;
        assignIndex = 0;
        task = 1;
        int y = -blueOrange.height;
        curNr = 0;
        rows = new Row[verTileNr + 1];
        topRowIndex = verTileNr;
        for (int i = 0; i < verTileNr + 1; i++) {
            int rowNrs = [++curNr, ++curNr, ++curNr, ++curNr, ++curNr, ++curNr];
            rows[i] = new Row(y, rowNrs);
            y -= blueOrange.height * 1.1;
        }
    }

    void nextAssignIndex() {
        assignIndex = (assignIndex + 1) % (verTileNr + 1);
        while (rows[grid.assignIndex].isWrong && !gameOver && grid.rowsLeft > 0) {
            assignIndex = (assignIndex + 1) % (verTileNr + 1);
        }
        assign++;
    }

    void scaleRows() {
        int y = rows[botRowIndex].yPos;
        for (int i = 0; i < rows.length; i++) {
            rows[i].scaleRow();
            if (i != botRowIndex) {
                rows[i].yPos = y;
            }
            y -= blueOrange.height * 1.1;
        }
    }

    // Checks if the bottomrow should be killed and replaced.
    void checkBotRow() {
        if (rows[botRowIndex].isDead) {
            botRowIndex == assignIndex ? nextAssignIndex() : 1 + 1;
            int topY = rows[topRowIndex].yPos + blueOrange.height + 3;
            topRowIndex = botRowIndex;
            int[] newNrs = [++curNr, ++curNr, ++curNr, ++curNr, ++curNr,
                ++curNr, ++curNr
            ];
            oldRow = rows[botRowIndex];
            newRow = new Row(-blueOrange.height * 1.2, newNrs);

            // The old row was not right
            newRow.isWrong = oldRow.isWrong

            if (!oldRow.hit) {
                rowsLeft--;
            }

            if (!(oldRow.hit && !oldRow.isWrong)) {
                newRow.isWrong = true;
                for (int j = 0; j < oldRow.tiles.length; j++) {
                    newRow.tiles[j].hit = true;
                    newRow.tiles[j].wrong = true;
                }
            }
            rows[botRowIndex] = newRow;
            botRowIndex = (botRowIndex + 1) % (verTileNr + 1);
        }

    }

    void drawGrid() {
        console.log("ROWS left" + rowsLeft);
        if (rowsLeft < 0) {
            gameOver = true;
        }
        checkBotRow();
        for (int i = 0; i < rows.length; i++) {
            rows[i].drawRow();
        }
        image(bBar, 0, height - Hline.height * 3);
        textSize(orangeBlue.height / 3.5);
        image(bBar, 0, 0);
        String left = "Du har overlevet i " + secs + " sekunder";
        fill(255);
        text(left, width / 2, Hline.height * 1.2);
        DisplayTask(assign);
        if (gameOver) {
            textSize(round(orangeBlue.width / 3));
            str = "Sejt! \n Du klarede dig i " + secs + " sekunder."
            fill(255, 237, 0);
            stroke(73, 172, 218);
            rect(width / 2, height / 2, textWidth(str) * 1.1, blueOrange.height * 1.5);
            fill(50, 50, 50);
            text(str, width / 2, height / 2);

            fill(255, 237, 0);
            stroke(73, 172, 218);
            String msg = "Start igen";
            int msgW = textWidth(msg);
            stroke(150, 0, 0);
            rect(msgW, height * 0.8, msgW * 1.1, textHeigt, msgW * 0.2);
            fill(50, 50, 50);
            text(msg, 0 + msgW, height * 0.8);

            String str = "Gem record";
            fill(255, 237, 0);
            stroke(0, 0, 150);
            rect(width - textWidth(str), height * 0.8, textWidth(str) * 1.1,
                blueOrange.height * 0.5, blueOrange.height * 0.1);
            fill(50, 50, 50);
            text(str, width - textWidth(str), height * 0.8);

        }
    }

    void DisplayTask(assign) {
        String str;
        int taskNr = assign % 3;
        if (taskNr == 0) {
            str = "Ram noget på 3 tabellen";
        } else if (taskNr == 1) {
            str = "Ram noget på 5 tabellen";
            while (goalTile < 0 && !nextAssing) {
                goalTile = int(random(horTileNr));
            }
            if (nextAssing) {
                randNr = int(random(10));
            }
            nextAssing = false;
        } else if (taskNr == 2) {
            Sting eq = (rows[assignIndex].tiles[goalTile].number + randNr) +
                " - " + randNr;
            goal = rows[assignIndex].tiles[goalTile].number;
            str = "Hvilket tal giver " + eq;
        }
        fill(255);
        text(str, width / 2, height - Hline.height * 1.8);
    }
    boolean checkTask(input) {
        int taskNr = assign % 3;
        if (taskNr == 0) {
            return input % 3 == 0;

        } else if (taskNr == 1) {
            return input % 5 == 0;
        } else if (taskNr == 2 && goalTile >= 0) {
            boolean correct = goal == input;
            goalTile = -1;
            nextAssing = true;
            return correct;
        }
    }

}
