var sketchProc = function(pros) {
with (pros) {

// Game settings
var screenX = 500;
var screenY = 700;
frameRate(30);
size(screenX, screenY);

var white  = color(255,255,255);
var black  = color(0,0,0);
var blues   = color(27,102,140);
var orange = color(228,167,57);


var borders = function()
{
    stroke(blues);
    strokeWeight(10);
    line(0, 0, screenX, 0);
    line(0, 0, 0, screenY);
    line(0, screenY-1, screenX, screenY-1);
    line(screenX-1, 0, screenX-1, screenY);
}

function tile(xPos, yPos, size, active){
    // Instance vars
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.number = 0;
    this.active = active;
    this.ShowNumber = false;

    this.setActive = function(state){
        this.active = state;
    }

    this.isClicked = function(xInput, yInput){
        return  xInput > this.xPos && xInput < this.xPos + size &&
                yInput > this.yPos && yInput < this.yPos + size;
    }

    this.draw = function(){
        if(this.active){
            pros.stroke(orange); // blue

            pros.strokeWeight(5);
            if(this.ShowNumber){
                pros.stroke(blues); // blue
                pros.fill(orange);
                pros.rect(xPos, yPos, size, size);
                pros.textSize(35);
                pros.fill(blues);
                pros.text(this.number, xPos + size/2 - size/5, yPos + size/2 + size/5);
            }
            else{
                pros.fill(blues);
                pros.rect(xPos, yPos, size, size);
            }

        }
    }
}


function gridObj(tileSize, screenX, screenY){
    this.tileSize = tileSize;
    this.grid = [];
    this.active = [];
    this.maxTiles = 0;
    this.makeGrid = function(){
        this.grid = [];
        for(var y = 25; y < screenY - this.tileSize; y += this.tileSize + 10){
            // make row
            var row = [];
            for(var i = 13; i < screenX - this.tileSize ; i += this.tileSize + 10){
                row[row.length] = new tile(i, y, this.tileSize, false);
                this.maxTiles++;
            }
            this.grid[this.grid.length] = row;
        };
    }

    this.SelectActive = function(n){
        var tiles = 0;
        while(tiles < n && tiles < this.maxTiles){
            row = Math.floor(Math.random()*this.grid.length);
            col = Math.floor(Math.random()*this.grid[row].length);
            if(this.grid[row][col].active === false){
                this.grid[row][col].setActive(true);
                this.grid[row][col].number = tiles + 1;
                this.grid[row][col].ShowNumber = true;
                tiles++;
            }
        }
    }

    this.draw = function(){
        for(var row = 0; row < this.grid.length; row++){
            for(var col = 0; col < this.grid[row].length; col++){
                this.grid[row][col].draw();
            }
        }
    }

    this.hide = function(){
        for(var row = 0; row < this.grid.length; row++){
            for(var col = 0; col < this.grid[row].length; col++){
                this.grid[row][col].ShowNumber = false;
            }
        }
    }
    this.show = function(){
        for(var row = 0; row < this.grid.length; row++){
            for(var col = 0; col < this.grid[row].length; col++){
                this.grid[row][col].ShowNumber = true;
            }
        }
    }

}

var tileSize = 70;
grid = new gridObj(tileSize, screenX, screenY);


// Images
var greetImg     = loadImage("pics/greeting.png");
var gameIntroImg = loadImage("pics/gameIntro.png");
var gameOverImg  = loadImage("pics/gameOver.png");
var nextLevelImg  = loadImage("pics/nextLevel.png");
//lev2ExplImg  = loadImage("lev2Expl.png");
//lev2StatsImg = loadImage("lev2Stats.png");
//endImg       = loadImage("end.png");


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
        if(secs > 3){
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
