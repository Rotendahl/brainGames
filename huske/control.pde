void checkInput() {
    if(state == "splash"){
        touchSpilX = mouseX > spilPos[0]  && mouseX < spilPos[0] + spil.width;
        touchSpilY = mouseY > spilPos[1]  && mouseY < spilPos[1] + spil.height;
        if(touchSpilY && touchSpilX ){
            splashDone = true;
            strokeWeight(10);
            stroke(255);
            fill(0);
        }
    }
    if(state == "spil" && gameStarted && !gameOver){
        for(int i = 0; i < grid.actives.size(); i++){
            int[] act = grid.actives.get(i);
            if(grid.tiles.get(act[0])[act[1]].isClicked(mouseX, mouseY)){
                console.log(nextTile);
                if(grid.tiles.get(act[0])[act[1]].number == nextTile){
                    grid.tiles.get(act[0])[act[1]].showNumber = true;
                    if(nextTile == nrOfTiles){
                        wonLevel = true;
                        secs = 0;
                    }
                    nextTile++;
                }
                else if(grid.tiles.get(act[0])[act[1]].number > nextTile){
                    gameOver = true;
                }
            }
        }
    }
    if(gameOver && mouseY > height*0.9 && mouseX < width/2){
        nrOfTiles = 2;
        next = true;
        gameOver = false;
    }
    if(gameOver && mouseY > height*0.9 && mouseX > width/2){
        nrOfTiles = 2;
        next = true;
        gameOver = false;
        state = "highscore";
    }
}
