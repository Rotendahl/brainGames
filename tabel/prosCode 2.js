// Control
var states = ["splashScreen", "gameIntro", "game", "nextLevel", "gameOver", "debug"];
var curState = 0;
// Input
mouseClicked = function(){
    if(states[curState] === "splashScreen" || states[curState] === "gameIntro"){
        curState++;
        secs = 0;
    }

    if(states[curState] === "gameOver"){
        curState = 2;
        ClickedTile = 0;
        nrOfTiles = 2;
        score = 0;
        grid.makeGrid();
        grid.SelectActive(nrOfTiles);
        secs = 0;
    }

    if(states[curState] === "nextLevel"){
        curState = 2;
        ClickedTile = 0;
        nrOfTiles++;
        score++;
        grid.makeGrid();
        grid.SelectActive(nrOfTiles);
        secs = 0;
    }

    // ClickedTile
    if(states[curState] === "game"){
        for(var row = 0; row < grid.grid.length; row++){
            for(var col = 0; col < grid.grid[row].length; col++){
                var tile = grid.grid[row][col];
                if(tile.isClicked(mouseX, mouseY) && tile.active && !tile.ShowNumber){
                    if(tile.number != ClickedTile + 1){
                        grid.show();

                        curState = 4; //Game over
                    }
                    tile.active = false;
                    ClickedTile++;
                    if(ClickedTile === nrOfTiles){
                        curState = 3;
                    }
                }
            }
        }
    }

}

var tiles = 2;
var frames = 0;
var secs = 0;

// debug
//curState = 2

var ClickedTile = 0;
var nrOfTiles = 2;
var score = 0
grid.makeGrid();
grid.SelectActive(nrOfTiles);
var draw = function(){
    background(white);
    if(states[curState] === "splashScreen"){
        image(greetImg, 0, -10);
    }
    if(states[curState] === "gameIntro"){
        image(gameIntroImg, 0, -10);
    }

    if(states[curState] === "gameOver"){
        image(gameOverImg, 0, -10);
        fill(blues);
        textSize(30);
        text(""+score, 360,373);
    }

    if(states[curState] === "nextLevel"){
        image(nextLevelImg, 0, -10);
    }

    if(states[curState] === "game"){
        grid.draw();
        if(secs > nrOfTiles ){
            grid.hide();
        }
    }

    // End loop states
    borders();
    frames++;
    if(frames >= 20){
        secs++;
        frames = 0;
    }
}



}};

// Run game
var canvas = document.getElementById("mycanvas");
var pros = new Processing(canvas, sketchProc);
