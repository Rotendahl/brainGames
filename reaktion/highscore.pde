hasSent = false;
class Letter {
    int xPos, yPos, lwidth;
    String letter;

    Letter(x, y, letter) {
        this.xPos = x;
        this.yPos = y;
        this.letter = letter;
        this.lwidth = textWidth(" A ");
    }
    boolean isClicked(xInput, yInput) {
        return this.xPos - width / 20 < xInput && xInput < this.xPos + width / 20 &&
            yPos - Vline.height < yInput && yInput < yPos + Vline.height;
    }

    void drawLetter() {
        fill(255, 237, 0);
        stroke(73, 172, 218);
        rect(xPos, yPos, textWidth(" a "), Vline.height * 1.5);
        textSize(Hline.height * 3);
        fill(0);
        text(letter, xPos, yPos);
    }
}

class LetterGrid {
    int curLet = 0;
    String[] name = {"X", "X", "X", "X" };
    String[] alph = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L',
        'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
    };
    Letter[] letters = new Letter[alph.length];
    LetterGrid() {
        letWidth = textSize(" a ");
        int xCor = Hline.width * 4;
        int yCor = Vline.height * 3;
        for (int i = 0; i < alph.length; i++) {
            if (xCor > width - Hline.width * 3) {
                xCor = Hline.width * 4;
                yCor += Vline.height * 3;
            }
            this.letters[i] = new Letter(xCor, yCor, alph[i]);
            xCor += width / 10;
        }
    }
    void drawLetGrid() {
        for (int i = 0; i < letters.length; i++) {
            letters[i].drawLetter();
        }
        fill(255, 237, 0);
        stroke(73, 172, 218);
        String str = "Du hedder: " + join(this.name, "");
        rect(width / 2, height * 0.8, textWidth(str) * 1.1, Vline.height * 2);
        fill(0);
        text(str, width / 2, height * 0.8);

        if (name[3] != "X" && !hasSent) {
            String url = "http://rotendahl.dk/games/hjerne/reaktion/postScore.php?game=reaktion&";
            String pName = "name=" + join(this.name, "");
            String score = "&score=" + comLevels;
            link(url + pName + score);
            hasSent = true;
        }
    }
}
