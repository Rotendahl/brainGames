
function tile(xPos, yPos, width, height, number){
    this.move = function(speed){
        this.yPos = this.yPos + speed;
    }
}


function row(speed){
    this.yPos;
    this.numbers;
    this.tiles = [];
    this.makeRow = function(y, height, nrs){
        this.tiles = [
            new tile(10,  y, 80, height, nrs[0]),
            new tile(110, y, 80, height, nrs[1]),
            new tile(210, y, 80, height, nrs[2]),
            new tile(305, y, 80, height, nrs[3]),
            new tile(400, y, 80, height, nrs[4])
        ]
    }
    this.draw = function(){
            for (var i = 0; i < this.tiles.length; i++) {
                this.tiles[i].draw();
                this.tiles[i].move(speed);
            }

    }
}

//
// function game(limt, sped){
//     this.limit = limt;
//     this.speed = sped;
//     this.score = 0;
//     this.rows = [];
//     this.number = 0;
//     this.init = function(){
//         for (var y = 15; y < 400; y += 100) {
//             this.rows[this.rows.length] = new row(this.speed);
//             console.log(this.rows);
//             this.rows[this.rows.length].makeRow(y, 100, [1,2,3,4,5]);
//         }
//     }
    // this.play = function(){
    //     for (var i = 0; i < this.rows.length; i++) {
    //         console.log("HERE");
    //         for (var r = 0; r < this.rows.length; r++) {
    //         this.rows[i].tiles[r].draw();
    //         this.rows[i].tiles[r].move(this.speed);
    //         }
    //     }
    // }
//}

rows = []
var n = 0;
for (var y = 100; y > -8000; y -= 110) {
    r = new row(1.5);
    r.makeRow(y, 100, [++n,++n,++n,++n,++n,]);
    rows[rows.length] = r;
}

var shift = 3;

mouseClicked = function(){
    for (var i = 0; i < rows.length; i++) {
        for(var t = 0; t < rows[i].tiles.length; t++){
            if(rows[i].tiles[t].isClicked(mouseX,mouseY) &&
               rows[i].tiles[t].number % shift === 0){
                rows[i].tiles[t].hit = true;
                shift === 3 ? shift = 4 : shift = 3;
            }
        }
    }
}


//var gm = new game(10, 2);
//gm.init();
var draw = function(){
    background(white);
    //gm.play();

    var del = []
    for (var i = 0; i < rows.length; i++) {
        rows[i].draw();
    }
    stroke(black);
    rect(120, 30, 250, 50);
    shift === 3 ? fill(white) : fill(black);
    textSize(20);
    text("Ram Noget paa " + shift + " Tabelen", 130, 60);
    borders();
}



}};

// Run game
var canvas = document.getElementById("mycanvas");
var pros = new Processing(canvas, sketchProc);
