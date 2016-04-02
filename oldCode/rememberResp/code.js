var game = new Phaser.Game("100", "100", Phaser.CANVAS, '',
{ preload: preload, create: create, update: update, render: render,
resize: onResize });

////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// Variables ///////////////////////////////////

// Images
function preload() {
    game.load.image('background', 'assets/background.png');
    game.load.image('bline', 'assets/bline.png');
    game.load.image('greet', 'assets/greet.png');
    game.load.image('start', 'assets/spil.png');
    game.load.image('highscore', 'assets/highscore.png');
    game.load.image('blueOrange', 'assets/blueOrange.png');
    game.load.image('orangeBlue', 'assets/orangeBlue.png');
}


// Visual variabels
var rectWidth = game.width * 0.02
var borders;
var background;
var scaleRatio;
var GlobX;

// Input variable
var pointer;

// States
var state = "splash";


// Splash screen variabels;
var intro;
var start;
var highscore;


// level variables;
var tiles;


////////////////////////////////////////////////////////////////////////////////
//////////////////////////// Visual functions //////////////////////////////////
var scaleSprite = function(x, y, img){
    var temp;
    temp = game.add.sprite(x, y, img);
    temp.scale.setTo(scaleRatio, scaleRatio);
    temp.anchor.set(0.5);
    return temp;
}

function goFullScreen(){
    game.scale.pageAlignHorizontally = true;
    game.scale.pageAlignVertically = true;
    // using RESIZE scale mode
    game.scale.scaleMode = Phaser.ScaleManager.RESIZE;
}

function onResize(){
    // TODO check if the screen is rotated on stop it.

    for (var i = 0; i < borders.length; i++) {
        borders[i].destroy();
    }
    borders = drawBorders();
    intro = scaleSprite(GlobX, game.height/3, 'greet');
    start = scaleSprite(GlobX, intro.y + game.height/3, 'start');
    highscore = scaleSprite(GlobX, start.y + game.height/6, 'highscore');
}

var drawBorders = function(){
    var lLine = game.add.tileSprite(0, 1, rectWidth, game.height, 'bline');
    var bLine = game.add.tileSprite(0, 1, game.width, rectWidth, 'bline');
    var rLine = game.add.tileSprite(game.width - rectWidth, 1, rectWidth ,
                                    game.height,'bline');
    var tLine = game.add.tileSprite(0, game.height - rectWidth, game.width,
                                    rectWidth, 'bline');
    return [lLine, rLine, bLine, tLine];
}


////////////////////////////////////////////////////////////////////////////////
//////////////////////// Game objects defs /////////////////////////////////////
function Tile(xPos, yPos, size, active){
    this.number = 0;
    this.size = size;
    this.active = active;
    this.ShowNumber = false;
    this.ref = null;
    this.isClicked = function(point){
        return Phaser.Circle.intersectsRectangle(point, this.ref.getBounds());
    }
}

function
////////////////////////////////////////////////////////////////////////////////
///////////////////////////// Game state functions /////////////////////////////
void splashEnd = function(){
    if(state === "start"){
        intro.x = intro.x -5;
        start.x = start.x +5;
        highscore.y = highscore.y - 10;
        highscore.rotation = 4.71239;
    }
    if(intro.x <= rectWidth + intro.width / 2){
        intro.destroy();
    }
    if(start.x >= game.width - rectWidth - start.width / 2){
        start.destroy();
    }
    if(highscore.y <= rectWidth + highscore.height / 2){
        highscore.destroy();
        state = "game"
    }

}


////////////////////////////////////////////////////////////////////////////////
///////////////////////////// Phaser games /////////////////////////////////////
function create() {
    // INIT
    goFullScreen();
    scaleRatio = Phaser.Device.pixelRatio / 2;
    if(Phaser.Device.desktop){
        pointer = game.input.mousePointer;
    }
    else{
        pointer = game.input.pointer1;
    }
    background = game.add.tileSprite(0, 0, game.width, game.height, 'background');
    borders = drawBorders();
    GlobX = game.width/2

    // Splash
    intro = scaleSprite(GlobX, game.height/3, 'greet');
    start = scaleSprite(GlobX, intro.y + game.height/3, 'start');
    highscore = scaleSprite(GlobX, start.y + game.height/6, 'highscore');

    // Game
    tiles = new Tile(300, 300, true, true);
    tiles.ref = game.add.sprite(300, 300, 'blueOrange');

}




function update() {
    // Splash screen
    console.log(state);
    if(state === "splash" || state === "start" ){
        if(pointer.justPressed() &&
          Phaser.Circle.intersectsRectangle(pointer.circle, start.getBounds())){
              state = "start";
        }
        splashEnd();
    }
    if(state === "game"){
            if(pointer.justPressed() && tiles.isClicked(pointer.circle)){
                tiles.ref.visible = false;
            }
    }


}




function render() {

}
