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
    if(state == "spil"){
        for(i = 0; i < grid.rows[grid.botRowIndex].tiles.length; i++){
            if(grid.rows[grid.botRowIndex].tiles[i].isClicked(mouseX, mouseY)
            && !grid.rows[grid.botRowIndex].tiles[i].hit){
                boolean wasWrong;
                if(grid.checkTask(grid.rows[grid.botRowIndex].tiles[i].number)){
                    if(!grid.rows[grid.botRowIndex].tiles[i].hit){
                         tilesLeft++;
                    }
                    wasWrong = false;
                }
                else{
                    if(!grid.rows[grid.botRowIndex].tiles[i].wrong){
                        tilesLeft -= 2;
                    }
                    wasWrong = true;
                }
                grid.assign++;
                for(j = 0; j < grid.rows[grid.botRowIndex].tiles.length; j++){
                    grid.rows[grid.botRowIndex].tiles[j].hit = true;
                    grid.rows[grid.botRowIndex].tiles[j].wrong = wasWrong;
                }
                grid.botRowIndex = (grid.botRowIndex + 1) % 6;
                mouseY = 0;
                mouseX = 0;
            }
        }
    }
}
