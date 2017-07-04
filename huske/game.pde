PImage orangeBlue;
PImage blueOrange;

class Tile {
    int xPos, yPos, number;
    boolean active, showNumber;
    Tile(x, y) {
        this.xPos = x;
        this.yPos = y;
        this.numer = 0;
        this.active = false;
        this.showNumber = false;
    }
    boolean isClicked(xInput, yInput) {
        int size = blueOrange.width;
        return xInput > xPos && xInput < xPos + blueOrange.width &&
            yInput > yPos && yInput < yPos + blueOrange.height;
    }
    void drawTile() {
        if (this.active) {
            if (this.showNumber) {
                image(blueOrange, this.xPos, this.yPos);
                textSize(orangeBlue.width / 3);
                text(this.number, this.xPos + blueOrange.width / 2, this.yPos +
                    blueOrange.height / 2);
            } else {
                image(orangeBlue, this.xPos, this.yPos);
            }
        }
    }
}

int verTileNr = 6;
int horTileNr = 4;
Tile[] makeRow(int yPos) {
    int xStart = Hline.width * 0.7;
    Tiles row = new Tile[6];
    Tile temp;

    for (int i = 0; i < 6; i++) {
        temp = new Tile(xStart, yPos);
        xStart += blueOrange.width * 1.1
        row[i] = temp;
    }
    return row;
}

class Grid {
    int size;
    ArrayList tiles;
    ArrayList actives;
    Grid() {
        tiles = new ArrayList();
        actives = new ArrayList();
    }
    void fillTiles() {
        int startY = Vline.height * 0.4;
        for (int i = 0; i < horTileNr; i++) {
            tiles.add(makeRow(startY));
            startY += blueOrange.height + 3;
        }
    }
    void drawGrid() {
        for (int i = 0; i < actives.size(); i++) {
            int[] act = actives.get(i);
            tiles.get(act[0])[act[1]].drawTile();
        }
    }
    void setActive(int n) {
        for (int i = 0; i < actives.size(); i++) {
            int[] act = actives.get(i);
            tiles.get(act[0])[act[1]].active = false;
        }
        actives = new ArrayList();
        int nrOfActives = 0;
        while (nrOfActives < n) {
            int row = int(random(0, verTileNr));
            int col = int(random(0, horTileNr));
            if (!tiles.get(col)[row].active) {
                tiles.get(col)[row].active = true;
                tiles.get(col)[row].number = nrOfActives + 1;
                actives.add([col, row]);
                nrOfActives++;
            }
        }
    }
    void hideNrs() {
        for (int i = 0; i < actives.size(); i++) {
            int[] act = actives.get(i);
            tiles.get(act[0])[act[1]].showNumber = false;
        }
    }
    void showNrs() {
        for (int i = 0; i < actives.size(); i++) {
            int[] act = actives.get(i);
            tiles.get(act[0])[act[1]].showNumber = true;
        }
    }
    void scaleTiles() {
        int yStart = Vline.height * 0.4;
        for (int c = 0; c < tiles.size(); c++) {
            int xStart = Hline.width * 0.7;
            for (int r = 0; r < tiles.get(c).length; r++) {
                tiles.get(c)[r].xPos = xStart;
                tiles.get(c)[r].yPos = yStart;
                xStart += blueOrange.width * 1.1;
            }
            yStart += blueOrange.height + 3;
        }
    }
}
