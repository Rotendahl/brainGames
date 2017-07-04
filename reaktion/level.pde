int randNode = -1;
int randNr = int(random(10));
void nextLevel(){
    if(readyNextLevel){
        taskTime = 0;
        assignNr++;
        task = assignNr % 3;
        readyNextLevel = false;
        board.corretLeft = -1;
        explLevel = true;
        timeLimit--;
    }
}


void showTimer(){
    String str = "Tid:" + (timeLimit - taskTime);
    fill(255,237,0);
    stroke(73,172,218);
    strokeWeight(board.rWid/ 5);
    rect(width/2, height*0.9, textWidth(str) * 1.1, textHeigt);
    fill(50, 50, 50);
    text(str, width/2, height*0.9);
}

void getAssignText(){
    if(task == 0){
        str = "Ram de lige tal.\n Få så mange som muligt. \n Tryk for at starte";
        if(board.corretLeft < 0){
            int rights = 0;
            for(int i = 0; i < board.nodes.length; i ++){
                if(board.nodes[i].number % 2 == 0){
                    rights++;
                }
            }
            board.corretLeft = rights;
        }
    }
    if(task == 1){
        str = "Ram den blå cirkel.\n Ram den 15 Gange. \n Tryk for at starte";
        if(board.corretLeft < 0){
            board.corretLeft = 15;
        }
    }

    if(task == 2){
        str = "Løs regnestykket.\n Der er 5 styks. \n Tryk for at starte";
        if(board.corretLeft < 0){
            board.corretLeft = 5;
        }
    }

    stroke(255,237,0);
    fill(73,172,218);
    rect(width/2, height*0.5, textWidth(str) , textHeigt * 3);
    fill(0);
    if(comLevels > 0){
        str = " Godt lavet du!\n" + str;
    }
    text(str, width/2, height*0.5);
    taskTime = 0;

}

boolean checkAssign(numberIn){
    if(board.corretLeft <= 1){
        comLevels++;
    }
    if(task == 0){
        if(numberIn % 2 == 0){
            board.corretLeft--;
            return true;
        }
        return false;
    }

    if(task == 1){
        boolean ans = false;
        if(randNode < 0){
            randNode = int(random(board.nodes.length));
        }
        if(numberIn == board.nodes[randNode].number){
            board.corretLeft--;
            ans = true;
            randNode = int(random(board.nodes.length));
        }
        return ans;
    }


    if(task == 2){
        boolean ans = false;
        if(randNode < 0){
            randNode = int(random(board.nodes.length));
        }
        if(numberIn == board.nodes[randNode].number){
            board.corretLeft--;
            ans = true;
            randNode = int(random(board.nodes.length));
            randNr = int(random(10));
        }
        return ans;
    }


}

void playLevel(){
    board.drawBoard();
    if(explLevel){
        getAssignText();
        for(i = 0; i < board.nodes.length; i++){
            board.nodes[i].active = false;
            board.nodes[i].wrong = false;
            board.nodes[i].goal = false;
        }

    }
    if(!readyNextLevel && !explLevel){
        if(frameCount % 30 == 0){
            taskTime++;
        }

        if(task == 0){
            if(taskTime < timeLimit){
                showTimer();
                for(i = 0; i < board.nodes.length; i++){
                    board.nodes[i].active = true;
                }
            }
        }
        if(task == 1){
            if(taskTime < timeLimit){
                String left = "Tilbage: " + board.corretLeft;
                rect(width/2, height*0.35, textWidth(left) * 1.1 , textHeigt);
                fill(255,255,255);
                text(left, width/2, height*0.35);
                if(randNode < 0){
                    randNode = int(random(board.nodes.length));
                }
                for(i = 0; i < board.nodes.length; i++){
                    i != randNode ? board.nodes[i].active = true:
                    board.nodes[i].active = false;
                }
                showTimer();
            }
        }

        if(task == 2){
            if(taskTime < timeLimit){
                String cal = board.nodes[randNode].number - randNr + " + " + randNr;
                rect(width/2, height*0.35, textWidth(cal) * 1.1 , textHeigt);
                fill(255,255,255);
                text(cal, width/2, height*0.35);
                if(randNode < 0){
                    randNode = int(random(board.nodes.length));
                }
                for(i = 0; i < board.nodes.length; i++){
                    board.nodes[i].active = true;
                }
                showTimer();
            }
        }

        if(taskTime >= timeLimit){
            for(i = 0; i < board.nodes.length; i++){
                board.nodes[i].active = false;
                board.nodes[i].goal = false;
                board.nodes[i].wrong = false;
            }
            gameOver = true;
            String str = "Du nåede det ikke\nMen du klarede " + comLevels +
            " baner";
            textSize(Vline.height);
            stroke(255,237,0);
            fill(73,172,218);
            rect(width/2, height*0.5, textWidth(str) * 1.1 , textHeigt * 3);
            fill(0);
            text(str, width/2, height*0.5);
            fill(255,237,0);
            stroke(73,172,218);
            String msg = "Start igen";
            int msgW = textWidth(msg);
            stroke(150, 0, 0);
            rect(width/2, height*0.9, msgW * 1.1, textHeigt, msgW * 0.2);
            fill(50, 50, 50);
            text(msg, width/2, height*0.9);

            String str = "Gem record";
            fill(255,237,0);
            stroke(0,0, 150);
            rect(width/2 , textHeigt, textWidth(str)*1.1, textHeigt, msgW * 0.2);
            fill(50, 50, 50);
            text(str, width/2 , textHeigt);
        }
    }
}
