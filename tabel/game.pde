class Tile {
    int xPos, yPos, number;
    boolean hit, wrong;
    Tile(x, y){
         this.xPos  = x;
         this.yPos  = y;
         this.numer = 0;
         this.hit   = false;
         wrong = false;
    }
    boolean isClicked(xInput, yInput){
        int size = blueOrange.width;
        return xInput > xPos && xInput < xPos + blueOrange.width &&
               yInput > yPos && yInput < yPos + blueOrange.height;
    }
    void drawTile(){
        gameOver ? 1 +1 : this.yPos += speed;
        if(!this.hit){
            image(blueOrange, this.xPos, this.yPos);
            textSize(orangeBlue.width/ 2);
            fill(0);
            text(this.number, this.xPos + blueOrange.width/2, this.yPos +
                 blueOrange.height/2);
        }
        else{
            wrong ? image(red, this.xPos, this.yPos) :
            image(orangeBlue, this.xPos, this.yPos);
        }
    }
    boolean isDead(){
        return this.yPos > height - Hline.height - blueOrange.height / 2;
    }
}

class Row{
    int yPos;
    int[] numbers;
    Tile[] tiles;
    boolean isDead;
    Row (y, nrs){
        isDead = false;
        numbers = nrs;
        yPos = y;
        tiles = new Tile[6];
        int xStart = round(Hline.width * 0.7);
        Tile temp;
        for(int i = 0; i < 6; i ++){
            temp = new Tile(xStart, yPos);
            xStart += blueOrange.width * 1.1
            temp.number = numbers[i];
            tiles[i] = temp;
        }
    }
    void drawRow(){
        if(tiles[0].isDead()){
            isDead = true
        }
        for(i = 0; i < tiles.length; i++){
            tiles[i].drawTile();
        }
        this.yPos = tiles[0].yPos;
   }
}

class Grid{
    Row[] rows;
    int assign;
    int curNr;
    int topRowIndex;
    int botRowIndex;
    boolean nextAssing;
    int randNr;
    int goalTile;
    Grid(){
        goalTile = -1;
        nextAssing = true;
        botRowIndex = 0;
        task = 1;
        int y = -blueOrange.height;
        curNr = 0;
        rows = new Row[verTileNr +1];
        topRowIndex = verTileNr;
        int goalTile;
        for(int i = 0; i < verTileNr+1; i++){
            int rowNrs = [++curNr, ++curNr, ++curNr, ++curNr, ++curNr, ++curNr]);
            rows[i] = new Row(y, rowNrs);
            y -=  blueOrange.height * 1.1;
        }

    }
    void drawGrid(){
        for(int i = 0; i < rows.length; i++){
            if(rows[i].isDead){
                int topY = rows[topRowIndex].yPos + blueOrange.height + 3;
                int[] newNrs = [++curNr, ++curNr, ++curNr, ++curNr, ++curNr,
                               ++curNr, ++curNr];
                topRowIndex = i;
                oldRow = rows[i];
                newRow = new Row(-blueOrange.height* 1.2, newNrs);
                for(int j = 0; j < oldRow.tiles.length ; j ++){
                    if(oldRow.tiles[j].hit && oldRow.tiles[j].wrong){
                        newRow.tiles[j].hit = true;
                        newRow.tiles[j].wrong = true;
                    }
                }
                rows[i] = newRow;
            }
            rows[i].drawRow();
        }
        image(bBar,0, height - Hline.height*3);
        textSize(orangeBlue.height / 3);
        image(bBar,0, 0);
        String left = "Liv tilbage:" + tilesLeft;
        fill(255);
        text(left, width /2 , Hline.height * 1.2 );
        DisplayTask(assign);
        if(tilesLeft < 0){
            gameOver = true;
            tilesLeft = 0;
        }
        if(gameOver){
            str = "Du klarede det godt!"
            fill(255);
            stroke(0);
            rect(width/2, height/2, textWidth(str) * 1.1, blueOrange.height*2);
            fill(0);
            text(str, width/2, height/2);
        }
    }

    void DisplayTask(assign){
        String str;
        int taskNr = assign % 3;
        if(taskNr == 0){
            str = "Ram noget på 3 tabellen";
        }
        else if(taskNr == 1){
            str = "Ram noget på 5 tabellen";
            while(goalTile < 0 && !nextAssing){
                goalTile = int(random(horTileNr));
                console.log("Ny GT er: " + goalTile);
            }
            if(nextAssing){
                randNr = int(random(10));
            }
            nextAssing = false;
        }
        else if(taskNr == 2){
            // TODO THIS DOESN't Work
            Sting eq = (rows[botRowIndex].tiles[goalTile].number + randNr) +
                       " - " + randNr;
            goal = rows[botRowIndex].tiles[goalTile].number;
            str = "Hvilket tal giver " + eq;
        }
        fill(255);
        text(str, width/2, height - Hline.height * 1.8);
    }
    boolean checkTask(input){
        int taskNr = assign % 3;
        if(taskNr == 0){
            return input % 3 == 0;

        }
        else if(taskNr == 1){
            return input % 5 == 0;
        }
        else if(taskNr == 2 && goalTile > 0){
            boolean correct = rows[botRowIndex].tiles[goalTile].number == input;
            console.log("Svaret er " + rows[botRowIndex].tiles[goalTile].number +
            " hvilket er " + correct);
            goalTile = -1;
            nextAssing = true;
            return correct;
        }
    }

}
